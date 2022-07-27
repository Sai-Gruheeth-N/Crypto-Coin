import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    // print(response.statusCode);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      print(response.statusCode);
      print(data);

      var decodedData = jsonDecode(data);
      return decodedData['rate'];
    } else {
      print(response.statusCode);
      throw ('Check Networking GET request');
    }
  }
}
