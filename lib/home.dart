import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text('You are logged in!')),
            RaisedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Auth(),
                  )),
              child: Text('Log out'),
            ),
          ]),
    );
  }
}
