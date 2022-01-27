import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



String? details;
int count = 0;
String? email;
bool IsDetailOk = false;
bool IsOk = false;

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crime Reporting'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4,
        leading: IconButton(
            onPressed: (){
              // _willPopCallback();
              Navigator.pop(context);
            },
            icon:Icon(FontAwesomeIcons.arrowLeft)
        ),
        actions: [
          IconButton(
              onPressed: () {
                // _willPopCallback();
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
      body:ListView(
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
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value){
                    email = value;
                    if(email.toString().isEmpty)
                      {
                        setState(() {
                          IsOk = false;
                        });
                      }
                    else{
                      IsOk = true;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 30, top: 0, right: 30),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('Enter Your Query'),
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
                      });
                    }
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
                onPressed:(IsOk== true && IsDetailOk==true)?(){
                showDialog(barrierDismissible:false,context: context,builder: (_){
                  return Confirmation();
                });
                }:null,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ],
          )
        ],
      ) ,
    );
  }
}
insert()async{
  CollectionReference databaseRef = FirebaseFirestore.instance.collection('ContactUs');

  await databaseRef.add({
    'email':email,
    'details': details,
  });

}
Future<bool> _willPopCallback() async {
  IsDetailOk = false;
  count = 0;
  return true;
}
class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  bool isPressed = false;
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
                  Text('Do You want to submit your Query?',style: TextStyle(fontSize: 18,fontFamily: 'Segoe UI'),),
                  SizedBox(height: 10,),
                  Text('Please Click Yes!',style: TextStyle(fontSize: 18),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: ()async{
                       Navigator.pop(context);
                      }, child: Text('No',style: TextStyle(color: Colors.red)),
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                        ),
                      ),
                      TextButton(onPressed: ()async{
                        setState(() { isPressed = true; });
                        await insert();
                        setState(() { isPressed = false; });

                        await _willPopCallback();
                        Navigator.pop(context);
                        showDialog(barrierDismissible: false,
                            context: context, builder: (_){
                              return Success();
                            });
                      }, child: Text('Yes',style: TextStyle(color: Colors.green)),
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
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
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
              height: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Center(
                      child: Text(
                        'Success!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.lightGreen),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your Query is submitted Successfully',
                    style: TextStyle(fontSize: 18, fontFamily: 'Segoe UI'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Thank You!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                                (route) => false);
                      },
                      child: Text('Ok'),
                      style: TextButton.styleFrom(
                          primary: Colors.black,
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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
                    backgroundImage: AssetImage('images/success.gif')))
          ],
        ),
      ),
    );
  }
}