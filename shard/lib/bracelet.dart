import 'package:flutter_blue/flutter_blue.dart';

class Bracelet {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  void debugConnectedResults() async {
    List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
    print('Logging...')
    for(BluetoothDevice in connectedDevices) {
      print(BluetoothDevice);
    }
  }
  void debugScanResults() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
    for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
    }
    });
    flutterBlue.stopScan();
  }
}