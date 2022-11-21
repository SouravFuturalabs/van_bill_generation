// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';

// class Printer extends StatefulWidget {
//   final String orderType;
//   final String orderNumber;
//   final String customerName;
//   final String deliveryTime;
//   final String instruction;
//   final List<String> items;
//    Printer(
//       {Key? key,
//       required this.orderType,
//       required this.orderNumber,
//       required this.customerName,
//       required this.deliveryTime,
//         required this.items,
//       required this.instruction})
//       : super(key: key);

//   @override
//   State<Printer> createState() => _PrinterState();
// }

// class _PrinterState extends State<Printer> {
//   PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
//   List<PrinterBluetooth> _devices = [];
//   String? _devicesMsg;
//   BluetoothManager bluetoothManager = BluetoothManager.instance;

//   void initPrinter() {
//     print('init printer');

//     _printerManager.startScan(Duration(seconds: 2));
//     _printerManager.scanResults.listen((event) {

//       if (!mounted) return;
//       setState(() => _devices = event);

//       if (_devices.isEmpty)
//         setState(() {
//           _devicesMsg = 'No devices';
//         });
//     });
//   }
//   Future<void> _startPrint(PrinterBluetooth printer) async {
//     _printerManager.selectPrinter(printer);
//     final myTicket = await _ticket(PaperSize.mm58);
//     final result = await _printerManager.printTicket(myTicket);
//    print(result);
//   }



//   Future<Ticket> _ticket(PaperSize paper) async {
//     final ticket = Ticket(paper);
//     ticket.text(widget.orderType);
//     ticket.text(widget.orderNumber);
//     ticket.text(widget.customerName);
//     ticket.text(widget.deliveryTime);
//     ticket.text(widget.instruction);

//     ticket.cut();
//     return ticket;
//   }

//   @override
//   void initState() {
//     bluetoothManager.state.listen((val) {
//       print("state = $val");
//       if (!mounted) return;
//       if (val == 12) {
//         print('on');
//         initPrinter();
//       } else if (val == 10) {
//         print('off');
//         setState(() {
//           _devicesMsg = 'Please enable bluetooth to print';
//         });
//       }
//       print('state is $val');
//     });
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Printer page"),
//         ),

//         body:  ListView.builder(
//           itemBuilder: (context, position) => ListTile(
//             onTap: () {
//                _startPrint(_devices[position]);
//             },
//             leading: Icon(Icons.print),
//             title: Text(_devices[position].name.toString()),
//             subtitle: Text(_devices[position].address.toString()),
//           ),
//           itemCount: _devices.length,
//         )
//         );
//   }
// }


