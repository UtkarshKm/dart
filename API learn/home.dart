import 'package:api_learn/model/user.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].email),
            subtitle: Row(
              git config --global user.emailchildren: [
                Text('${users[index].name.first} ${users[index].name.last}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pressed,
        tooltip: 'Fetch Users',
        child: const Icon(Icons.download),
      ),
    );
  }

  void pressed() async {
    print("Button Pressed");
    const url = "https://randomuser.me/api/?results=5";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = convert.jsonDecode(response.body);
    final List<dynamic> results = body['results'];
    final transformed = results.map((e) {
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

    setState(() {
      // When you call setState(), it triggers the build method of the widget, leading to a redraw of the user interface based on the new state.
      users = transformed;
    });
    print(users);
  }
}
