import 'package:http/http.dart' as http;

class Api {
  Future sendNotification(String message, String phone) async {
    final url = Uri.parse('https://api.releans.com/v2/message');
    final response = await http.post(url,
        headers: {'Authorization': 'Bearer f43f33dd07f7a18bc3a696518bf27390'},
        body: {"sender": "Nedz", "mobile": phone, "content": message});

    //    print(response.statusCode);
  }
}
