import 'package:flutter/cupertino.dart';
import './settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import './bracelet.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}
class _HomeScreenState extends State<HomeScreen> {
  Bracelet comm = Bracelet();
  @override // this is technically optional, but we override it
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth testing'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              print('button was clicked');
              [
                Permission.location,
              ].request();
              comm.debugScanResults();
            },
            child: Text('scan'),
          ),
        ),
        floatingActionButton: 
          FloatingActionButton(
            child: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Settings())
              );
            },
          ),
        );
  }
}