import 'package:api_learn/model/user.dart';
import 'package:api_learn/services/user_api.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> users = [];

  @override
  void initState() {
    // when the widget is first created, the initState() method is called. 
    // This is where you can perform any initialization that depends on the widget being fully created. 
    // In this case, you're calling the fetchUser() method to fetch the initial set of users.
    super.initState();
    fetchUser();
  }

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
              children: [
                Text('${users[index].name.first} ${users[index].name.last}'),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchUser() async {
    try {
      final response = await UserAPI.fetchUser();
      setState(() {
        users = response;
      });
    } catch (error) {
      // Handle the error, e.g., show an error message
      print("Error fetching user data: $error");
    }
  }
}
