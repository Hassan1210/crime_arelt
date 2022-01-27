
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'location.dart';
import 'package:crimealert/Complain/nearby location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'file.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';



String? SavedFile = '';

String? Com_Category;
Location location = Location();
const googlenearby = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
const type = 'police';
const Api  = 'AIzaSyBxzqB4G1i9FsG4xiZ60D938_CK415mTFU';
dynamic Police_data;
bool IsLocation = false;
var addressController = new TextEditingController();
bool IsLocationOk = false;
bool IsDetailOk = false;

String address = '';
String? name;
String? email;
String? phone;
String? details;
int count = 0;
String? UserId;
String? date;
bool isPressed = false;


class UserData extends StatefulWidget {
  UserData({required this.category});
  final String category;

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  fetch() async{
    final user = await FirebaseAuth.instance.currentUser;
    UserId = user!.uid;
    try{
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get()
          .then((ds) {
        email = ds['email'];
        name = ds['name'];
        phone = ds['phone'];
      });
      print(email);
      print(name);
    }catch(e){
      print(e.toString());
    }
  }
  selected_file(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text('File is attach successfully...'),
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Com_Category = widget.category;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crime Reporting'),
          centerTitle: true,
          backgroundColor: Colors.green,
          elevation: 4,
          leading: IconButton(
            onPressed: (){
              _willPopCallback();
              Navigator.pop(context);
            },
            icon:Icon(FontAwesomeIcons.arrowLeft)
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _willPopCallback();
                  Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => Home(),
                      ),
                      (route) => false);
                },
                icon: Icon(FontAwesomeIcons.home))
          ],
        ),
          floatingActionButton: SpeedDial(
            child: Icon(Icons.attach_file,size: 30,),
            visible: true,
            backgroundColor: Colors.green,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            onOpen: () => print('OPENING DIAL'),
            onClose: () => print('DIAL CLOSED'),
            tooltip: 'Speed Dial',
            heroTag: 'speed-dial-hero-tag',
            foregroundColor: Colors.white,
            elevation: 8.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                  child: Icon(FontAwesomeIcons.file,color: Colors.green,),
                  backgroundColor: Colors.white,
                  label: 'Files',
                  onTap: () async{
                    SavedFile = await UploadFile().select_file(1);
                    print(SavedFile);
                    if(SavedFile !=null)
                      selected_file();
                  }
              ),
              SpeedDialChild(
                child: Icon(Icons.image,color: Colors.green),
                backgroundColor: Colors.white,
                label: 'Camera',
                onTap: () async{
                  SavedFile = await UploadFile().select_file(2);
                  print(SavedFile);
                  if(SavedFile !=null)
                    selected_file();
                }
              ),
              SpeedDialChild(
                child: Icon(Icons.camera,color: Colors.green),
                backgroundColor: Colors.white,
                label: 'Video',
                onTap: () async{
                  SavedFile = await UploadFile().select_file(3);
                  print(SavedFile);
                  if(SavedFile !=null)
                    selected_file();
                })
            ],
          ),
        body: SafeArea(
          child:  FutureBuilder(
             future: fetch(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return UserInformation();
                }}),
        ),
      ),
    );
  }
}

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  void getLocation()async{
    await location.getLocation();
    NearbyLocation nearby = NearbyLocation('$googlenearby?types=$type&rankby=distance&location=${location.latitude},${location.longitude}&key=$Api');
    Police_data = await nearby.getNearByLocation();
  }
  void initState(){
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return  ListView(
              children: [
                Container(
                  height: 56,
                  child: Center(
                      child: Text(
                    'Enter Detail',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 0, right: 30),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'Name',
                          hintText: name.toString(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 0, right: 30),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'Email',
                          hintText: email.toString(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 0, right: 30),
                      child: TextField(
                        enabled: false,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'Phone',
                          hintText: phone.toString(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 0, right: 30),
                      child: TextField(
                        controller: addressController,
                        enabled: true,
                        onChanged: (value) {
                          address = value;
                          print(address);
                          if(address.length == 0)
                            setState(() {
                              IsLocationOk = false;
                            });
                          else
                            setState(() {
                              IsLocationOk = true;
                            });
                        },
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () async{
                                setState(() {
                                  addressController.text = location.address.toString();
                                  IsLocation = true;
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: IsLocation?Colors.green:Colors.black,
                              )),
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'Address',
                          hintText: 'Enter Address',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 30, top: 0, right: 30),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'Complain Category',
                          hintText: Com_Category.toString(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    SizedBox(height: 45,),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 0, right: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          label: Text('Enter Complain Details'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                        ),
                        minLines:
                            6, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        onChanged: (value) {
                          details = value;
                          setState(() {
                           count = details!.length;
                          });
                          if(details!.isEmpty)
                            setState(() {
                              IsDetailOk = false;
                                                  });
                          else if(details!.length > 500){
                          setState(() {
                          IsDetailOk = false;
                          });}
                          else
                            setState(() {
                              IsDetailOk = true;
                            });

                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('$count/500',style: TextStyle(color: Colors.red),)),
                    ),
                    SizedBox(height: 35,),
                    ElevatedButton(
                      onPressed:(IsDetailOk&&IsLocationOk)||(IsDetailOk&&IsLocation)? () async{
                      showDialog( barrierDismissible: false,context: context, builder: (_){
                        return Confirmation();
                      });

                      }:null,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                    ),
                    SizedBox(height: 40,),
                  ],
                )
              ],
            );
      }
    }

 insert()async{
  date = await getCurrentDate();
  CollectionReference databaseRef = FirebaseFirestore.instance.collection('/Complains/6IR67bEeqSuWOtEraR3m/$UserId');
  final ref = FirebaseDatabase.instance.reference();
  String id = ref.push().key.toString();
  if(SavedFile != null)
    SavedFile = await UploadFile().upload(SavedFile,id);

  await databaseRef.add({
    'id'  : id,
    'date': date.toString(),
    'complain': details,
    'address' : IsLocation?location.address:address,
    'police_station' : 'jckxj',
    'code': 'kfsfj',
    'category': Com_Category,
    'file':   SavedFile == null?'Nil':SavedFile,
    'status':'Pending'
  });
  SavedFile = null;
  print("jfsjfs");
  print(SavedFile);

 }
Future<String>getCurrentDate() async{
  var date = new DateTime.now().toString();

  var dateParse = DateTime.parse(date);

  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

  return formattedDate.toString();
}
Future<bool> _willPopCallback() async {
  IsLocation = false;
  IsLocationOk = false;
  IsDetailOk = false;
  SavedFile = null;
  count = 0;
  addressController.clear();
  return true;
}

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isPressed,
      child: AlertDialog(
        content: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Container(
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:40),
                  Center(child: Text('Confirmation?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),)),
                  SizedBox(height: 10,),
                  Text('Do You want to submit your Complain?',style: TextStyle(fontSize: 18,fontFamily: 'Segoe UI'),),
                  SizedBox(height: 10,),
                  Text('Please Click Yes!',style: TextStyle(fontSize: 18),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: ()async{
                        Navigator.pop(context);
                      }, child: Text('No',style: TextStyle(color: Colors.red),),
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                        ),
                      ),
                      TextButton(onPressed: () async{
                        setState(() { isPressed = true; });
                        await insert();
                        setState(() { isPressed = false; });

                        await _willPopCallback();
                        Navigator.pop(context);
                        showDialog(barrierDismissible: false,
                            context: context, builder: (_){
                              return Success();
                            });
                      }, child: Text('Yes',style: TextStyle(color: Colors.green),),
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
            Positioned(
                top: -50,
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.cyan,
                    backgroundImage: AssetImage('images/Confimation.gif')
                ))
          ],
        ),
      ),
    );
  }
}


class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  Future<bool> _willPopCallback() async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: AlertDialog(
        content: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:40),
                  Center(child: Text('Success!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.lightGreen),)),
                  SizedBox(height: 10,),
                  Text('Your Complain is submitted Successfully',style: TextStyle(fontSize: 18,fontFamily: 'Segoe UI'),),
                  SizedBox(height: 10,),
                  Text('Thank You!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
                    }, child: Text('Ok'),
                      style: TextButton.styleFrom(
                          primary: Colors.black,
                          textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: -50,
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightGreen,
                    backgroundImage: AssetImage('images/success.gif')
                ))
          ],
        ),
      ),
    );
  }
}
