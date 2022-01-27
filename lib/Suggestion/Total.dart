import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'content.dart';
import 'suggestion.dart';



int total = 0;
int acknolg = 0;
int impl  = 0;
bool istrue = true;


class Total extends StatefulWidget {

  Total({required this.uid});
  final String uid;

  _TotalState createState() => _TotalState();
}
class _TotalState extends State<Total> {
  @override
  void initState() {
    super.initState();
    get_data();
  }
  bool istrue = true;
  get_data()async{
    var firstQuery = FirebaseFirestore.instance
        .collection('/Suggestion/CiW0uQoS1PqneyAuK5Pz/${widget.uid}')
        .where('status', isEqualTo: 'Im');
    var snapshot = await firstQuery.get();
    int count = snapshot.size;
    impl = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Suggestion/CiW0uQoS1PqneyAuK5Pz/${widget.uid}')
        .where('status', isEqualTo: 'Ak');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    acknolg = count;
    firstQuery = FirebaseFirestore.instance
        .collection('/Suggestion/CiW0uQoS1PqneyAuK5Pz/${widget.uid}');
    snapshot = await firstQuery.get();
    count = snapshot.size;
    total = count;
    setState(() {
      istrue = false;
    });
    print(total);
    print(acknolg);
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Suggestion()));
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
                          'My Suggestion',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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
                        text: 'Total Suggestion',
                        color: Total_Complain,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      CardButton(
                        no: impl.toString(),
                        onpress: () {},
                        text: 'Implemented',
                        color: Approved,
                      ),
                      CardButton(
                        no: acknolg.toString(),
                        onpress: () {},
                        text: 'Acknowledged',
                        color: Pending,
                      ),

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
                                  letterSpacing: 2),
                            ))
                      ],
                    ),
                  )),
            )
        )
    );
  }
}