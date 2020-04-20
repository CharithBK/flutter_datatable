import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Employee.dart';

class Services {
//  static const ROOT = 'http://192.168.1.10:8080/EmployeesDB/member_actions.php';
//  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
//  static const _GET_ALL_ACTION = 'GET_ALL';
//  static const _ADD_EMP_ACTION = 'ADD_EMP';
//  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
//  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  // Method to create the table Employees
//  static Future<String> createTable() async {
//    try {
//      //add the parameters to pass to the request
//      var map = Map<String, dynamic>();
//      map['action'] = _CREATE_TABLE_ACTION;
//      final response = await http.post(ROOT, body: map);
//      print('Create table responce : ${response.body}');
//      return response.body;
//    }
//    catch (e)
//    {
//      return "error";
//    }
//  }
  static Future<List<Employee>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      //map['action'] = _GET_ALL_ACTION;
      print("ggUpper");

      final response = await http.get('http://192.168.1.110:3000/members');
      print("gg");

      print('getEmployees Response: ${json.decode(response.body)[12]}');
      if (200 == response.statusCode) {
        print("gglist");
        List<Employee> list = parseResponse(response.body);
        //print(parseResponse(response.body));
        //print ("response.body");
        return list;
      } else {
        return List<Employee>();
      }
    } catch (e) {
      return List<Employee>(); // return an empty list on exception/error
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    //print(parsed);
    print(parsed.map<Employee>((json) => Employee.fromJson(json)).toList());
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

// Method to add employee to the database...
  static Future<String> addEmployee(
      String _nationalid,
      String _name,
      String _profession,
      String _email,
      String _affiliation,
      String _type,
      String _password,
      String _status) async {
    try {
      print(_nationalid);
      print(_name);
      print(_profession);
      print(_email);
      print(_affiliation);
      print(_type);
      print(_password);
      print(_status);
      var map = Map<String, dynamic>();
      //map['action'] = _ADD_EMP_ACTION;

      print("ggmap");
      map["nationalid"] = _nationalid;
      map["name"] = _name;
      map["profession"] = _profession;
      map["email"] = _email;
      map["affiliation"] = _affiliation;
      map["type"] = _type;
      map["password"] = _password;
      map["status"] = _status;
      final data = json.encode(map);
      //String json2 = '{"nationalid":"1020","name":"Oshan2","profession":"Administrator ","email":"niluminda5@gmail.com","affiliation":"ICT","type":"Manager","password":"1234","status":"1"}';
      print(data);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('http://192.168.1.110:3000/members',headers: headers, body: data);
      print("data_Ok");
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

// Method to update an Employee in Database...
//  static Future<String> updateEmployee(
//      String empId, String firstName, String lastName) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _UPDATE_EMP_ACTION;
//      map['emp_id'] = empId;
//      map['first_name'] = firstName;
//      map['last_name'] = lastName;
//      final response = await http.post(ROOT, body: map);
//      print('updateEmployee Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  // Method to Delete an Employee from Database...
//  static Future<String> deleteEmployee(String empId) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _DELETE_EMP_ACTION;
//      map['emp_id'] = empId;
//      final response = await http.post(ROOT, body: map);
//      print('deleteEmployee Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error"; // returning just an "error" string to keep this simple...
//    }
//  }

}
