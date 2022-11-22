// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:flutter/material.dart';
// //import 'package:blue_thermal_printer_example/testprint.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:flutter/services.dart';
//
// class Blue extends StatefulWidget {
//   const Blue({Key? key}) : super(key: key);
//
//   @override
//   State<Blue> createState() => _BlueState();
// }
//
// class _BlueState extends State<Blue> {
// // PrinterBluetoothManager printerManager = PrinterBluetoothManager();
// // List<PrinterBluetooth> _devices = [];
//   BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
//
//   List<BluetoothDevice> _devices = [];
//   BluetoothDevice? _device;
//   bool _connected = false;
//
// //TestPrint testPrint = TestPrint();
//   Future<void> initPlatformState() async {
//     bool? isConnected = await bluetooth.isConnected;
//     List<BluetoothDevice> devices = [];
//     try {
//       devices = await bluetooth.getBondedDevices();
//     } on PlatformException {}
//
//     bluetooth.onStateChanged().listen((state) {
//       switch (state) {
//         case BlueThermalPrinter.CONNECTED:
//           setState(() {
//             _connected = true;
//             print("bluetooth device state: connected");
//           });
//           break;
//         case BlueThermalPrinter.DISCONNECTED:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: disconnected");
//           });
//           break;
//         case BlueThermalPrinter.DISCONNECT_REQUESTED:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: disconnect requested");
//           });
//           break;
//         case BlueThermalPrinter.STATE_TURNING_OFF:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: bluetooth turning off");
//           });
//           break;
//         case BlueThermalPrinter.STATE_OFF:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: bluetooth off");
//           });
//           break;
//         case BlueThermalPrinter.STATE_ON:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: bluetooth on");
//           });
//           break;
//         case BlueThermalPrinter.STATE_TURNING_ON:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: bluetooth turning on");
//           });
//           break;
//         case BlueThermalPrinter.ERROR:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: error");
//           });
//           break;
//         default:
//           print(state);
//           break;
//       }
//     });
//
//     if (!mounted) return;
//     setState(() {
//       _devices = devices;
//     });
//
//     if (isConnected == true) {
//       setState(() {
//         _connected = true;
//       });
//     }
//   }
//   void _connect() {
//     if (_device == null) {
//       print('No device selected.');
//     } else {
//       bluetooth.isConnected.then((isConnected) {
//         if (!isConnected) {
//           bluetooth.connect(_device).catchError((error) {
//             setState(() => _connected = false);
//           });
//           setState(() => _connected = true);
//         }
//       });
//     }
//   }
//
//   void _tesPrint() async {
//     //SIZE
//     // 0- normal size text
//     // 1- only bold text
//     // 2- bold with medium text
//     // 3- bold with large text
//     //ALIGN
//     // 0- ESC_ALIGN_LEFT
//     // 1- ESC_ALIGN_CENTER
//     // 2- ESC_ALIGN_RIGHT
//     bluetooth.isConnected.then((_connected) {
//       if (_connected==true) {
//         bluetooth.printNewLine();
//         bluetooth.printCustom("HEADER",3,1);
//         bluetooth.printNewLine();
//        // bluetooth.printImage(pathImage);   //path of your image/logo
//         bluetooth.printNewLine();
//         //bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
//         bluetooth.printLeftRight("LEFT", "RIGHT",0);
//         bluetooth.printLeftRight("LEFT", "RIGHT",1);
//         bluetooth.printLeftRight("LEFT", "RIGHT",1,format: "%-15s %15s %n");
//         bluetooth.printNewLine();
//         bluetooth.printLeftRight("LEFT", "RIGHT",2);
//         bluetooth.printLeftRight("LEFT", "RIGHT",3);
//         bluetooth.printLeftRight("LEFT", "RIGHT",4);
//         bluetooth.printNewLine();
//         bluetooth.print3Column("Col1", "Col2", "Col3",1);
//         bluetooth.print3Column("Col1", "Col2", "Col3",1,format: "%-10s %10s %10s %n");
//         bluetooth.printNewLine();
//         bluetooth.print4Column("Col1","Col2","Col3","Col4",1);
//         bluetooth.print4Column("Col1","Col2","Col3","Col4",1,format: "%-8s %7s %7s %7s %n" );
//         bluetooth.printNewLine();
//         String testString = " čĆžŽšŠ-H-ščđ";
//         bluetooth.printCustom(testString, 1, 1, charset: "windows-1250");
//         bluetooth.printLeftRight("Številka:", "18000001", 1, charset: "windows-1250");
//         bluetooth.printCustom("Body left",1,0);
//         bluetooth.printCustom("Body right",0,2);
//         bluetooth.printNewLine();
//         bluetooth.printCustom("Thank You",2,1);
//         bluetooth.printNewLine();
//         bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
//         bluetooth.printNewLine();
//         bluetooth.printNewLine();
//         bluetooth.paperCut();
//       }
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//                 onTap: () {
//                   initPlatformState();
//                   // printerManager.startScan(Duration(seconds: 4));
//                   // printerManager.scanResults.listen((scannedDevices) {
//                   //   setState(() {
//                   //     _devices=scannedDevices;
//                   //     print("_device $_devices");
//                   //   });
//                   // });
//                 },
//                 child: Text('data')),
//             InkWell(onTap: (){
//               print(_devices[0].address);
//             },
//                 child: Text("yy"))
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:typed_data';
//import 'package:blue_thermal_printer_example/testprint.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../apicalls/api.dart';

