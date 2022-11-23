import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/bottomNavigation.dart';

class Apis {

  static final ip ="192.168.29.86";


  /// ------------- login api
  Future<dynamic> loginApicall(String userName, String password) async {
    final url = "http://${ip}/MobileBillingAppGit/API/login.php";

    var userData = {"user_name": userName, "password": password};

    var response = await post(Uri.parse(url), body: userData);
    if (response.statusCode == 200) {
      var id = jsonDecode(response.body)["vanid"];
      print(response.body);

      return id;
    }
  }

  /// ------------- login api
  Future<dynamic> signUpApicall(String van_number, String driver_name,
      String driver_phone, String email) async {
    final url = "http://${ip}/MobileBillingAppGit/API/vehicle_reg.php";

    var userData = {
      "Van_num": van_number,
      "D_name": driver_name,
      "D_ph": driver_phone,
      "email": email
    };

    var response = await post(Uri.parse(url), body: userData);
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)["message"];
      print(response.body);

      return message;
    }
  }


  ///------------- shop details
 static Future<dynamic> getShopDetails() async {
    final url = "http://${ip}/MobileBillingAppGit/API/view_shoplist.php";

    var response = await get(Uri.parse(url),);
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      print(response.body);

      return message;
    }
  }

///------------------------------- for van stockes
 static Future<dynamic> getStockes() async {
    print("sdfdrsf");
    final url = "http://${ip}/MobileBillingAppGit/API/stock_view.php";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var vanId = preferences.getString("id");
    print(vanId);

    var userData = {
      "Van_id": vanId,
    };

    var response = await post(Uri.parse(url), body: userData);
    if (response.statusCode == 200) {
      print(response.body);
      var message = jsonDecode(response.body);
      if(message[0]["message"] != "failed"){
        return message;
      }
      print(response.body);


    }
  }

  static Future<dynamic> shopUpdate(String shopId,p_id,qty,date) async {
    print("sdfdrsf");
    final url = "http://${ip}/MobileBillingAppGit/API/shop_stock.php";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var vanId = preferences.getString("id");

    var userData = {
      "Van_id": vanId,
      "shop_id":shopId,
      "product_id":p_id,
      "quantity":qty,
      "date":date
    };

    var response = await post(Uri.parse(url), body: userData);
    if (response.statusCode == 200) {

      var message = jsonDecode(response.body);
      print(response.body);

      return message;
    }
  }

  ///--------- b ill
  static Future<dynamic> billupdate(String shopId,modeofpay,double amount) async {
    print("sdfdrsf");
    final url = "http://${ip}/MobileBillingAppGit/API/bill.php";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var vanId = preferences.getString("id");

    var userData = {
      "Van_id": vanId,
      "shop_id":shopId,
      "modeofpay":modeofpay,
      "amount":amount.toString(),

    };
    print(userData);

    var response = await post(Uri.parse(url), body: userData);
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      print(response.body);

      return message;
    }
  }




}
