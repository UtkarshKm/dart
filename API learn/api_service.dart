import 'dart:convert' as convert;

import 'package:api_learn/model/user.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  static Future<List<User>> fetchUser() async {
  
    const url = "https://randomuser.me/api/?results=5";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = convert.jsonDecode(response.body);
    final List<dynamic> results = body['results'];
    final user = results.map((e) {
      final name = UserName(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']);

      return User(
          cell: e['cell'],
          email: e['email'],
          gender: e['gender'],
          nat: e['nat'],
          phone: e['phone'],
          name: name);
    }).toList(); // each item in the results collection is transformed into a new User object with the properties cell, email, gender, nat, and phone being initialized with the corresponding values from the item. The map function applies this transformation to each element in the results collection. Finally, the toList() method is called to convert the resulting iterable of User objects into a list, which is then assigned to the variable transformed.

    return user;
  }
}
