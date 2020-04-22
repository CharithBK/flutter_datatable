import 'dart:async';
import 'dart:convert';
import 'dart:core';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Add_Category.dart';
import 'Categories.dart';
import 'Services.dart';


// ignore: camel_case_types
class Category_Management extends StatefulWidget {
  final String title = "STUDENT";

  @override
  _Category_ManagementState createState() => _Category_ManagementState();
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

class _Category_ManagementState extends State<Category_Management> {
  List<Category> _category;
  List<Category> _filtercategory;
  GlobalKey<ScaffoldState> _scaffoldKey;

  // controller for the First Name TextField we are going to create.
  TextEditingController _categoryID;

  // controller for the Last Name TextField we are going to create.
  TextEditingController _categoryName;
  TextEditingController _proLanguages;
  TextEditingController _proIDEs;


  Category _selectedCategory;
  bool _isUpdating;
  String _titleProgress;
  final _debouncer = Debouncer(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _category = [];
    _filtercategory = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar

    _categoryID = TextEditingController();
    _categoryName = TextEditingController();
    _proLanguages = TextEditingController();
    _proIDEs = TextEditingController();
    _getCategory();
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

  _getCategory() {
    _showProgress('Loading Details...');
    Services.getCategory().then((category) {
      setState(() {
        _category = category;

        _filtercategory = category;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${category.length}");
    });
  }

  _updateCategory(Category category) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Category...');
    Services.updateCategory(category.categoryID, _categoryName.text, _proLanguages.text,_proIDEs.text)
        .then((result) {
      final msg = json.decode(result)["message"];
      if ('Category was updated successfully!' == msg) {
        Fluttertoast.showToast(msg: 'Update Successfully');
        _getCategory(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteCategory(Category category) {
    _showProgress('Deleting Category...');
    Services.deleteCategory(category.categoryID).then((result) {
      print("delete done");
      final msg = json.decode(result)["message"];
      print(msg);
      if ('Category was deleted successfully!' == msg) {
        _getCategory(); // Refresh after delete...
      }
      print("delete done2");
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _categoryID.text = '';
    _categoryName.text = '';
    _proLanguages.text = '';
    _proIDEs.text = '';
  }

  _showValues(Category category) {
    _categoryID.text = category.categoryID;
    _categoryName.text = category.category;
    _proLanguages.text = category.qualifications_Languages;
    _proIDEs.text = category.qualifications_IDEs;

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
              label: Text('Category ID',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            DataColumn(
              label: Text('Category',
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
          rows: _filtercategory
              .map(
                (category) => DataRow(cells: [
              DataCell(
                Text(category.categoryID),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {
                  _showValues(category);
                  // Set the Selected employee to Update
                  _selectedCategory = category;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  category.category.toUpperCase(),
                ),
                onTap: () {
                  _showValues(category);
                  // Set the Selected employee to Update
                  _selectedCategory = category;
                  // Set flag updating to true to indicate in Update Mode
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  category.qualifications_Languages.toUpperCase(),
                ),
                onTap: () {
                  _showValues(category);
                  // Set the Selected employee to Update
                  _selectedCategory = category;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  category.qualifications_IDEs.toUpperCase(),
                ),
                onTap: () {
                  _showValues(category);
                  // Set the Selected employee to Update
                  _selectedCategory = category;
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
                  Fluttertoast.showToast(msg: 'Category Deleted');
                  _deleteCategory(category);
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
            setState(() {_filtercategory = _category.where((u) => (u.categoryID.toLowerCase().contains(string.toLowerCase())) || (u.category.toLowerCase().contains(string.toLowerCase()))|| (u.qualifications_Languages.toLowerCase().contains(string.toLowerCase()))||(u.qualifications_IDEs.toLowerCase().contains(string.toLowerCase())))
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
                Icons.library_add,
                color: Colors.white,
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'Add Category');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new Add_Category()));
              }),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getCategory();
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
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _categoryName,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Category',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _proLanguages,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Qualifications Languages',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _proIDEs,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Qualifications IDEs',
                  ),
                ),
              ),
              // Add an update button and a Cancel Button
              // show these buttons only when updating an employee
              _isUpdating
                  ? Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text('UPDATE'),
                    color: Colors.green,
                    onPressed: () {
                      _updateCategory(_selectedCategory);
                    },
                  ),  SizedBox(width: 10.0),
                  MaterialButton(
                    child: Text('CANCEL'),
                    color: Colors.red,
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
