import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> displayTextInputDialog(BuildContext context, String title,
    String placeholder, Function callback) async {
  String textFieldValue = '';

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          onChanged: (value) {
            textFieldValue = value;
          },
          decoration: InputDecoration(hintText: placeholder),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent)),
            child: Text('CANCEL', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            child: Text('OK', style: TextStyle(color: Colors.white)),
            onPressed: () {
              callback(textFieldValue);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
