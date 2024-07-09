import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:payment_app/models/user/user_model.dart';
import 'package:payment_app/utils/apis.dart';

class UsersRepository{

  //.........................................................get Users........................................................

  Future fetchingUsers() async {
    try {
      final response = await http.get(Uri.parse(MyAppConstants.users),
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

  //................................................Register Users .......................................................
  Future<Rigister_user> Rigisterusers (
      String first_name,
      String last_name,
      String username,
      String password ,
      String phone ,
      String email ,
      String address,
      String status,
      String subgroup_id,
      String role_id

      ) async {
    // print('id $id');
    // print('Section Id $sectionid');

    Map<String, dynamic> data = {
      "first_name":first_name,
      "last_name":last_name,
      "username":username,
      "password":password,
      "phone":phone,
      "email":email,
      "address":address,
      "status":status,
      "subgroup_id":subgroup_id,
      "role_id":role_id





    };
    try {
      final response = await http.post(Uri.parse(MyAppConstants.addusers),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${StaticData.token}"
            // Set the content type
          },
          body: json.encode(data));

      print('resposeCode  ${response.statusCode}');
      print('body  ${response.body}');

      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "success",);

        final jsonData = json.decode(response.body);
        var record = jsonData['data'];
        var AddUser;
        // var status=jsonData['status'];
        if(jsonData['status'] == 'true'){
          AddUser=Rigister_user.fromJson(record);
          return AddUser;
        }else{
          // Get.snackbar(jsonData['status'], jsonData['message']);

          AddUser=Rigister_user();
        }

        // final trackingList =
        //     record.map((jsonData) => SimpleTracking.fromJson(jsonData)).toList();
        // trackingList.forEach((element) {
        //   print(element.name);
        // });

        return AddUser;
      } else {
        print('error2 $response');
        // Handle error, e.g., throw an exception or return a default TableInfo object
        throw Exception('Failed to ${response.body}');
      }
    } catch (e) {
      // Handle network or other exceptions
      print('Error: $e');

      throw Exception('Failed to tracking');
    }
  }

  //.........................................................Delete Users........................................................
  Future Deleteusers(String id ) async {
    try {
      final response = await http.delete(Uri.parse(MyAppConstants.deleteusers+"/$id"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${StaticData.token}"

        },
      );

    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to Create Menu');
    }
  }


  //................................................update Users .......................................................
  Future<Rigister_user> updateUsers (
      String terminal_sn,
      String product_key,
      String location ,
      String status ,
      String merchant_id ,
      String deviceid

      ) async {
    // print('id $id');
    // print('Section Id $sectionid');

    Map<String, dynamic> data = {
      "terminal_sn":terminal_sn,
      "product_key":product_key,
      "location":location,
      "status":status,
      "merchant_id":merchant_id,


    };
    try {
      final response = await http.put(Uri.parse(MyAppConstants.updateuser+"/${deviceid}"),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${StaticData.token}"
            // Set the content type
          },
          body: json.encode(data));

      print('resposeCode  ${response.statusCode}');
      print('body  ${response.body}');

      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "success",);

        final jsonData = json.decode(response.body);
        var record = jsonData['data'];
        var adddUsers;
        // var status=jsonData['status'];
        if(jsonData['status'] == 'true'){
          adddUsers=Rigister_user.fromJson(record);
          return adddUsers;
        }else{
          // Get.snackbar(jsonData['status'], jsonData['message']);

          adddUsers=Rigister_user();
        }

        // final trackingList =
        //     record.map((jsonData) => SimpleTracking.fromJson(jsonData)).toList();
        // trackingList.forEach((element) {
        //   print(element.name);
        // });

        return adddUsers;
      } else {
        print('error2 $response');
        // Handle error, e.g., throw an exception or return a default TableInfo object
        throw Exception('Failed to ${response.body}');
      }
    } catch (e) {
      // Handle network or other exceptions
      print('Error: $e');

      throw Exception('Failed to tracking');
    }
  }






}