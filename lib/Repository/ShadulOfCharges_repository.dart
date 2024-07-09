import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:payment_app/models/schedule_of_charges/addScheduleOfCharges_modee.dart';

import '../utils/apis.dart';


class ShadulofchargesRepository{

  //.........................................................get Shadul of charges........................................................

  Future fetchingCharges() async {
    try {
      final response = await http.get(Uri.parse(MyAppConstants.charges),
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

//................................................Add SaheduleOf charges .......................................................
  Future<addShadulofCharges> AdddCharges (
      String name,
      String rangeamount,
      String percentage ,
      String fixedamount,
      String status ,
      String merchant_id ,


      ) async {
    // print('id $id');
    // print('Section Id $sectionid');

    Map<String, dynamic> data = {
      "name":name,
      "rangeamount":rangeamount,
      "percentage":percentage,
      "fixedamount":fixedamount,
      "status":status,
      "merchant_id":merchant_id,


    };
    try {
      final response = await http.post(Uri.parse(MyAppConstants.addcharges),
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
        var addcharges;
        // var status=jsonData['status'];
        if(jsonData['status'] == 'true'){
          addcharges=addShadulofCharges.fromJson(record);
          return addcharges;
        }else{
          // Get.snackbar(jsonData['status'], jsonData['message']);

          addcharges=addShadulofCharges();
        }

        // final trackingList =
        //     record.map((jsonData) => SimpleTracking.fromJson(jsonData)).toList();
        // trackingList.forEach((element) {
        //   print(element.name);
        // });

        return addcharges;
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

  //................................................update SaheduleOf charges .......................................................
  Future<addShadulofCharges> updatecharges (
      String name,
      String rangeamount,
      String percentage ,
      String fixedamount,
      String status ,
      String merchant_id ,
      String charges_id


      ) async {
    // print('id $id');
    // print('Section Id $sectionid');

    Map<String, dynamic> data = {
      "name":name,
      "rangeamount":rangeamount,
      "percentage":percentage,
      "fixedamount":fixedamount,
      "status":status,
      "merchant_id":merchant_id,


    };
    try {
      final response = await http.put(Uri.parse(MyAppConstants.updatecharges+"/$charges_id"),
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
        var addcharges;
        // var status=jsonData['status'];
        if(jsonData['status'] == 'true'){
          addcharges=addShadulofCharges.fromJson(record);
          return addcharges;
        }else{
          // Get.snackbar(jsonData['status'], jsonData['message']);

          addcharges=addShadulofCharges();
        }

        // final trackingList =
        //     record.map((jsonData) => SimpleTracking.fromJson(jsonData)).toList();
        // trackingList.forEach((element) {
        //   print(element.name);
        // });

        return addcharges;
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
  //.........................................................Delete Charges........................................................
  Future Deletecharges(String id ) async {
    try {
      final response = await http.delete(Uri.parse(MyAppConstants.deletecharges+"/$id"),
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










}