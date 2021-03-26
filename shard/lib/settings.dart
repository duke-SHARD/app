import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './contact_list.dart';
import 'package:flutter/services.dart'; // for input validation
class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  List<String> _contactList = ['Peter Stenger'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body:  SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: ContactList(_contactList),
            ),
            SizedBox(height: 15.0,),
            Text('Bracelet Settings', 
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Press Count'
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSubmitted: (String value) async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('EPIC'),
                      content: Text('You typed $value'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('nice'),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                        )
                      ],
                    );
                  }
                );
              }
            )
          ],
        ),
      )
    );
  }
}