import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterdatatable/pages/Home.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login.dart';
import 'Member_Management.dart';
import 'Members.dart';
import 'Services.dart';
import 'Student_Management.dart';

class Expert_Profile extends StatefulWidget {
  @override
  _Expert_ProfileState createState() => _Expert_ProfileState();
}

class _Expert_ProfileState extends State<Expert_Profile> {
  bool _isEnabled = false;
  bool _isUpdating;
  Member _Member;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController affiliationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  _updateMember(Member member) {
    setState(() {
      _isUpdating = true;
    });

    Services.updateMember(nationalIdController.text, nameController.text, professionController.text,emailController.text, affiliationController.text, passwordController.text)
        .then((result) {
      final msg = json.decode(result)["message"];
      if ('Member was updated successfully!' == msg) {
        setState(() {
          _isUpdating = false;
        });
      }
    });
  }

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
            child: Text('INDUSTRY EXPERTS')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'Student Management');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new Student_Management()));
              }),
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
                    "U S E R      P R O F I L E",
                  ),
                ),
                SizedBox(height: 45.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    controller: nationalIdController,
                    decoration:
                    InputDecoration(labelText: 'National Identity Card ', hintText: 'nic'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'NIC Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: nameController,
                    enabled: _isEnabled,
                    decoration: InputDecoration(
                        labelText: 'Name ', hintText: 'name'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    controller: professionController,

                    decoration: InputDecoration(
                        labelText: 'Profession ', hintText: 'profession'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Profession Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    controller: emailController,

                    decoration: InputDecoration(
                        labelText: 'Email ', hintText: 'email'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email Is Empty *';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    controller: affiliationController,
                    decoration: InputDecoration(
                        labelText: 'Affiliation ', hintText: 'affiliation'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Affiliation Is Empty *';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password ', hintText: 'password'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password Empty *';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    obscureText: true,
                    controller: cpasswordController,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password ', hintText: 'confirm password'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Confirm Password Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 5.0),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(height: 35.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if(passwordController.text == cpasswordController.text) {
                              Fluttertoast.showToast(msg: 'Update Successfully');
                              _updateMember(_Member);
                            }
                            else{
                              Fluttertoast.showToast(msg: 'Password Not Matched');
                            }
                          }
                        },
                        child: new Text(
                          "Update Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 35.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new MaterialButton(
                        onPressed: () {
                          setState(() {
                            _isEnabled = !_isEnabled;
                            if (_isEnabled == true) {
                              Fluttertoast.showToast(msg: 'Edit On');
                            } else {
                              Fluttertoast.showToast(msg: 'Edit Off');
                            }
                          });
                        },
//                        () {
//
//                          Fluttertoast.showToast(msg: 'You can edit details');
//                          print("Edit");
//                        },
                        child: new Text(
                          "Edit Mode",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
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

}
