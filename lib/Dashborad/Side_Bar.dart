import 'package:crimealert/Contact%20Us/Contact%20Us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crimealert/Profile/Update_Profile.dart';
import 'package:crimealert/login_system/wellcome_screen.dart';
import 'package:crimealert/Term and Condition/term and condition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crimealert/Change Password/change_password.dart';
import 'package:crimealert/SpeedDial/Call.dart';
import 'package:crimealert/Complain/complain.dart';
import 'package:crimealert/Suggestion/Total.dart';
import 'package:crimealert/Contact Us/Contact Us.dart';



String? email;
String? name;
String? Images;

int total =0;
int pending =0;
int approved =0;
int rejected =0;

String? userid;

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}
class _SidebarState extends State<Sidebar> {
  void initState() {
    super.initState();
    fetch();
    get_data();
  }
  getId()async{
    final user = FirebaseAuth.instance;
    userid = await user.currentUser!.uid;
  }
  get_data()async{
    await getId();
    var firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/$userid')
        .where('status', isEqualTo: 'Approved');
    var snapshot = await firstQuery.get();
    int count = snapshot.size;
    approved = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/$userid')
        .where('status', isEqualTo: 'Pending');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    pending = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/$userid');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    total = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/$userid')
        .where('status', isEqualTo: 'Rejected');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    rejected = count;
    print(pending);
    print(total);
    print(approved);
    print(rejected);
  }
  fetch() async{
    final user = await FirebaseAuth.instance.currentUser;
    print(user!.uid);

    try{
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get()
          .then((ds) {
        email = ds['email'];
        name = ds['name'];
        Images = ds['image'];
      });
      print(email);
      print(name);
    }catch(e){
      print(e.toString());


    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Row(
          children: [
            Container(
              color: Sidebar_Color_Small,
              height: MediaQuery.of(context).size.height * 1,
              width:  MediaQuery.of(context).size.width * .25,
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(FontAwesomeIcons.arrowLeft,
                    color: Icons_Color,
                    size: 25,),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        RoundButton(icon: 'images/contract.png',onpress: ()=>RoundButtonPage(context,0),),
                        SizedBox(height: 30,),
                        RoundButton(icon: 'images/query.png',onpress: ()=>RoundButtonPage(context,1)),
                        SizedBox(height: 30,),
                        RoundButton(icon: 'images/headphone.png',onpress: ()=>RoundButtonPage(context,2)),
                        SizedBox(height: 30,),
                        RoundButton(icon: 'images/telephone.png',onpress: ()=>RoundButtonPage(context,3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Sidebar_Color_Large,
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * .75,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      child: FutureBuilder(
                         future: fetch(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting: return CircularProgressIndicator();
                              default:
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                else
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: Images.toString(),
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: 80.0,
                                          height: 80.0,

                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 4,
                                                color: Colors.green),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  color: Colors.black.withOpacity(0.1),
                                                  offset: Offset(0, 10)
                                              )
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Container(
                                          width: 80,
                                          height:80,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: Colors.green,),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10))
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage('images/profile.png'))
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15,),
                                      Text(name.toString(),style: Email_Name,),
                                      SizedBox(height: 5,),
                                      Text(email.toString(),style: Email_Name,),
                                    ],
                                  );
                            }
                          }
                      ),
                    ),
                    SizedBox(height: 20,),
                    Divider(thickness: 2,),
                    SizedBox(height: 25,),
                    ListMenu(icon: Icon(FontAwesomeIcons.userAlt,size: 25,color: Colors.black,), text: Text('Update Profile',style: Sidebar_Text,),onpress: ()=>navigationPage(context,0),),
                    ListMenu(icon: Icon(FontAwesomeIcons.key,size: 25,color: Colors.black), text: Text('Change Password',style: Sidebar_Text,),onpress: ()=>navigationPage(context,2)),
                    Divider(thickness: 2,),
                    ListMenu(icon: Icon(Icons.assignment,size: 25,color: Colors.black), text: Text('Term & Condition',style: Sidebar_Text,),onpress: ()=>navigationPage(context,1)),
                    ListMenu(icon: Icon(FontAwesomeIcons.infoCircle,size: 25,color: Colors.black), text: Text('About Us',style: Sidebar_Text,),onpress: ()=>navigationPage(context,0)),
                    ListMenu(icon: Icon(FontAwesomeIcons.phoneAlt,size: 25,color: Colors.black), text: Text('Contact Us',style: Sidebar_Text,),onpress: ()=>navigationPage(context,3)),
                    Divider(thickness: 2,),
                    ListMenu(icon: Icon(FontAwesomeIcons.signOutAlt,size: 25,color: Colors.black), text: Text('Sign Out',style: Sidebar_Text,),onpress: ()=>navigationPage(context,5)),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

class ListMenu extends StatelessWidget {
  ListMenu({required this.icon,required this.text,required this.onpress});
  final Icon icon;
  final Text text;
  final VoidCallback  onpress;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: icon,
        title: text,
        onTap: onpress,
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  RoundButton({required this.icon,required this.onpress});
  final String  icon;
  final VoidCallback  onpress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onpress,
      child: Image.asset(icon,height: 35,width: 35,color: Colors.green,),
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      elevation: 6,
      fillColor: RoundButton_Color,
    );
  }
}
void RoundButtonPage(BuildContext context,int index)
{
  Navigator.pop(context);
  switch(index){
    case 0:
      Navigator.push(context,MaterialPageRoute(builder: (context) => Complain(uid: userid.toString(),)));
      break;
    case 1:
      Navigator.push(context,MaterialPageRoute(builder: (context) => Total(uid: userid.toString())));
      break;
    case 3:
      Navigator.push(context,MaterialPageRoute(builder: (context) => Call() ));
      break;
    case 2:
      Navigator.push(context,MaterialPageRoute(builder: (context) =>ContactUs()));
      break;

  }
}
void navigationPage(BuildContext context,int index)
{
  Navigator.pop(context);
  switch(index){
    case 0:
      Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfilePage()));
      break;
    case 1:
      Navigator.push(context,MaterialPageRoute(builder: (context) => TermAndCondition()));
      break;
    case 2:
      Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePassword()));
      break;
    case 3:
      Navigator.push(context,MaterialPageRoute(builder: (context) => ContactUs()));
      break;
    case 4:
      Navigator.push(context,MaterialPageRoute(builder: (context) => NewScreen()));
      break;
    case 5:
      {
        showDialog( barrierDismissible: false,context: context, builder: (_){
          return Confirmation();
        });
      break;

  }
}
}

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: null,
    );
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


