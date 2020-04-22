import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Expert_Profile.dart';
import 'Manager_Profile.dart';
import 'Member_Management.dart';
import 'Members.dart';
import 'Services.dart';
import 'Login.dart';
import 'Student_Profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => new Home()));
            },
            child: Text('Student Industry Portal System')),
        actions: <Widget>[],
      ),
      body: new ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: 'Manager');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Manager_Profile()));
            },
            child: ListTile(
              title: Text('Manager'),
              leading: Icon(
                Icons.people,
                color: Colors.green,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: 'Expert');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Expert_Profile()));
            },
            child: ListTile(
              title: Text('Expert'),
              leading: Icon(
                Icons.people,
                color: Colors.green,
              ),
            ),
          ),    InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: 'Student');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Student_Profile()));
            },
            child: ListTile(
              title: Text('Student'),
              leading: Icon(
                Icons.people,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
