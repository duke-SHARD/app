import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<String> contactList;
  ContactList(this.contactList) {
    print('Contact List initialized');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: contactList.map((contact) =>
        ListTile(
          title: Text(contact)
        )
      ).toList(),
    );
  }
}