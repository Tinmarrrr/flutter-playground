import 'dart:convert';
import 'package:http/http.dart' as http;

class Bored {
  static Future<String> getActivity() async {
    final response =
        await http.get(Uri.parse('http://www.boredapi.com/api/activity/'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['activity'];
    } else {
      return "Something went wrong :(";
    }
  }
}
