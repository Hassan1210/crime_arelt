import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';




class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? email;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void snackBar(Text text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:text,
        duration: Duration(seconds: 5),
      ),
    );
  }
  Future restPassword(String email)async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pop(context);
      snackBar(Text('The link has been send to your email...'));
    }on FirebaseAuthException
    catch(e){
      String error = e.message.toString() ;
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        desc: error,
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                        ),
                      ),
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Text('Rest Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                Container(
                    height: MediaQuery.of(context).size.height * .30,
                    width: MediaQuery.of(context).size.width * .80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/login.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    )
                ),
                SizedBox(height: 30,),
                Form(
                  key: formkey,
                  autovalidate: true,
                  child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30,bottom: 20,left: 30,right: 30),
                    child: TextFormField(
                      onChanged: (value){
                        email = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'example@gmail.com',
                          labelStyle: TextStyle(color: Colors.redAccent),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.redAccent,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.redAccent, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.redAccent, width: 2.0),
                          )),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Required*'),
                        EmailValidator(errorText: 'Not a valid email'),
                      ]),
                    ),
                  ),
                    ElevatedButton(
                        onPressed:()async{
                          if(formkey.currentState!.validate())
                            {
                              restPassword(email.toString());
                            }
                        },
                        child:Text('Send Email'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                    )

                ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
