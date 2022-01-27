import 'package:flutter/material.dart';
import 'constent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';

bool name_enabled = false;
bool phone_enabled = false;
bool pic_enabled = false;

bool Button_enabled = false;
bool istrue = false;
final TextEditingController Name_Controller = TextEditingController();
final TextEditingController Phone_Controller = TextEditingController();
final TextEditingController Email_Controller = TextEditingController();

String New_Name = '';
String New_Phone = '';

String? email;
String? name;
String? Images;
String? phone;

final imagePicker = ImagePicker();
var imageFile;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
    setState(() {
      name_enabled = false;
      phone_enabled = false;
    });
  }

  fetch() async {
    final user = await FirebaseAuth.instance.currentUser;
    print(user!.uid);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((ds) {
        email = ds['email'];
        name = ds['name'];
        Images = ds['image'];
        phone = ds['phone'];
      });
      print(email);
      print(name);
    } catch (e) {
      print(e.toString());
    }
  }

  Future get_image() async {
    var image = await imagePicker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      imageFile = File(image.path);
    });
  }

  Future upload_image() async {
    if (imageFile == null) {
      updateImage(null);
    } else {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("profileImages/$email");
      UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        String url = await ref.getDownloadURL();
        print(url);
        updateImage(url);
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future updateImage(var url) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final user = await FirebaseAuth.instance.currentUser;

      users.doc(user!.uid).set({
        'name': New_Name.length == 0 ? name : New_Name,
        'email': email,
        'image': url == null ? Images : url,
        'phone': New_Phone.length == 0 ? phone : New_Phone,
      });
    } catch (e) {}
    setState(() {
      istrue = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile is Updated...'),
          duration: Duration(seconds: 5),
        ),
      );
      phone_enabled = false;
      name_enabled = false;
    });
  }

  void cancelValues() {
    setState(() {
      final _emailValue = '';
      Email_Controller.value = TextEditingValue(
        text: _emailValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: _emailValue.length),
        ),
      );
      final _nameValue = '';
      Name_Controller.value = TextEditingValue(
        text: _nameValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: _nameValue.length),
        ),
      );
      final _phoneValue = '';
      Phone_Controller.value = TextEditingValue(
        text: _phoneValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: _phoneValue.length),
        ),
      );
    });
  }

  Future<bool> arelt() async {
    var arelt = AlertDialog(
      title: Text('Discard?'),
      content: Text('Do you want to discard this picture?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            imageFile = null;
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text('yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext) {
          return arelt;
        });
    cancelValues();
    return false;
  }

  Future<bool> _willPopCallback() async {
    imageFile == null;
    cancelValues();
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: imageFile == null ? _willPopCallback : arelt,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crime Reporting'),
          centerTitle: true,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 4,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: imageFile == null ? _willPopCallback : arelt,
          ),
          actions: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.home,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => Home(),), (route) => false);
              },
            ),
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: istrue,
          child: Container(
            child: GestureDetector(
              child: FutureBuilder(
                  future: fetch(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else
                          return ListView(
                            children: [
                              Container(
                                  height: 56,
                                  child: Center(
                                      child: Text('Edit Profile',
                                          style: MainHeading))),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Stack(
                                  children: [
                                    imageFile != null
                                        ? Container(
                                            width: 140,
                                            height: 140,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 4,
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor),
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius: 2,
                                                      blurRadius: 10,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      offset: Offset(0, 10))
                                                ],
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        FileImage(imageFile))),
                                          )
                                        : Container(
                                            width: 140.0,
                                            height: 140.0,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10))
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        Images.toString()),
                                              ),
                                            ),
                                          ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap:() {
                                                  get_image();
                                                },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 4,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                              color: Colors.green,
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 0, right: 16),
                                child: TextField(
                                  enabled: false,
                                  controller: Email_Controller,
                                  style: Selected,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: 'Email',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: email.toString(),
                                      hintStyle: Selected),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    name_enabled = true;
                                    final _nameValue = name;
                                    Name_Controller.value = TextEditingValue(
                                      text: _nameValue.toString(),
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: _nameValue.toString().length),
                                      ),
                                    );
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 0, right: 16),
                                  child: TextField(
                                    enabled: name_enabled,
                                    style: name_enabled ? Unselected : Selected,
                                    controller: Name_Controller,
                                    onChanged: (value) {
                                      New_Name = value;
                                    },
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: 'NAME',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: name.toString(),
                                        hintStyle: Selected),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    phone_enabled = true;
                                    final _phoneValue = phone == null?'':phone.toString();
                                    Phone_Controller.value = TextEditingValue(
                                      text: _phoneValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: _phoneValue.toString().length),
                                      ),
                                    );
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 0, right: 16),
                                  child: TextField(
                                    enabled: phone_enabled,
                                    style: phone_enabled ? Unselected : Selected,
                                    controller: Phone_Controller,
                                    onChanged: (value) {
                                      New_Phone = value;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 3),
                                      labelText: 'Phone',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText:
                                          phone.toString().isEmpty ? '' : phone,
                                      hintStyle: Selected,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 55,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 0, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      child: Text(
                                        'CANCEL',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: imageFile == null
                                          ? _willPopCallback
                                          : arelt,
                                      style: ElevatedButton.styleFrom(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          primary: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 45),
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 2.2,
                                              color: Colors.black)),
                                    ),
                                    ElevatedButton(
                                      child: Text('UPDATE'),
                                      onPressed: phone_enabled || name_enabled ||pic_enabled
                                          ? () {
                                              setState(() {
                                                istrue = true;
                                              });
                                              upload_image();
                                              imageFile = null;
                                            }
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                          elevation: 4,
                                          onSurface: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          primary: Colors.green,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 45),
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 2.2,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
