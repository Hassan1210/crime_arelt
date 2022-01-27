import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crimealert/login_system/login.dart';
import 'package:crimealert/login_system/register.dart';
import 'contact.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                      },
                      child: CircleAvatar(radius: 17,backgroundColor:Colors.green,
                      child: Icon(
                        Icons.message,
                        color: CupertinoColors.white,
                      ),),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *.10,
              ),
              Text("Get Started",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
              SizedBox(height: 30,),
              Text("Start with singing in or singing up!",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 15,
              ),),
              SizedBox(
                height: MediaQuery.of(context).size.height *.03,
              ),
              Container(
                height: MediaQuery.of(context).size.height *.30,
                width: MediaQuery.of(context).size.width *.80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/cr.png'),
                    fit: BoxFit.fill,
                ),
                  shape: BoxShape.circle,
              )
              ),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width *.80,
                height: 55,
                color: Colors.green,
                child: new Text('Sign up',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(35.0) ),
                elevation: 18.0,
                clipBehavior: Clip.antiAlias,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                  );
                },
              ),
              SizedBox(height: 30,),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width *.80,
                height: 55,
                color: Colors.white70,
                child: new Text('login',
                    style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(35.0) ),
                elevation: 18.0,
                clipBehavior: Clip.antiAlias,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
              SizedBox(height: 30,),
              Text('Version 2.0.1',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15,
                ),)
            ],
          ),
        ),
      ),

    );
  }
}
