import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:van_bill_generation/printer2.dart';

class PrinyerTwo extends StatefulWidget {
  const PrinyerTwo({super.key});

  @override
  State<PrinyerTwo> createState() => _PrinyerTwoState();
}

class _PrinyerTwoState extends State<PrinyerTwo> {
  final List<Map<String, dynamic>> data = [
    {"title": "apple", "price": "300", "qty": "4", "total": "25000"},
    {"title": "ornage", "price": "300", "qty": "4", "total": "25000"},
    {"title": "banana", "price": "300", "qty": "4", "total": "25000"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index]["title"]),
              subtitle: Text(data[index]["qty"]),
              trailing: Text(data[index]["total"]),
            );
          })),
          InkWell(
            onTap: (){
               // Navigator.push(
               //      context,
               //      CupertinoPageRoute(
               //        builder: (context) => print2(data: data,)
               //      ));
            },
            child: Container(
              height: 50,
              width: 120,
              color: Colors.red,
              child: Text("print"),
            ),
          )
        ],
      )),
    );
  }
}
