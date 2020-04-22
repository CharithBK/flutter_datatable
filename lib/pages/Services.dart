import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Categories.dart';
import 'Members.dart';

class Services {

  static Future<List<Member>> getMembers() async {
    try {
      var map = Map<String, dynamic>();
      //map['action'] = _GET_ALL_ACTION;
      print("ggUpper");

      final response = await http.get('http://192.168.1.110:3000/members');
      print("gg");

      print('getMembers Response: ${json.decode(response.body)[12]}');
      if (200 == response.statusCode) {
        print("gglist");
        List<Member> list = parseResponse(response.body);
        //print(parseResponse(response.body));
        //print ("response.body");
        return list;
      } else {
        return List<Member>();
      }
    } catch (e) {
      return List<Member>(); // return an empty list on exception/error
    }
  }

  static Future<List<Category>> getCategory() async {
    try {
      var map = Map<String, dynamic>();
      //map['action'] = _GET_ALL_ACTION;
      print("category ok1");

      final response = await http.get('http://192.168.1.110:3000/category');
      print("gg");

      print('getCategory Response: ${json.decode(response.body)[2]}');
      if (200 == response.statusCode) {
        print("gglist");
        List<Category> list = parseResponse1(response.body);
        //print(parseResponse(response.body));
        //print ("response.body");
        return list;
      } else {
        return List<Category>();
      }
    } catch (e) {
      return List<Category>(); // return an empty list on exception/error
    }
  }

  static List<Member> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    //print(parsed);
    print(parsed.map<Member>((json) => Member.fromJson(json)).toList());
    return parsed.map<Member>((json) => Member.fromJson(json)).toList();
  }

  static List<Category> parseResponse1(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    //print(parsed);
    print(parsed.map<Category>((json) => Category.fromJson(json)).toList());
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }

// Method to add employee to the database...
  static Future<String> addMembers(
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
