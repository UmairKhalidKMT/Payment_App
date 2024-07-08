import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:payment_app/models/devices/addDevice_model.dart';
import 'package:payment_app/utils/apis.dart';

class device_repository{

  //.........................................................get merchant........................................................

  Future fetchingdevices() async {
    try {
      final response = await http.get(Uri.parse(MyAppConstants.devices),
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

  //................................................Add Device .......................................................
  Future<addDevices> Adddevice (
      String terminal_sn,
      String product_key,
      String location ,
      String status ,
      String merchant_id ,

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
      final response = await http.post(Uri.parse(MyAppConstants.adddevice),
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
          AddBrand=addDevices.fromJson(record);
          return AddBrand;
        }else{
          // Get.snackbar(jsonData['status'], jsonData['message']);

          AddBrand=addDevices();
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