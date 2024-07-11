import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:payment_app/utils/apis.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/merchant/addmerchant_model.dart';

class MerchantRepository{


  //................................................Add merchant .......................................................
  Future<addmerchants> Addmerchant (String name, String phone,String email ,String bussiness_name , String status , String adress , String subgroup_id) async {
    // print('id $id');
    // print('Section Id $sectionid');

    Map<String, dynamic> data = {
      "name":name,
      "phone":phone,
      "email":email,
      "business_name":bussiness_name,
      "status":status,
      "address":adress,
      "subgroup_id":subgroup_id

    };
    try {
      final response = await http.post(Uri.parse(MyAppConstants.addmerchant),
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
        var AddBrand;
        // var status=jsonData['status'];
        if(jsonData['status'] == 'true'){
          AddBrand=addmerchants.fromJson(record);
          return AddBrand;
        }else{
          // Get.snackbar(jsonData['status'], jsonData['message']);
          Fluttertoast.showToast(msg: "invalid",);
          AddBrand=addmerchants();
        }

        // final trackingList =
        //     record.map((jsonData) => SimpleTracking.fromJson(jsonData)).toList();
        // trackingList.forEach((element) {
        //   print(element.name);
        // });

        return AddBrand;
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

  //.........................................................get merchant........................................................
  Future fetchingmerchant() async {
    try {
      final response = await http.get(Uri.parse(MyAppConstants.merchantDetails),
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

  //.........................................................Delete merchant........................................................
  Future Deletemerchant(String id ) async {
    try {
      final response = await http.delete(Uri.parse(MyAppConstants.deletemerhcant+"/$id"),
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

  //................................................update merchant .......................................................
  Future<addmerchants> updatemerchant (
      String name, String phone,String email ,String bussiness_name , String status , String adress , String subgroup_id, String? merchantid
      ) async {
    // print('id $id');
    // print('Section Id $sectionid');

    Map<String, dynamic> data = {
      "name":name,
      "phone":phone,
      "email":email,
      "business_name":bussiness_name,
      "status":status,
      "address":adress,
      "subgroup_id":subgroup_id

    };
    try {
      final response = await http.put(Uri.parse(MyAppConstants.updatemerchant+"/${merchantid}"),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${StaticData.token}"
            // Set the content type
          },
          body: json.encode(data));

      print('resposeCode  ${response.statusCode}');
      print('body  ${response.body}');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "success",);

        final jsonData = json.decode(response.body);
        var record = jsonData['data'];
        var AddBrand;
        // var status=jsonData['status'];
        if(jsonData['status'] == 'true'){
          AddBrand=addmerchants.fromJson(record);
          return AddBrand;
        }else{
          // Get.snackbar(jsonData['status'], jsonData['message']);

          AddBrand=addmerchants();
        }

        // final trackingList =
        //     record.map((jsonData) => SimpleTracking.fromJson(jsonData)).toList();
        // trackingList.forEach((element) {
        //   print(element.name);
        // });

        return AddBrand;
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