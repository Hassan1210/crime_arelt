import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class UploadFile{
  Future select_file(int a)async{
    if(a == 1){
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      if(result == null)
      {
        return;
      }
      final path = result.files.single.path!;
      return path;
    }
    else if(a == 2){
      final ImagePicker _picker = ImagePicker();
      final  result = await _picker.pickImage(source: ImageSource.camera);
      final path = result!.path;
      return path;
    }
    else{
      final ImagePicker _picker = ImagePicker();
      final  result = await _picker.pickVideo(source: ImageSource.camera);
      final path = result!.path;
      return path;
    }

  }
  upload(dynamic file,String name)async{
    String? url;
    try{
      final ref = FirebaseStorage.instance.ref().child('Complain/$name');
      await ref.putFile(File(file.toString())).whenComplete(() async {
        url = await ref.getDownloadURL();
        print(url);
      });
      print(url);
      return url;
    }
    catch(e){
      print('hhh');
    }
  }

   get_image() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickVideo(source: ImageSource.camera);
    }

}