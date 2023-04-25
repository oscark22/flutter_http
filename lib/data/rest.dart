import 'dart:convert';

import 'package:http/http.dart' as http;

class Rest {
  Future<void> getPosts() async {
    var url = Uri.https("jsonplaceholder.typicode.com", "/posts");
    var response = await http.get(url);

    print("Status code: ${response.statusCode}");
    var data = jsonDecode(response.body);

    print(data[0]["id"]);
    print("${data[0]["id"]} - ${data[0]["title"]}");
  }

  Future<void> postPosts() async {
    var url = Uri.https("jsonplaceholder.typicode.com", "/posts");

    var data = jsonEncode({
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    });

    var response = await http.post(url, body: data);
    print(response.statusCode);
  }

  Future<void> getPostsMultiple() async {
    var url = Uri.https("jsonplaceholder.typicode.com", "/posts");

    var data = jsonEncode({
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    });

    var client = http.Client();
    try {
      for (int i = 0; i < 10; i++) {
        var response = await client.post(url, body: data);
        print(response.statusCode);
      }
    } finally {
      client.close();
    }
  }
}
