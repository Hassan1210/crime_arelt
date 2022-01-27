import 'package:http/http.dart' as http;
import 'dart:convert';

class NearbyLocation{
  final String url;
  NearbyLocation(this.url);
  Future <dynamic> getNearByLocation() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      String data = response.body;
      var decodedata = jsonDecode(data);
      return decodedata;
    }
    else{
      print('world');
    }
  }
}