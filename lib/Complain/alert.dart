import 'package:flutter/material.dart';
import 'category.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  String? Value = 'Personal Responsibility';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(child: Text('Select Role',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
        ),
        content: Container(
          height: 280,
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    Radio(
                      value: 'Personal Responsibility',
                      groupValue: Value,
                      onChanged: (String? value) {
                        setState(() {
                          Value = value;
                        });
                      },
                    ),
                    SizedBox(width: 18,),
                    Text('Personal Complain')
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Radio(
                    value: 'Complain as Social\nResponsibility',
                    groupValue: Value,
                    onChanged: (String? value) {
                      setState(() {
                        Value = value;
                      });
                    },
                  ),
                  SizedBox(width: 20,),
                  Text('Complain as Social\nResponsibility')
                ],
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Category()));
              }, child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  )
              ),
              SizedBox(height: 10,),
              OutlinedButton(onPressed: (){
                Navigator.pop(context);
              },
                child:Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 20),) ,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                  shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ));
  }
}


