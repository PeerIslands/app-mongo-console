import 'package:flutter/material.dart';
import 'package:flutter_auth/new-arch/core/util/constants.dart';
import 'package:flutter_auth/new-arch/features/homepage/presentation/pages/signin_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignInPage(),
    );
  }
}
