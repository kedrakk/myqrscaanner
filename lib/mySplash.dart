import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myqrscanner/screen/homePage.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 2),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePageScreen(selectedPage: 0,))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppLocalizations.of(context)!.translate("welcome")!),
      ),
    );
  }
}