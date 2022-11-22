import 'package:flutter/material.dart';
import 'package:van_bill_generation/apicalls/api.dart';

import 'bluetoothScreen.dart';

class BillViewPage extends StatefulWidget {
  List<dynamic> billproducts = [];
  BillViewPage({Key? key, required this.billproducts}) : super(key: key);

  @override
  State<BillViewPage> createState() => _BillViewPageState();
}

class _BillViewPageState extends State<BillViewPage> {
  var grandTotal = 0.0;

  grandTotalfunction() {
    widget.billproducts.forEach((element) {
      var qtyforadd = double.parse(element["qty"].toString());
      var singleprice = double.parse(element["price"].toString());
      var singleTotal = qtyforadd * singleprice;
      setState(() {
        grandTotal = singleTotal + grandTotal;
      });
    });
  }


  shopstockupdate(){
    widget.billproducts.forEach((element) {
      var qty = double.parse(element["qty"].toString());
      var p_id = double.parse(element["id"].toString());
      var shopId = double.parse(element["shop_id"].toString());

      var data = Apis.shopUpdate(shopId.toString(), p_id.toString(), qty.toString(), DateTime.now().toString());

    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    grandTotalfunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
          label: Text("print"),
          onPressed: () {
            shopstockupdate();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PoSSS(fullbill: widget.billproducts,amount: grandTotal.toString(),)));

          },
        ),
      ),
      appBar: AppBar(
        title: Text("Bill View"),
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
                          child: Text(grandTotal.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
