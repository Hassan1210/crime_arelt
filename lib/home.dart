import 'package:crimealert/login_system/wellcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';



String? email;
String? name;
String? Images;


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final imagePicker = ImagePicker();
  var imageFile;
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    fetch();
  }
   fetch() async{
    final user = await FirebaseAuth.instance.currentUser;
    print(user!.uid);

        try{
           await FirebaseFirestore.instance.collection('users').doc(user.uid).get()
          .then((ds) {
            email = ds['email'];
            name = ds['name'];
            Images = ds['image'];
          });
            print(email);
            print(name);
        }catch(e){
          print(e.toString());


      }
  }
  Future get_image() async{
    var image = await imagePicker.getImage(source: ImageSource.gallery);
    if(image == null)
    {
      return;
    }
    setState(() {
      imageFile = File(image.path);
    });
  }
  Future upload_image() async{
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child("profileImages/$email");
    UploadTask uploadTask =  ref.putFile(imageFile);
    await  uploadTask.whenComplete(() async {
      String url = await ref.getDownloadURL();
      print(url);
      updateImage(url);
      setState(() {
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));

      });
    }).catchError((onError) {
      print(onError);
    });
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future updateImage(var url ) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      final user = await FirebaseAuth.instance.currentUser;

      users.doc(user!.uid).set({
        'name' : name,
        'email': email,
        'image': url,
      });
    } catch (e) {}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: ClipOval(
                    child:  imageFile != null ? Image.file(imageFile) : Text("")
                ),
                radius: 50,
              ),
              GestureDetector(
                onTap: (){
                  get_image();

                },
                child: Icon(
                    Icons.camera
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  upload_image();
                },
                child: Text('Upload'),
                backgroundColor: Colors.black,
                tooltip: 'Capture Picture',
                elevation: 5,
                splashColor: Colors.grey,
              ),

              FutureBuilder(
                future: fetch(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting: return Text('Loading....');
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else
                          return Text('Result: $email');
                    }
                  }
              ),
              FutureBuilder(
                  future: fetch(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting: return Text('Loading....');
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else
                          return Text('Result: $name');
                    }
                  }
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child:FutureBuilder(
                      future: fetch(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting: return Text('Loading....');
                          default:
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            else
                              {
                                return CachedNetworkImage(
                                  imageUrl: Images.toString(), width: 120, fit: BoxFit.fill,
                                  placeholder: (context, url) => CircularProgressIndicator(color: Colors.redAccent,),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                );
                              }

                        }
                      }
                  ),
                ),
                radius: 50,
              ),

              FloatingActionButton(
                  child: Text('logout'),
                  onPressed:() async{
                final FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut();
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => WellcomeScreen(),
                  ),
                      (route) => false,//if you want to disable back feature set to false
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

