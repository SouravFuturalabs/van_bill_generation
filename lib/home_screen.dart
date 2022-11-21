import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homepage2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                List<String> myList = [];
                for (int i = 0; i < 4; ++i) {
                  myList.add('Item nr $i');
                }
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PrinyerTwo()
                    ));
              },
              child: Container(
                height: 50,
                width: 120,
                color: Colors.red,
                child: Center(
                  child: Text("Add Products"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
