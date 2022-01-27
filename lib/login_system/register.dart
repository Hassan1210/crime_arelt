import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crimealert/login_system/login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'contact.dart';

String? password;
String? email;
String? name;
String? cpassword;
bool showSpiner = false;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSpiner =false;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future register(String email, String password) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      users.doc(result.user!.uid).set({
        'name':name,
        'email':email,
        'image' : '',
        'phone' : '',
      });
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String error = e.message.toString();
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
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                showSpiner = false;
              });
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void createuser() async {
    dynamic result = await register(email.toString(), password.toString());
    if (result == null) {
      print("not register");
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Login()));

      print(result.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpiner,
          child: SingleChildScrollView(
            child: Column(
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
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                        },
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Let Get Started!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Create account to get more feature",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                ),
                Form(
                    autovalidate: true,
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: TextFormField(
                            validator: RequiredValidator(errorText: 'Required'),
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Name',
                                labelStyle: TextStyle(color: Colors.green),
                                hintStyle: TextStyle(color: Colors.green),
                                prefixIcon: Icon(
                                  Icons.people_outline,
                                  color: Colors.green,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 0.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Required'),
                              EmailValidator(errorText: 'Not a valid Email'),
                            ]),
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'example@gmail.com',
                                labelStyle: TextStyle(color: Colors.green),
                                hintStyle: TextStyle(color: Colors.green),
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.redAccent,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 0.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: TextFormField(
                            obscureText: true,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Required'),
                              MaxLengthValidator(15,
                                  errorText:
                                      'Password less than 15 characters'),
                              MinLengthValidator(6,
                                  errorText:
                                      'Password greater than 6 characters'),
                            ]),
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: "Enter Password",
                                labelStyle: TextStyle(color: Colors.green),
                                hintStyle: TextStyle(color: Colors.green),
                                prefixIcon: Icon(Icons.lock_open,
                                    color: Colors.green),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 0.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              cpassword = value;
                            },
                            validator: (cpassword) {
                              if (password != cpassword) {
                                return 'Password are not same';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                hintText: "Enter Confirm Password",
                                labelStyle: TextStyle(color: Colors.green),
                                hintStyle: TextStyle(color: Colors.green),
                                prefixIcon: Icon(Icons.lock_open,
                                    color: Colors.green),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 0.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width * .80,
                          height: 55,
                          color: Colors.green,
                          child: new Text('Create',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0)),
                          elevation: 18.0,
                          clipBehavior: Clip.antiAlias,
                          onPressed: () {
                            setState(() {
                              showSpiner = true;
                            });
                            if (formkey.currentState!.validate()) {
                              createuser();
                              print('validate');
                            } else {
                              print('not validate');
                              setState(() {
                                showSpiner = false;
                              });
                            }
                          },
                        ),
                      ],
                    )),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        " Login here",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
