import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crimealert/login_system/login.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? password;
  String? cpassword;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  changePassword(String password) async{
    final user = FirebaseAuth.instance.currentUser;
    await user!.updatePassword(password);
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text('Password is Changed Successfully!\n Please Login again... '),
        duration: Duration(seconds: 5),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 4,
          title: Text(
            'Crime Reporting',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => Home(),), (route) => false);
            }, icon: Icon(FontAwesomeIcons.home))
        ],
      ),
      body: ListView(
        children: [ Container(height: 56,child: Center(child: Text('Change Password',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),),
          SizedBox(
            height: 30,
          ),
          Form(
            key: formkey,
            autovalidate: true,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 20, left: 30, right: 30),
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText: 'Enter your new password',
                        labelStyle: TextStyle(color: Colors.green),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        )),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'),
                      MaxLengthValidator(15,
                          errorText:
                          'Password less than 15 characters'),
                      MinLengthValidator(6,
                          errorText:
                          'Password greater than 6 characters'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 30, right: 30),
                  child: TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        cpassword = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Enter your confirm new password',
                          labelStyle: TextStyle(color: Colors.green),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0),
                          )),
                      validator: (cpassword) {
                        if (password != cpassword) {
                          return 'Password are not same';
                        }
                      }),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      await changePassword(password.toString());
                    }
                  },
                  child: Text('Change Password'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
