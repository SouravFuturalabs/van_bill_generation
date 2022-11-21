import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:van_bill_generation/screens/loginScreen.dart';
import 'package:van_bill_generation/screens/shopDetailsPage.dart';
import 'package:van_bill_generation/screens/signUpscreen.dart';
import 'package:van_bill_generation/screens/stockManagePage.dart';

import '../screens/billingScreen.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _selectedIndex = 0;
  PageController? _pageController;

  List<Widget> _widgetOptions = <Widget>[
    StockManagePage(),
    BillingScreen(),
    // ShopDetailsPage(),
    ShopDetailsPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   type: BottomNavigationBarType.shifting,
      //   showSelectedLabels: true,
      //   fixedColor: Colors.white,
      //   unselectedItemColor: Colors.black,
      //   elevation: 2.0,
      //   showUnselectedLabels: true,
      //   selectedLabelStyle: TextStyle(
      //       color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      //   unselectedLabelStyle: TextStyle(
      //       color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
      //   backgroundColor: Color.fromRGBO(53, 133, 228, 1),
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag, color: Colors.black),
      //       backgroundColor: Color.fromRGBO(53, 133, 228, 1),
      //       label: "Stock",
      //       activeIcon: Icon(Icons.shopping_bag, color: Colors.white),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.print,
      //         color: Colors.black,
      //       ),
      //       label: "Billing",
      //       backgroundColor: Color.fromRGBO(53, 133, 228, 1),
      //       activeIcon: Icon(
      //         Icons.print,
      //         color: Colors.white,
      //       ),
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(
      //     //     Icons.date_range_rounded,
      //     //     color: Colors.black,
      //     //   ),
      //     //   backgroundColor: Color.fromRGBO(53, 133, 228, 1),
      //     //   label: "Attendance",
      //     //   activeIcon: Icon(
      //     //     Icons.date_range_rounded,
      //     //     color: Colors.white,
      //     //   ),
      //     // ),
      //     BottomNavigationBarItem(
      //       icon:
      //           Icon(Icons.local_convenience_store_sharp, color: Colors.black),
      //       label: "Shop Details",
      //       backgroundColor: Color.fromRGBO(53, 133, 228, 1),
      //       activeIcon:
      //           Icon(Icons.local_convenience_store_sharp, color: Colors.white),
      //     ),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        containerHeight: 60,

        // backgroundColor:Color.fromRGBO(53, 133, 228, 1) ,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController?.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.shopping_bag,
            ),
            title: Text('Stock'),
            activeColor: Color.fromRGBO(53, 133, 228, 1),
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.print),
              title: Text('Billing'),
              activeColor: Color.fromRGBO(53, 133, 228, 1)),
          BottomNavyBarItem(
              icon: SizedBox(
                height: 26,
                  width: 26,
                  child: Image(
                image: AssetImage(
                  "asstes/shop.png",
                ),
                color: Color.fromRGBO(53, 133, 228, 1),
              )),
              title: Text('Shop Details'),
              activeColor: Color.fromRGBO(53, 133, 228, 1)),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
