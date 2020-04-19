import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DataTable.dart';
import 'Employee.dart';
import 'Services.dart';

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
            child: Text('ⓉⓇⒺⓃⒹⓈ')),
        actions: <Widget>[],
      ),
      body: new ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: 'Manager');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new DataTableDemo()));
            },
            child: ListTile(
              title: Text('Profile'),
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
