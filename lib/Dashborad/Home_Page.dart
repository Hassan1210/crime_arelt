import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crimealert/Dashborad/Side_Bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crimealert/Complain/location.dart';
import 'package:crimealert/Complain/complain.dart';
import 'package:crimealert/SpeedDial/Call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crimealert/login_system/wellcome_screen.dart';
import 'package:crimealert/Suggestion/Total.dart';
import 'package:crimealert/Contact Us/Contact Us.dart';
import 'package:connectivity/connectivity.dart';

Location location = Location();
const googlenearby = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
const type = 'police';
const Api  = 'AIzaSyBxzqB4G1i9FsG4xiZ60D938_CK415mTFU';
dynamic Police_data;

 int total =0;
 int pending =0;
 int approved =0;
 int rejected =0;
 String? Id;
 bool IsInternet = true;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    check_Internet();
    get_data();
  }
  check_Internet() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi)
      {
        setState(() {
          IsInternet = true;
        });
      }
    else{
      setState(() {
        IsInternet = false;
      });
    }
  }
  getId()async{
    final user = FirebaseAuth.instance;
    Id = await user.currentUser!.uid;
  }
  get_data()async{
    await getId();
    var firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/$Id')
        .where('status', isEqualTo: 'Approved');
    var snapshot = await firstQuery.get();
    int count = snapshot.size;
      approved = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/$Id')
        .where('status', isEqualTo: 'Pending');
     snapshot = await firstQuery.get();
     count = snapshot.size;
    pending = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/$Id');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    total = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/$Id')
        .where('status', isEqualTo: 'Rejected');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    rejected = count;
    print(pending);
    print(total);
    print(approved);
    print(rejected);
  }
  @override
  Widget build(BuildContext context) {
    return IsInternet?Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 3,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(FontAwesomeIcons.alignLeft),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        title: Text('Dashboard'),
        actions: [
          IconButton(onPressed: (){
            showDialog( barrierDismissible: false,context: context, builder: (_){
              return Confirmation() ;
            });
          }, icon: Icon(FontAwesomeIcons.signOutAlt))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Slider(),
          ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1 - 287,
              child: Stack(
                children: [
                 Column(
                   children: [
                     Row(
                       children: [
                         CardButton(image: 'images/Button1.jpg',text: 'Complain',onpress:()=>navigation(context,1),),
                         CardButton(image: 'images/Button2.jpg',text: 'Suggestion',onpress:()=>navigation(context,2)),
                       ],
                     ),
                     Row(
                       children: [
                         CardButton(image: 'images/Button3.jpg',text: 'Guidance',onpress:()=>navigation(context,3)),
                         CardButton(image: 'images/Button4.jpg',text: 'Emergency Calls',onpress:()=>navigation(context,4)),
                       ],
                     ),
                   ],
                 ),
                  // IconButton(onPressed: ()async{
                  //   await location.getLocation();
                  //   NearbyLocation nearby = NearbyLocation('$googlenearby?types=$type&rankby=distance&location=${location.latitude},${location.longitude}&key=$Api');
                  //   Police_data = await nearby.getNearByLocation();
                  //   insert();
                  //   // print(Police_data['results'][0]['name']);
                  //   // print(Police_data['results'][0]['plus_code']['global_code']);
                  // }, icon: Icon(
                  //   Icons.ten_k
                  // ),),
                  Positioned(
                    bottom :-4,
                    left: -7,
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 1+ 12,
                      child: SvgPicture.asset(
                        'images/masjid.svg',
                        color: Colors.green,
                      ),
                    )
                  )
                ],
              ),
            ),
        ],
      ),
    ):Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:50,right: 50),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:40),
                        Center(child: Text('Warning!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.red),)),
                        SizedBox(height: 10,),
                        Text('No Internet!',style: TextStyle(fontSize: 18,fontFamily: 'Segoe UI',fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text('Make sure your device in connected to internet..',style: TextStyle(fontSize: 18),),
                        SizedBox(height: 2,),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(onPressed: ()async{
                            await check_Internet();
                          }, child: Text('Try again'),
                            style: TextButton.styleFrom(
                                primary: Colors.black,
                                textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: -50,
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: AssetImage('images/internet.gif')
                ))
          ],
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {

  CardButton({required this.image,required this.text,required this.onpress});
  final String image;
  final String text;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onpress,
        child: Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Card(
                elevation: 20,
                  child: Column(
                children: [
                  Image.asset(image.toString(),fit: BoxFit.fill,height: 110,width: 190,),
                  SizedBox(height: 10,),
                  Text(text.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              )),
            ),
      )
    )
    );
  }
}

class Slider extends StatefulWidget {
  const Slider({Key? key}) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          SliderImage(image:'images/Slider1.jpg'),
          SliderImage(image:'images/Slider2.jpg'),
          SliderImage(image:'images/Slider3.jpg'),
          SliderImage(image:'images/Slider4.jpg'),
          SliderImage(image:'images/Slider5.jpg'),
        ],
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          autoPlayCurve: Curves.easeInOut,
          reverse: true,
          enlargeCenterPage: true,
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          scrollDirection: Axis.vertical,
          viewportFraction: 0.90,
        ));
  }
}

class SliderImage extends StatelessWidget {
  SliderImage({required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

void navigation(BuildContext context,int index){
  switch(index){
    case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Complain(uid: Id.toString(),)));
      break;
    case 4:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Call()));
      break;
    case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Total(uid: Id.toString(),)));
      break;
    case 3:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
      break;
  }
}

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                Text('Do You want to logout from this account?',style: TextStyle(fontSize: 18,fontFamily: 'Segoe UI'),),
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
                    TextButton(onPressed: (){
                      final GoogleSignIn googleSignIn = GoogleSignIn();

                      try {
                        if (true) {
                          googleSignIn.signOut();
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => WellcomeScreen(),
                              ),
                                  (route) => false);
                        }
                      } catch (e) {
                      }
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
    );
  }
}