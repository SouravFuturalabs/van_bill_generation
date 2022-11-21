import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apicalls/api.dart';
import 'billviewPage.dart';
import 'loginScreen.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  List<Map> products = [];
  List<Map> shopes = [];
  List<dynamic> addedPrdocts = [];

  getshopnames() async {
    List shop = await Apis.getShopDetails();
    shop.forEach((element) {
      setState(() {
        shopes.add({"shopName": element["shoplist"], "id": element["Shop_id"]});
      });
    });

    print(shopes);
    // List data =shop.map((e) {
    //   return e["shoplist"];
    // }).toList();
    // print(data);
    // setState(() {
    //   shopes.addAll(data);
    // });
  }

  getproducts() async {
    List productslist = await Apis.getStockes();
    print(productslist);
    productslist.forEach((element) {
      setState(() {
        products.add({
          "products": element["pname"],
          "qty": element["Quantity"],
          "price": element["Price"],
          "id": element["Product_id"]
        });
      });
    });

    print(products);
  }

  @override
  void initState() {
    // TODO: implement initState
    getshopnames();
    getproducts();
    super.initState();
  }

  Map? selctedShop;
  Map? selectedProduct;
  String? shopId;
  bool isShopSelected = true;
  TextEditingController qtyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Shop Details"),
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [InkWell(
            onTap: ()async{
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("Do You Want LogOut ?"),
                  actions: [
                    TextButton(onPressed: ()async{
                      SharedPreferences pr =await SharedPreferences.getInstance();
                      Navigator.of(context).pushAndRemoveUntil(
                        // the new route
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),

                            (Route route) => false,
                      );
                      pr.clear();
                    }, child: Text("Yes")),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("No"))
                  ],
                );
              },);


            },
            child: Icon(Icons.logout))],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    "Shop Name",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map>(
                      isExpanded: true,
                      elevation: 0,

                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),

                      hint: Text(
                        ' Please choose products',
                      ), // Not necessary for Option 1
                      value: selctedShop,
                      onChanged: (newValue) {
                        setState(() {
                          isShopSelected = false;
                          selctedShop = newValue;
                          shopId = selctedShop!["id"];
                          print(selctedShop);
                        });
                      },
                      items: shopes.map((location) {
                        return DropdownMenuItem(
                          child: Container(
                            child: new Text(
                              location["shopName"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    "Products",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: DropdownButtonHideUnderline(
                    child: IgnorePointer(
                      ignoring: isShopSelected,
                      child: DropdownButton<Map>(
                        isExpanded: true,
                        elevation: 0,

                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),

                        hint: Text(
                          ' Please choose products',
                        ), // Not necessary for Option 1
                        value: selectedProduct,
                        onChanged: (newValue) {
                          setState(() {
                            selectedProduct = newValue;
                          });
                        },
                        items: products.map((location) {
                          return DropdownMenuItem(
                            child: Container(
                              child: new Text(
                                location["products"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    "Quantity",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Quantity",
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if (qtyController.text.isNotEmpty) {
                        var qtys = int.parse(qtyController.text);
                        var avibleqty =
                            int.parse(selectedProduct!["qty"].toString());
                        if (avibleqty >= qtys) {
                          setState(() {
                            addedPrdocts.add({
                              "products": selectedProduct!["products"],
                              "qty": qtyController.text,
                              "price": selectedProduct!["price"],
                              "id": selectedProduct!["id"],
                              "shop_id": shopId,
                            });
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("out of limit"),
                          ));
                        }

                        print("selected list");
                        print(addedPrdocts);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("please select the quantity"),
                        ));
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                          "Add",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(53, 133, 228, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if (addedPrdocts.isNotEmpty) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => BillViewPage(
                                  billproducts: addedPrdocts,
                                )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("No items added"),
                        ));
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                          "View Bill",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(53, 133, 228, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Expanded(
            //   child: Container(
            //
            //     child: ListView.builder(
            //       itemCount: addedPrdocts.length,
            //       itemBuilder: (context,index) {
            //         return Text(addedPrdocts[index]);
            //       }
            //     ),
            //   ),
            // )
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Text(
                    "Quantity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: addedPrdocts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Container(
                                  width: 180,
                                  child: Text(
                                    addedPrdocts[index]["products"].toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Container(
                                  width: 45,
                                  child: Text(
                                    qtyController.text,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
