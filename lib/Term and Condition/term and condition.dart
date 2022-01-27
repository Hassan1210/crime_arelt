import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.green,
        title: Text('Crime Reporting'),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => Home(),), (route) => false);
          }, icon: Icon(FontAwesomeIcons.home))
        ],
      ) ,
      body: ListView(
        children: [
          Container(height: 56,child: Center(child: Text('Term & Condition',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                text: '1.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Introduction',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 )
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'Welcome to',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                      text: ' CrimeArelt',
                      style: TextStyle(fontWeight: FontWeight.bold, )
                  ),
                  TextSpan(
                      text: ' app.',
                      style: TextStyle(color: Colors.black, fontSize: 18.0 )
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'Our Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'Your agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'If you do not agree with (or cannot comply with) Agreements, then you may not use the Service, but please let us know by emailing at',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                      text: ' hch33129@gmail.com ',
                      style: TextStyle(fontWeight: FontWeight.bold, )
                  ),
                  TextSpan(
                      text: 'so we can try to find a solution. These Terms apply to all visitors, users and others who wish to access or use Service.',
                      style: TextStyle(color: Colors.black, fontSize: 18.0 )
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                text: '2. ',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Accounts',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 )
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'When you create an account with us, you guarantee that you are above the age of 18, and that the information you provide us is accurate, complete, and current at all times. Inaccurate, incomplete, or obsolete information may result in the immediate termination of your account on Service.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'We reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders in our sole discretion.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                text: '3. ',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                      text: 'CopyRight Policy',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 )
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'We respect the intellectual property rights of others. It is our policy to respond to any claim that Content posted on Service infringes on the copyright or other intellectual property rights (“Infringement”) of any person or entity.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'You may be held accountable for damages (including costs and attorneys’ fees) for misrepresentation or bad-faith claims on the infringement of any Content found on and/or through Service on your copyright.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                text: '4. ',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Governing Law',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 )
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'These Terms shall be governed and construed in accordance with the laws of Pakistan, which governing law applies to agreement without regard to its conflict of law provisions.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
    ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                text: '5. ',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Contact Us',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 )
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child:RichText(
              text: TextSpan(
                text: 'Please send your feedback, comments, requests for technical support by email: hch33129@gmail.com.',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),


        ],
      ),



    );
  }
}
