import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:van_bill_generation/apicalls/api.dart';

import 'loginScreen.dart';


class ShopDetailsPage extends StatefulWidget {
  const ShopDetailsPage({Key? key}) : super(key: key);

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Shop Details",style: TextStyle(color: Colors.white),),
        elevation: 0.0,
        // backgroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(53, 133, 228, 1),
        automaticallyImplyLeading: false,

        centerTitle: true,
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
                future: Apis.getShopDetails(),
                builder: (context,AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Shop Details Available"),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var shopData = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                // border:
                                //     Border.all(color: Colors.blue, width: 3),
                                boxShadow: [BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2,2),
                                  spreadRadius: 4,
                                  blurRadius: 4
                                )],
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 8,
                                top: 8,
                                bottom: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${shopData["shoplist"]}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    "${shopData["Location"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    "${shopData["Phone_no"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    "${shopData["Email"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
