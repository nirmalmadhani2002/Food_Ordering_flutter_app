import 'package:flutter/material.dart';

import '../../controllers/firebase_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        actions: [
          TextButton(
            child: Text("Log Out"),
            onPressed: () async {
              await FirebaseAuthHelper.firebaseAuthHelper.logOut();

              Navigator.pushReplacementNamed(context, '/');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                      "Log Out successful...",
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating),
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 70,
              foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/115910370?v=4"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Nirmal Madhani",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "nirmalmadhnai000@gmail.com",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
