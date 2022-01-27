import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';
import 'package:url_launcher/url_launcher.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  _CallState createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crime Reporting'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4,
        actions: [
          IconButton(
              onPressed: () {
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
      body: ListView(
        children: [
          Container(
            height: 56,
            child: Center(
                child: Text(
                  'Speed Dial',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
          ),
          SizedBox(height: 40,),
          CardCall(text: 'Rescue',number: '1122',image: 'https://www.pakworkers.com/wp-content/uploads/2014/04/Rescue-1122-Punjab-Logo.jpg',),
          CardCall(text: 'Police',number: '15',image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Former_logo_of_Punjab_Police_Pakistan.svg/1200px-Former_logo_of_Punjab_Police_Pakistan.svg.png',),
          CardCall(text: 'Edhi',number: '115',image: 'https://www.boundlesstech.net/assets/images/clients/Edhi.png',),
          CardCall(text: 'Chhippa',number: '+92-21-111-92-1020 ',image: 'https://upload.wikimedia.org/wikipedia/commons/9/9e/Chhipa_logo.jpg',),
          CardCall(text: 'Fire Brigade',number: '16',image: 'https://t4.ftcdn.net/jpg/00/60/17/09/360_F_60170904_EKpMnRLsSiyWz749pnqyo5UMrp3e4Vu8.webp',),
          CardCall(text: 'Ranger',number: '1101',image: 'https://upload.wikimedia.org/wikipedia/en/1/1f/Pakistan_Rangers_Sindh_Logo.png',),
          CardCall(text: 'Railway',number: '117',image: 'https://contactnumbers.pk/wp-content/uploads/2021/04/pakistan-railways-helpline-number.jpg',),
          CardCall(text: 'Other?',number: '',image: 'https://w7.pngwing.com/pngs/549/162/png-transparent-question-mark-question-mark-logo-question-check-mark.png',),

          SizedBox(height: 40,)

        ],
      ),
    );
  }
}

class CardCall extends StatelessWidget {
  CardCall({required this.text,required this.number,required this.image});
  final String text;
  final String number;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(radius:23,backgroundColor: Colors.black12,backgroundImage: NetworkImage(image),),
                  SizedBox(width: 20,),
                  Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              GestureDetector(
                onTap: (){launch('tel:$number');
                print('hello');},
                child: CircleAvatar(radius: 20,backgroundColor: Colors.green,
                child: Icon(Icons.call,color: Colors.white,),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
