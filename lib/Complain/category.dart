import 'package:flutter/material.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'UserData.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                height: 56,
                child: Center(
                    child: Text(
                      'My Complains',
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
                  CategoryButton(image: 'https://media.istockphoto.com/photos/hooded-person-holding-a-lighter-in-front-of-burning-house-picture-id154945598?k=20&m=154945598&s=612x612&w=0&h=3xrLdxqd91bvnH6XOwrLfRaiJJmsTif6vvMLIO1OBsA=',
                    text: 'Arson',),
                  CategoryButton(image: 'https://pannulawyers.com.au/wp-content/uploads/2020/01/common-assault.jpg',
                    text: 'Assault',),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  CategoryButton(image:'https://st2.depositphotos.com/2631505/10083/i/950/depositphotos_100836064-stock-photo-teenager-woman-abused-suffering-internet.jpg',

                    text: 'Blackmail',),
                  CategoryButton(image: 'https://www.deccanherald.com/sites/dh/files/styles/article_detail/public/article_images/2018/09/21/suicide-dh-1537532497.jpg?itok=DTRsfNV_',
                    text: 'Suicide',),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  CategoryButton(image:'https://blogs.iadb.org/ideas-matter/wp-content/uploads/sites/12/2019/06/surprisingly-negative-impact-domestic-violence-campaigns.jpg',

                    text: 'Domestic Violence',),
                  CategoryButton(image:'https://media.istockphoto.com/photos/on-wood-table-at-party-with-alcohol-and-drugs-or-heroin-pills-picture-id1282811268?b=1&k=20&m=1282811268&s=170667a&w=0&h=YaiFFXLvlqZgCfZCBZ61t7h_jMCA0ZIzU3Ep8pJZs1w=',

                    text: 'Drug',),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  CategoryButton(image: 'https://media.istockphoto.com/photos/knife-in-darkness-picture-id1132879289?k=20&m=1132879289&s=612x612&w=0&h=oXcPGJ0tCtiLR71-QvoFHzVV9RpGVxVwAA29G7Vz_-I=',

                    text: 'Murder',),
                  CategoryButton(image:'https://cdn.corporatefinanceinstitute.com/assets/frauds-in-audit-1024x681.jpeg',

                    text: 'Fraud',),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  CategoryButton(image:'https://thumbs.dreamstime.com/b/car-thief-car-robbery-concept-photo-caucasian-male-black-mask-trying-to-open-using-custom-tool-flashlight-57778122.jpg',

                    text: 'Robbery',),
                  CategoryButton(image: 'https://media.istockphoto.com/photos/and-a-concept-yellow-question-mark-glowing-amid-black-question-marks-picture-id1305169776?b=1&k=20&m=1305169776&s=170667a&w=0&h=mpYdh2MzGN_rqxoRNlO5KWGCCq3ZktzSfp-wA0nD9no=',
                    text: 'Other',),
                ],
              ),
              SizedBox(height: 30,),
            ],
        ),
      )
    );
  }
}

class CategoryButton extends StatelessWidget {

  CategoryButton({required this.image,required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20


        ),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UserData(category: text)));
          },
          child: Container(
            height: 150,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(10)),
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
                elevation: 20,
                child: Column(
                  children: [
                    Image.network(image.toString(),fit: BoxFit.fill,height: 100,),
                    SizedBox(height: 10,),
                    Text(text.toString()),
                  ],
                )),
          ),
        )
    )
    );
  }
}