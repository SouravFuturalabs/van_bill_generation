// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
//
//
// class print2 extends StatefulWidget {
//   final List<Map<String, dynamic>> data;
//
//   print2({super.key, required this.data});
//
//   @override
//   State<print2> createState() => _print2State();
// }
//
// class _print2State extends State<print2> {
//   PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
//   BluetoothManager bluetoothManager = BluetoothManager.instance;
//   List<PrinterBluetooth> _devices = [];
//   String? _deviceMesg;
//
//
//
//   void initPrinter() {
//     _printerManager.startScan(Duration(seconds: 2));
//     _printerManager.scanResults.listen((val) {
//       print(val);
//       if (!mounted) {
//         return;
//       }
//       setState(() => _devices = val);
//       if (_devices.isEmpty) {
//         setState(() {
//           _deviceMesg = "No devices";
//         });
//       }
//       print("devices =$_devices");
//     });
//   }
//
//   void intt(){
//     _printerManager.scanResults.listen((printers) async {
//
//       print(printers);
//       print("ytryf");
//       // store found printers
//     });
//     _printerManager.startScan(Duration(seconds: 4));
//   }
//
//   Future<void> _startPrinting(PrinterBluetooth printer)async{
//     _printerManager.selectPrinter(printer);
//
//    final result = await _printerManager.printTicket(bytes);
//
//   }
//   List<int> bytes = [];
//
//   Future<List<int>> testTicket()async {
//
//     // Using default profile
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm80, profile);
//    // List<int> bytes = [];
//
//     bytes += generator.text(
//         'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//     bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
//         styles: PosStyles());
//     bytes += generator.text('Special 2: blåbærgrød',
//         styles: PosStyles());
//
//     bytes += generator.text('Bold text', styles: PosStyles(bold: true));
//     bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
//     bytes += generator.text('Underlined text',
//         styles: PosStyles(underline: true), linesAfter: 1);
//     bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
//     bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
//     bytes += generator.text('Align right',
//         styles: PosStyles(align: PosAlign.right), linesAfter: 1);
//
//     bytes += generator.text('Text size 200%',
//         styles: PosStyles(
//           height: PosTextSize.size2,
//           width: PosTextSize.size2,
//         ));
//
//     bytes += generator.feed(2);
//     bytes += generator.cut();
//     return bytes;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     bluetoothManager.state.listen((event) {
//       if(!mounted)return;
//       if(event == 12){
//         initPrinter();
//         print("on");
//       }else if(event == 10){
//         print("off");
//       }
//       print("state is $event");
//     });
//     intt();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _devices.isEmpty
//           ? Center(
//               child: Text(_deviceMesg.toString() ?? ""),
//             )
//           : Column(
//               children: [
//                 ListView.builder(
//                   itemBuilder: (context,index) {
//                     return ListTile(
//                       title: Text(_devices[index].name.toString()),
//                       subtitle: Text(_devices[index].address.toString()),
//                       onTap: (){
//                         print(_devices[index]);
//                         _startPrinting(_devices[index]);
//                       },
//                     );
//                   }
//                 )
//               ],
//             ),
//     );
//   }
// }
