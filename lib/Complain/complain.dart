import 'package:flutter/material.dart';
import 'constent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';
import 'alert.dart';
import 'view Complain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


String? userid;
int approved = 0;
int pending = 0;
int total = 0;
int rejected = 0;

class Complain extends StatefulWidget {

  Complain({required this.uid});
   final String uid;

  _ComplainState createState() => _ComplainState();
}
class _ComplainState extends State<Complain> {
  @override
  void initState() {
    super.initState();
    userid = widget.uid;
    get_data();
  }
  bool istrue = true;
  get_data()async{
    var firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/${widget.uid}')
        .where('status', isEqualTo: 'Approved');
    var snapshot = await firstQuery.get();
    int count = snapshot.size;
    approved = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/${widget.uid}')
        .where('status', isEqualTo: 'Pending');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    pending = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/${widget.uid}');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    total = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Complains/6IR67bEeqSuWOtEraR3m/${widget.uid}')
        .where('status', isEqualTo: 'Rejected');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    rejected = count;
    print(pending);
    print(total);
    print(approved);
    print(rejected);
    setState(() {
      istrue = false;
    });
  }
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(barrierDismissible: false,
              context: context, builder: (_){
            return MyDialog();
          });
          print('hhhh');
        },
        child: Icon(
          FontAwesomeIcons.plus,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: istrue,
        color: Colors.black,
        opacity: .8,
        child: Stack(
          children: [
            Positioned(
              top: 230,
              left: 63,
                bottom: 0,
                child: Container(
                  height: 500,
                   width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Background.png')
                    )
                  ),
            )
            ),
          Column(
            children: [
              Container(
                height: 56,
                child: Center(
                    child: Text(
                  'My Complains',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,),
                )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CardButton(
                    no: total.toString(),
                    onpress: () {},
                    text: 'Total Complain',
                    color: Total_Complain,
                  )
                ],
              ),
              Row(
                children: [
                  CardButton(
                    no: approved.toString(),
                    onpress: () {},
                    text: 'Approved',
                    color: Approved,
                  ),
                  CardButton(
                    no: pending.toString(),
                    onpress: () {},
                    text: 'Pending',
                    color: Pending,
                  ),
                  CardButton(
                    no: rejected.toString(),
                    onpress: () {},
                    text: 'Rejected',
                    color: Rejected,
                  )
                ],
              )

            ],
          ),
          ]
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  CardButton(
      {required this.no,
      required this.onpress,
      required this.text,
      required this.color});
  final String no;
  final VoidCallback onpress;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: (){
                if(text == 'Total Complain')
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewComplain(uid: userid.toString(),)));
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            no.toString(),
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            text.toString(),
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            ),
                          ))
                    ],
                  ),
                )),
              ),
            )
        )
    );
  }
}


