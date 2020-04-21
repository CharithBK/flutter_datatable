import 'dart:async';
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
  final String title = "Member Management";

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
  List<Employee> _employees;
  List<Employee> _filteremployees;
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
  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;
  final _debouncer = Debouncer(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _employees = [];
    _filteremployees = [];
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
    _getEmployees();
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

  _getEmployees() {
    _showProgress('Loading Members...');
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;

        _filteremployees = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
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
//  _deleteEmployee(Employee employee) {
//    _showProgress('Deleting Employee...');
//    Services.deleteEmployee(employee.id).then((result) {
//      if ('success' == result) {
//        _getEmployees(); // Refresh after delete...
//      }
//    });
//  }

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

  _showValues(Employee employee) {
    _nationalID.text = employee.nationalID;

    _name.text = employee.name;
    _profession.text = employee.profession;
    _email.text = employee.email;
    _affiliation.text = employee.affiliation;
    _type.text = employee.type;
    _password.text = employee.password;
    _status.text = employee.status;
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
          rows: _filteremployees
              .map(
                (employee) => DataRow(cells: [
                  DataCell(
                    Text(employee.nationalID),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.name.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.profession.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.email.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.affiliation.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.type.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.password.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.status.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
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
                      //_deleteEmployee(employee);
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
            setState(() {_filteremployees = _employees.where((u) => (u.nationalID.toLowerCase().contains(string.toLowerCase())) || (u.name.toLowerCase().contains(string.toLowerCase()))|| (u.profession.toLowerCase().contains(string.toLowerCase()))||(u.email.toLowerCase().contains(string.toLowerCase()))||(u.affiliation.toLowerCase().contains(string.toLowerCase()))||(u.type.toLowerCase().contains(string.toLowerCase()))||(u.password.toLowerCase().contains(string.toLowerCase()))||(u.status.toLowerCase().contains(string.toLowerCase())))
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
              _getEmployees();
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
//              Padding(
//                padding: EdgeInsets.all(20.0),
//                child: TextField(
//                  controller: _name,
//                  decoration: InputDecoration.collapsed(
//                    hintText: 'Name',
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.all(20.0),
//                child: TextField(
//                  controller: _type,
//                  decoration: InputDecoration.collapsed(
//                    hintText: 'Type',
//                  ),
//                ),
//              ),
              // Add an update button and a Cancel Button
              // show these buttons only when updating an employee
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