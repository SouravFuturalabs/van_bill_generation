import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:van_bill_generation/screens/signUpscreen.dart';
import 'screens/bluetoothScreen.dart';
import 'package:van_bill_generation/tested/home_screen.dart';
import 'package:van_bill_generation/widgets/bottomNavigation.dart';
import 'package:van_bill_generation/screens/loginScreen.dart';

import 'tested/homepage2.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences =await SharedPreferences.getInstance();
  var Data = preferences.getString("id");
  print(Data);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp( MyApp(id: Data.toString(),)));
}

class MyApp extends StatelessWidget {
  String id;
   MyApp({super.key,required this.id});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: id.isEmpty ? LoginPage():id == "null" ?LoginPage():BottomNavigationBarPage(0),
    );
  }
}
