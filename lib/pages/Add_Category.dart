import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Category_Management.dart';
import 'Home.dart';
import 'Login.dart';
import 'Student_Profile.dart';

// ignore: camel_case_types
class Add_Category extends StatefulWidget {
  @override
  _Add_CategoryState createState() => _Add_CategoryState();
}

class _Add_CategoryState extends State<Add_Category> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController proLanguagesController = TextEditingController();
  TextEditingController programmingIdesController = TextEditingController();

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
            child: Text('STUDENT')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'Student Profile');
               Navigator.push(
                  context,
                    MaterialPageRoute(
                        builder: (context) => new Student_Profile()));
              }),
          IconButton(
            icon: Icon(Icons.library_books),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Category Management');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Category_Management()));
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Logout');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Login()));
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(
                    "A D D   S T U D E N T   C A T E G O R Y",
                  ),
                ),
                SizedBox(height: 45.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: categoryIdController,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: 'Category ID ', hintText: 'category id'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Category Id Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: categoryNameController,

                    decoration:
                        InputDecoration(labelText: 'Category Name ', hintText: 'category name'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Category Name Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: proLanguagesController,

                    decoration: InputDecoration(
                        labelText: 'Programming Language ', hintText: 'programming language'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Programming Language Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: programmingIdesController,

                    decoration:
                        InputDecoration(labelText: 'Programming IDEs ', hintText: 'programming IDEs'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Programming IDE Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 35.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print("Save");
                            SaveUserDattails();
                            Fluttertoast.showToast(msg: 'Category Added');
                          }
                        },
                        child: new Text(
                          "Add Category",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void SaveUserDattails() {}
}
