import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/bottomNavigation.dart';

class FianlBillView extends StatefulWidget {
  List<dynamic> billproducts = [];
  var grandTotal;
  FianlBillView(
      {super.key, required this.billproducts, required this.grandTotal});

  @override
  State<FianlBillView> createState() => _FianlBillViewState();
}

class _FianlBillViewState extends State<FianlBillView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Final Bill View"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "products",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text("Qty",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Price",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Total",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.billproducts.length,
                        padding: EdgeInsets.only(bottom: 60),
                        itemBuilder: (context, index) {
                          var qtyforadd = double.parse(
                              widget.billproducts[index]["qty"].toString());
                          var singleprice = double.parse(
                              widget.billproducts[index]["price"].toString());
                          var singleTotal = qtyforadd * singleprice;
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                      width: 130,
                                      child: Text(
                                        widget.billproducts[index]["products"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 18.0),
                                        child: Text(
                                          widget.billproducts[index]["qty"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 18.0),
                                        child: Text(
                                          widget.billproducts[index]["price"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 14.0),
                                        child: Text(
                                          singleTotal.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey)]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Grand Total",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.grandTotal.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BottomNavigationBarPage(0),
                  ),

                  (Route route) => false,
                );
              },
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(53, 133, 228, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(4, 4),
                        spreadRadius: 1,
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