class PoSSS extends StatefulWidget {
  List<dynamic> fullbill=[];
  String? amount;
  PoSSS(

  {required this.fullbill,required this.amount});

  @override
  _PoSSSState createState() => new _PoSSSState();
}

class _PoSSSState extends State<PoSSS> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  String? pathImage;
  //TestPrint? testPrint;

  void _tesPrint() async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT
    bluetooth.isConnected.then((isConnected) {
      print("print.11 $isConnected");
      if (isConnected!) {
        print("print");
        bluetooth.printNewLine();
        // bluetooth.printCustom("HEADER",3,1);
        bluetooth.printCustom("Futura labs", 3, 1);
        bluetooth.printNewLine();
        //bluetooth.printImage(pathImage);   //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printCustom("----------------------------", 3, 1);
        bluetooth.print4Column("product", "qty", "price", "total", 1);
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank You", 2, 1);
        //bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBnytes, bytes.lengthInBytes));
        // bluetooth.printLeftRight("LEFT", "RIGHT",0);
        // bluetooth.printLeftRight("LEFT", "RIGHT",1);
        // bluetooth.printLeftRight("LEFT", "RIGHT",1,format: "%-15s %15s %n");
        // bluetooth.printNewLine();
        // bluetooth.printLeftRight("LEFT", "RIGHT",2);
        // bluetooth.printLeftRight("LEFT", "RIGHT",3);
        // bluetooth.printLeftRight("LEFT", "RIGHT",4);
        // bluetooth.printNewLine();
        // bluetooth.print3Column("Col1", "Col2", "Col3",1);
        // bluetooth.print3Column("Col1", "Col2", "Col3",1,format: "%-10s %10s %10s %n");
        // bluetooth.printNewLine();
        // bluetooth.print4Column("Col1","Col2","Col3","Col4",1);
        // bluetooth.print4Column("Col1","Col2","Col3","Col4",1,format: "%-8s %7s %7s %7s %n" );
        // bluetooth.printNewLine();
        // String testString = " čĆžŽšŠ-H-ščđ";
        // bluetooth.printCustom(testString, 1, 1, charset: "windows-1250");
        // bluetooth.printLeftRight("Številka:", "18000001", 1, charset: "windows-1250");
        // bluetooth.printCustom("Body left",1,0);
        // bluetooth.printCustom("Body right",0,2);
        // bluetooth.printNewLine();
        // bluetooth.printCustom("Thank You",2,1);
        // bluetooth.printNewLine();
        // bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
        // bluetooth.printNewLine();
        // bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // initSavetoPath();
    // testPrint = TestPrint();
  }

  // initSavetoPath() async {
  //   //read and write
  //   //image max 300px X 300px
  //   final filename = 'yourlogo.png';
  //   var bytes = await rootBundle.load("assets/images/yourlogo.png");
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   writeToFile(bytes, '$dir/$filename');
  //   setState(() {
  //     pathImage = '$dir/$filename';
  //   });
  // }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected!) {
      setState(() {
        _connected = true;
      });
    }
  }

  String? selectedModeofPAy;

  List<String> modeOfPay = ["Cash", "Check"];

  billupdate()async{
  var shopid;
    widget.fullbill.forEach((element) {
     shopid = double.parse(element["shop_id"].toString());
    });
    var amount = double.parse(widget.amount.toString());
    print(amount);
    var data = await Apis.billupdate(shopid.toString(), selectedModeofPAy,amount);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text("Printer Details"),
          elevation: 0.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        elevation: 0,

                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),

                        hint: Text(
                          ' Please Choose Mode of pay',
                        ), // Not necessary for Option 1
                        value: selectedModeofPAy,
                        onChanged: (newValue) {
                          setState(() {
                            selectedModeofPAy = newValue;
                          });
                        },
                        items: modeOfPay.map((location) {
                          return DropdownMenuItem(
                            child: Container(
                              child: new Text(
                                location,
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
                Container(
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Device:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: DropdownButton(
                            items: _getDeviceItems(),
                            onChanged: (value) =>
                                setState(() => _device = value),
                            value: _device,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () {
                        initPlatformState();
                        print(_devices);
                      },
                      child: Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: _connected ? Colors.red : Colors.green),
                      onPressed: _connected ? _disconnect : _connect,
                      child: Text(
                        _connected ? 'Disconnect' : 'Connect',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.brown),
                    onPressed: () {
                      // testPrint.sample(pathImage);
                      billupdate();

                      //_tesPrint();
                    },
                    child: Text('PRINT TEST',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Container(width: 100, child: Text(device.name.toString())),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
            print("error in connection of blue");
          });
          setState(() => _connected = true);
          print("blue  connected");
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = true);
  }

//write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
}
