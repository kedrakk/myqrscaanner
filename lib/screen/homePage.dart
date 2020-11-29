import 'package:flutter/material.dart';
import 'package:myqrscanner/screen/history.dart';
import 'package:myqrscanner/screen/mainDrawer.dart';
import 'package:myqrscanner/screen/photoToQR.dart';
import 'package:myqrscanner/screen/qrToPhoto.dart';
import 'package:myqrscanner/screen/themeChange.dart';
import 'package:myqrscanner/utils/baseUtils/baseSetting.dart';
import 'package:myqrscanner/utils/designUtils/baseTheme.dart';
import 'package:myqrscanner/utils/designUtils/myColors.dart';
import 'package:myqrscanner/utils/designUtils/myqr_app_icons.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';
import 'package:myqrscanner/utils/providers/appTheme.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  final int selectedPage;
  HomePageScreen({this.selectedPage});
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  Icon actionIcon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var provider=Provider.of<QRAppTheme>(context);
    actionIcon=Icon(provider.getTheme==MyThemeData.ligthTheme()?MyqrApp.sun:MyqrApp.moon);
    
    return DefaultTabController(
      initialIndex: widget.selectedPage==null?0:widget.selectedPage,
      length: 3,
      child: Scaffold(
        drawer: MyDrawerPage(),
        appBar: AppBar(
          title: Text(appName),
          actions: <Widget>[
            IconButton(icon: actionIcon,iconSize: 16,color: MyColors.yellowColor,onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ThemeChangeScreen()));
            },)
          ],
          bottom: new TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: MyColors.whiteColor,
            indicatorColor: MyColors.whiteColor,
            unselectedLabelColor: MyColors.white1Color,
            tabs: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(AppLocalizations.of(context).translate("fromqr"))),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(AppLocalizations.of(context).translate("toqr"))),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(AppLocalizations.of(context).translate("history"))),
            ]
          ),
        ),
        body: TabBarView(
          children: [
            QRToPhotoScreen(),PhotoToQRScreen(),HistoryScreen()
          ]
        ),
      ),
    );
  }
}