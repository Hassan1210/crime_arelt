import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

bool Isok = true;
int index = 0;

class ViewComplain extends StatefulWidget {
  ViewComplain({required this.uid });
    final String uid;

  @override
  State<ViewComplain> createState() => _ViewComplainState();
}

class _ViewComplainState extends State<ViewComplain> {
  void initState() {
    super.initState();
    index = 0;
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
        body: SafeArea(
            child:StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance
                    .collection('/Complains/6IR67bEeqSuWOtEraR3m/${widget.uid}')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return new Center(child: CircularProgressIndicator());
                  return new ListView(children:getExpenseItems(snapshot,index));
                })
        ));
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot,int index) {
    return snapshot.data!.docs
        .map((doc) => DataTable(
        headingRowHeight:index == 0?60:0,
        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green),
        dataRowColor:index++%2==1?MaterialStateColor.resolveWith((states) => Color(0XFFD3D3D3)):MaterialStateColor.resolveWith((states) => Colors.white) ,
        columns:[
          DataColumn(label: Text('Category')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Status')),
        ], rows: [
      DataRow(cells: [
        DataCell(Text(doc['category'])),
        DataCell(Text(doc['date'])),
        DataCell(Card( color:doc['status'].toString()=='Pending'?Colors.amberAccent:doc['status']=='Rejected'?Colors.redAccent:Colors.green,child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(doc['status'],style: TextStyle(fontWeight: FontWeight.bold) ,),
        )),)
      ]),
    ]),)
        .toList();
  }
}
