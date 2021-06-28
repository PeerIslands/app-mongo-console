import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

class LoadRequests extends StatelessWidget {
  final Widget reloadPage;

  const LoadRequests({
    Key key, this.reloadPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              defaultButtonColor(context)),
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700)),
          foregroundColor: MaterialStateProperty.all<Color>(
              defaultButtonTextColor(context))),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return reloadPage;
            },
          ),
        );
      },
      icon: Icon(Icons.refresh, size: 30),
      label: Text("LOAD REQUESTS"),
    );
  }
}