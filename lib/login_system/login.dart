import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:crimealert/login_system/register.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';
import 'google signIn.dart';
import 'forget password.dart';
import 'contact.dart';

String? password;
String? email;
bool showSpinner = false;


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  void initState() {

    super.initState();
    showSpinner =false;
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future login(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
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
      setState(() {
        showSpinner = false;
      });
    }
  }

  void loginuser() async{
    dynamic result = await login(email.toString(), password.toString());
    if(result == null){
      print("no login");
    }
    else {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => Home(
          ),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
      print(result.toString());
    }

  }


  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Container(
                    height: MediaQuery.of(context).size.height * .20,
                    width: MediaQuery.of(context).size.width * .80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/login.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    )),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Start with singing",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                ),
                Form(
                    key: formkey,
                    autovalidate: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: TextFormField(
                            onChanged: (value){
                              email = value;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'example@gmail.com',
                                hintStyle: TextStyle(color: Colors.green),
                                labelStyle: TextStyle(color: Colors.green),
                                prefixIcon: Icon(
                                  Icons.mail,
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
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Required*'),
                              EmailValidator(errorText: 'Not a valid email'),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextFormField(
                            validator: RequiredValidator(errorText: 'Required*'),
                            obscureText: true,
                            onChanged: (value){
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
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                                },
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width * .80,
                          height: 55,
                          color: Colors.green,
                          child: new Text('Login',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0)),
                          elevation: 18.0,
                          clipBehavior: Clip.antiAlias,
                          onPressed: () {
                            setState(() {
                              showSpinner = true;
                            });
                            if (formkey.currentState!.validate()) {
                              loginuser();
                              print('validate');
                            } else {
                              print('not validate');
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          },
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'or Connect using!',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    print('hello');
                    GoogleSignInLogin google = GoogleSignInLogin();
                    var user = await google.signInwithGoogle();
                    if(user != null)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Home(
                        )
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                    child: Container(
                        padding: EdgeInsets.all(1.0),
                        color: const Color(0xff4285F4),
                        child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage('images/google.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                child: new Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        )),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have a account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text(
                        " Signup",
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



