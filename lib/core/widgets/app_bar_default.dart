import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const AppBarDefault({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Color.fromRGBO(73, 82, 85, 1.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Center(
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0)),
          )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
