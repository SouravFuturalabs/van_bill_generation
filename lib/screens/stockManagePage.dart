import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:van_bill_generation/apicalls/api.dart';

import 'addProducts.dart';
import 'loginScreen.dart';

class StockManagePage extends StatefulWidget {
  const StockManagePage({Key? key}) : super(key: key);

  @override
  State<StockManagePage> createState() => _StockManagePageState();
}

class _StockManagePageState extends State<StockManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context)
        //         .push(MaterialPageRoute(builder: (ctx) => AddProductsPage()));
        //   },
        //   backgroundColor: Color.fromRGBO(53, 133, 228, 1),
        //   tooltip: "Add Stock",
        //   child: Center(
        //     child: Icon(
        //       Icons.add,
        //       color: Colors.white,
        //       size: 30,
        //     ),
        //   ),
        // ),
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(53, 133, 228, 1),
          title: Text(
            "Stock Details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leadingWidth: 130,
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
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: Apis.getStockes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("No Stockes Details Available"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var stocks = snapshot.data[index];
                          var quntity = stocks["Quantity"].toString();
                          int qty = int.parse(quntity);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  // border:
                                  //     Border.all(color: Colors.blue, width: 3),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(2, 2),
                                        spreadRadius: 4,
                                        blurRadius: 4)
                                  ],
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 8,
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Center(
                                  child: ListTile(
                                    title: Container(
                                      child: Text(
                                        stocks["pname"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Rs:${stocks["Price"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                    trailing:qty <= 0? Text("Out of Stock",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.red,
                                            fontSize: 13)):Text("qty:${stocks["Quantity"]}",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            )
          ],
        ));
  }
}
