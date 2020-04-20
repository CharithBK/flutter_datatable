import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Services.dart';
import 'home.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _isEnabled = false;
  String dropdownType;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController affiliationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();


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
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {}),

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
                    "M E M B E R      R E G I S T R A T I O N",
                  ),
                ),
                SizedBox(height: 45.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: nationalIdController,
                    decoration:
                        InputDecoration(labelText: 'National ID ', hintText: 'Id'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'National Id Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: nameController,

                    decoration: InputDecoration(
                        labelText: 'Member Name ', hintText: 'name'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Member Name Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: professionController,

                    decoration: InputDecoration(
                        labelText: 'Profession ', hintText: 'profession'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Profession Name Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
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
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
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
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,

                    decoration: InputDecoration(
                        labelText: 'Password ', hintText: 'password'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: cpasswordController,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password ', hintText: 'confirm password'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Confirm Password Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(

                    controller: statusController,
                    decoration: InputDecoration(
                        labelText: 'Status ', hintText: 'true or false'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Status Is Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Type :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    DropdownButton<String>(
                      value: dropdownType,
                      hint: Text("Select Type"),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 16,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 4,
                        color: Colors.lightGreen,
                      ),
                      onChanged: (String newValue) {

                          setState(() {
                            dropdownType = newValue;
                            print(dropdownType);
                            //print(dropdownBrands);
                          });

                        return dropdownType;
                      },
                      items: <String>[
                        'Manager',
                        'Expert',
                        'Student',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
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
                            if (dropdownType != null) {
                              print("Save");
                              SaveUserDattails();
                              Fluttertoast.showToast(msg: 'Details Saved');
                            } else {
                              Fluttertoast.showToast(msg: 'Select the type');
                            }
                          }
                        },
                        child: new Text(
                          "Save",
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

  void SaveUserDattails() {


    Services.addEmployee(nationalIdController.text, nameController.text,professionController.text,emailController.text,affiliationController.text,dropdownType,passwordController.text,statusController.text)
        .then((result) {
      Fluttertoast.showToast(msg: 'OK DB data passed');
    });
  }
}
