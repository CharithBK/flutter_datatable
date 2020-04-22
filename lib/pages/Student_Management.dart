import 'dart:async';
import 'dart:core';


import 'package:flutter/material.dart';
import 'package:flutterdatatable/pages/Students.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Add_Category.dart';
import 'Categories.dart';
import 'Expert_Profile.dart';
import 'Services.dart';


// ignore: camel_case_types
class Student_Management extends StatefulWidget {
  final String title = "INDUSTRY EXPERTS";

  @override
  _Student_ManagementState createState() => _Student_ManagementState();
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

class _Student_ManagementState extends State<Student_Management> {
  List<Student> _students;
  List<Student> _filterstudents;
  GlobalKey<ScaffoldState> _scaffoldKey;

  // controller for the First Name TextField we are going to create.
  TextEditingController _category;
  TextEditingController _nationalID;
  TextEditingController _name;
  TextEditingController _profession;
  TextEditingController _email;
  TextEditingController _affiliation;
  TextEditingController _qualifications_languages;
  TextEditingController _qualifications_IDEs;

  Student _selectedStudent;
  bool _isUpdating;
  String _titleProgress;
  final _debouncer = Debouncer(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _students = [];
    _filterstudents = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar

    _category = TextEditingController();
    _nationalID = TextEditingController();
    _name = TextEditingController();
    _profession = TextEditingController();
    _email = TextEditingController();
    _affiliation = TextEditingController();
    _qualifications_languages = TextEditingController();
    _qualifications_IDEs = TextEditingController();
    _getStudents();
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

  _getStudents() {
    _showProgress('Loading Details...');
    Services.getStudents().then((student) {
      setState(() {
        _students = student;

        _filterstudents = student;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${student.length}");
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
    _category.text = '';
    _nationalID.text = '';
    _name.text = '';
    _profession.text = '';
    _email.text = '';
    _affiliation.text = '';
    _qualifications_languages.text = '';
    _qualifications_IDEs.text = '';
  }

  _showValues(Student student) {
    _category.text = student.category;
    _nationalID.text = student.nationalID;
    _name.text = student.name;
    _profession.text = student.profession;
    _category.text = student.email;
    _nationalID.text = student.affiliation;
    _name.text = student.qualifications_Languages;
    _profession.text = student.qualifications_IDEs;

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
              label: Text('Category ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('National ID',
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
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('Profession',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
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
              label: Text('Qualifications Languages',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('Qualifications IDEs',
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
          rows: _filterstudents
              .map(
                (student) => DataRow(cells: [
              DataCell(
                Text(student.category),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {
                  _showValues(student);
                  // Set the Selected employee to Update
                  _selectedStudent = student;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  student.nationalID.toUpperCase(),
                ),
                onTap: () {
                  _showValues(student);
                  // Set the Selected employee to Update
                  _selectedStudent = student;
                  // Set flag updating to true to indicate in Update Mode
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  student.name.toUpperCase(),
                ),
                onTap: () {
                  _showValues(student);
                  // Set the Selected employee to Update
                  _selectedStudent = student;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  student.profession.toUpperCase(),
                ),
                onTap: () {
                  _showValues(student);
                  // Set the Selected employee to Update
                  _selectedStudent = student;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
                  DataCell(
                    Text(student.email.toUpperCase()),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(student);
                      // Set the Selected employee to Update
                      _selectedStudent = student;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      student.affiliation.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(student);
                      // Set the Selected employee to Update
                      _selectedStudent = student;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      student.qualifications_Languages.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(student);
                      // Set the Selected employee to Update
                      _selectedStudent = student;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      student.qualifications_IDEs.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(student);
                      // Set the Selected employee to Update
                      _selectedStudent = student;
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
          hintText: 'Search by Category',
        ),
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {_filterstudents = _students.where((u) => (u.category.toLowerCase().contains(string.toLowerCase())))
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
          new IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'Expert Profile');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Expert_Profile()));
              }),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getStudents();
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
