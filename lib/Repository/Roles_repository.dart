import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils/apis.dart';

class RolesRepository{
  //.........................................................get Roles........................................................

  Future fetchingRoles() async {
    try {
      final response = await http.get(Uri.parse(MyAppConstants.roles),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${StaticData.token}"

        },
      );
      print('resposeCode  ${response.statusCode}');
      print('body  ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) ;

        return jsonData;
      } else {
        print('error2 $response');
        throw Exception('Failed to ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to Create Menu');
    }
  }




}