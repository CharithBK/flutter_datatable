import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Manager_Profile.dart';
import 'Members.dart';
import 'Services.dart';


// ignore: camel_case_types
class Member_Management extends StatefulWidget {
  final String title = "MANAGER";

  @override
  _Member_ManagementState createState() => _Member_ManagementState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != timer) {
      timer.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _Member_ManagementState extends State<Member_Management> {
  List<Member> _members;
  List<Member> _filtermembers;
  GlobalKey<ScaffoldState> _scaffoldKey;

  // controller for the First Name TextField we are going to create.
  TextEditingController _nationalID;

  // controller for the Last Name TextField we are going to create.
  TextEditingController _name;
  TextEditingController _profession;
  TextEditingController _email;
  TextEditingController _affiliation;
  TextEditingController _type;
  TextEditingController _password;
  TextEditingController _status;
  Member _selectedMember;
  bool _isUpdating;
  String _titleProgress;
  final _debouncer = Debouncer(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _members = [];
    _filtermembers = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar

    _nationalID = TextEditingController();
    _name = TextEditingController();
    _profession = TextEditingController();
    _email = TextEditingController();
    _affiliation = TextEditingController();
    _type = TextEditingController();
    _password = TextEditingController();
    _status = TextEditingController();
    _getMembers();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

//  _createTable() {
//    _showProgress('Creating Table...');
//    Services.createTable().then((result) {
//      if ('success' == result) {
//        // Table is created successfully.
//        _showSnackBar(context, result);
//        _showProgress(widget.title);
//      }
//    });
//  }

  // Now lets add an Employee
//  _addEmployee() {
//    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
//      print('Empty Fields');
//      return;
//    }
//    _showProgress('Adding Employee...');
//    Services.addEmployee(_firstNameController.text, _lastNameController.text)
//        .then((result) {
//      if ('success' == result) {
//        _getEmployees(); // Refresh the List after adding each employee...
//        _clearValues();
//      }
//    });
//  }

  _getMembers() {
    _showProgress('Loading Members...');
    Services.getMembers().then((members) {
      setState(() {
        _members = members;
        _filtermembers = members;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${members.length}");
    });
  }

//  _updateEmployee(Employee employee) {
//    setState(() {
//      _isUpdating = true;
//    });
//    _showProgress('Updating Employee...');
//    Services.updateEmployee(
//        employee.id, _firstNameController.text, _lastNameController.text)
//        .then((result) {
//      if ('success' == result) {
//        _getEmployees(); // Refresh the list after update
//        setState(() {
//          _isUpdating = false;
//        });
//        _clearValues();
//      }
//    });
//  }
//
  _deleteMember(Member member) {
    _showProgress('Deleting Member...');
    Services.deleteMember(member.nationalID).then((result) {
      print("delete done");
      final msg = json.decode(result)["message"];
      print(msg);
      if ('Member was deleted successfully!' == msg) {
        _getMembers(); // Refresh after delete...
      }
      print("delete done2");
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _nationalID.text = '';
    _name.text = '';
    _profession.text = '';
    _email.text = '';
    _affiliation.text = '';
    _type.text = '';
    _password.text = '';
    _status.text = '';
  }

  _showValues(Member members) {
    _nationalID.text = members.nationalID;

    _name.text = members.name;
    _profession.text = members.profession;
    _email.text = members.email;
    _affiliation.text = members.affiliation;
    _type.text = members.type;
    _password.text = members.password;
    _status.text = members.status;
  }

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(

          columns: [

            DataColumn(
              label: Text('NationalID',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('Profession',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('Email',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('Affiliation',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('Type',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('Status',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('Delete',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
          ],
          rows: _filtermembers
              .map(
                (member) => DataRow(cells: [
                  DataCell(
                    Text(member.nationalID),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(member);
                      // Set the Selected employee to Update
                      _selectedMember = member;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      member.name.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(member);
                      // Set the Selected employee to Update
                      _selectedMember = member;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      member.profession.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(member);
                      // Set the Selected employee to Update
                      _selectedMember = member;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      member.email.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(member);
                      // Set the Selected employee to Update
                      _selectedMember = member;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      member.affiliation.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(member);
                      // Set the Selected employee to Update
                      _selectedMember = member;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      member.type.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(member);
                      // Set the Selected employee to Update
                      _selectedMember = member;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      member.password.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(member);
                      // Set the Selected employee to Update
                      _selectedMember = member;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      member.status.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(member);
                      // Set the Selected employee to Update
                      _selectedMember = member;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete,
                      color: Colors.red,
                    ),

                    onPressed: () {
                      Fluttertoast.showToast(msg: 'Member Deleted');
                      _deleteMember(member);
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  searchFeild() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          contentPadding: EdgeInsets.all(15.0),
          hintText: 'Search',
        ),
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {_filtermembers = _members.where((u) => (u.nationalID.toLowerCase().contains(string.toLowerCase())) || (u.name.toLowerCase().contains(string.toLowerCase()))|| (u.profession.toLowerCase().contains(string.toLowerCase()))||(u.email.toLowerCase().contains(string.toLowerCase()))||(u.affiliation.toLowerCase().contains(string.toLowerCase()))||(u.type.toLowerCase().contains(string.toLowerCase()))||(u.password.toLowerCase().contains(string.toLowerCase()))||(u.status.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Manager Profile');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Manager_Profile()));
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getMembers();
            },
          )
        ],
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _isUpdating
                  ? Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Text('UPDATE'),
                          onPressed: () {
                            // _updateEmployee(_selectedEmployee);
                          },
                        ),
                        OutlineButton(
                          child: Text('CANCEL'),
                          onPressed: () {
                            setState(() {
                              _isUpdating = false;
                            });
                            _clearValues();
                          },
                        ),
                      ],
                    )
                  : Container(),
              searchFeild(),
              Expanded(
                child: _dataBody(),
              ),
            ],
          ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          //  _addEmployee();
//        },
//        child: Icon(Icons.add),
//      ),
    );
  }
}
