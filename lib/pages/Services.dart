import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Categories.dart';
import 'Members.dart';
import 'Students.dart';

class Services {
  static Future<List<Member>> getMembers() async {
    try {
      final response = await http.get('http://192.168.1.110:3000/members');
      if (200 == response.statusCode) {
        List<Member> list = parseResponse(response.body);
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
      final response = await http.get('http://192.168.1.110:3000/category');
      if (200 == response.statusCode) {
        List<Category> list = parseResponse1(response.body);
        return list;
      } else {
        return List<Category>();
      }
    } catch (e) {
      return List<Category>(); // return an empty list on exception/error
    }
  }

  static Future<List<Student>> getStudents() async {
    try {
      final response =
          await http.get('http://192.168.1.110:3000/category/member/category');
      if (200 == response.statusCode) {
        List<Student> list = parseResponse2(response.body);

        return list;
      } else {
        return List<Student>();
      }
    } catch (e) {
      return List<Student>(); // return an empty list on exception/error
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

  static List<Student> parseResponse2(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    //print(parsed);
    print(parsed.map<Student>((json) => Student.fromJson(json)).toList());
    return parsed.map<Student>((json) => Student.fromJson(json)).toList();
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
      var map = Map<String, dynamic>();
      map["nationalid"] = _nationalid;
      map["name"] = _name;
      map["profession"] = _profession;
      map["email"] = _email;
      map["affiliation"] = _affiliation;
      map["type"] = _type;
      map["password"] = _password;
      map["status"] = _status;
      final data = json.encode(map);
      // print(data);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('http://192.168.1.110:3000/members',
          headers: headers, body: data);
      print("data_Ok");
      print('addMember Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> addCategory(
    String _nationalid,
    String _categoryid,
    String _category,
    String _qualifications_languages,
    String _qualifications_IDEs,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map["nationalid"] = _nationalid;
      map["name"] = _categoryid;
      map["profession"] = _category;
      map["email"] = _qualifications_languages;
      map["affiliation"] = _qualifications_IDEs;
      final data = json.encode(map);
      // print(data);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('http://192.168.1.110:3000/category',
          headers: headers, body: data);

      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateCategory(
    String _categoryID,
    String _category,
    String qualifications_Languages,
    String qualifications_IDEs,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map["categoryid"] = _categoryID;
      map["category"] = _category;
      map["qualifications_languages"] = qualifications_Languages;
      map["qualifications_IDEs"] = qualifications_IDEs;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.put(
          'http://192.168.1.110:3000/category/$_categoryID',
          headers: headers,
          body: data);
      print('updateCategory Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateMember(
    String _nationalid,
    String _name,
    String _profession,
    String _email,
    String _affiliation,
    String _password,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map["nationalid"] = _nationalid;
      map["name"] = _name;
      map["profession"] = _profession;
      map["email"] = _email;
      map["affiliation"] = _affiliation;
      map["password"] = _password;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.put(
          'http://192.168.1.110:3000/members/$_nationalid',
          headers: headers,
          body: data);
      print('updateMember Response: ${response.body}');
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
  static Future<String> deleteMember(String nationalId) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.delete(
          'http://192.168.1.110:3000/members/$nationalId',
          headers: headers);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  static Future<String> deleteCategory(String nationalId) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.delete(
          'http://192.168.1.110:3000/category/$nationalId',
          headers: headers);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
