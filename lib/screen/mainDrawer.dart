import 'package:flutter/material.dart';
import 'package:myqrscanner/screen/homePage.dart';
import 'package:myqrscanner/screen/languageScreen.dart';
import 'package:myqrscanner/screen/themeChange.dart';
import 'package:myqrscanner/utils/baseUtils/baseSetting.dart';
import 'package:myqrscanner/utils/designUtils/myColors.dart';
import 'package:myqrscanner/utils/designUtils/myqr_app_icons.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawerPage extends StatefulWidget {
  @override
  _MyDrawerPageState createState() => _MyDrawerPageState();
}

class _MyDrawerPageState extends State<MyDrawerPage> {
  String lng="";

  @override
  void initState() {
    getLocale();
    super.initState();
  }

  getLocale()async{
    var prefs=await SharedPreferences.getInstance();
    lng=prefs.getString("language_code");
    lng=lng==null?"en":lng;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*1/6,
            child: DrawerHeader(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logoImg.png'),radius: 20,backgroundColor: MyColors.primaryColor,
                  ),
                  Container(margin: EdgeInsets.only(left:5),),
                  Text(appName),
                ],
              ),
            ),
          ),
          //Divider(color: Colors.grey,),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.center_focus_weak,color: MyColors.redColor,),
                  title: Text(AppLocalizations.of(context).translate("fromqr")),
                  onTap: () {
                    goToTabBarItems(0);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera,color: MyColors.purpleColor,),
                  title: Text(AppLocalizations.of(context).translate("toqr")),
                  onTap: () {
                    goToTabBarItems(1);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.history,color: MyColors.greenColor,),
                  title: Text(AppLocalizations.of(context).translate("history")),
                  onTap: () {
                    goToTabBarItems(2);
                  },
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey,),
          ListTile(
            leading: Icon(MyqrApp.t_shirt,color:MyColors.orangeColor),
            title: Text(AppLocalizations.of(context).translate("changetheme")),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ThemeChangeScreen()));
            },
          ),
          ListTile(
            leading: IconButton(icon: new Image.asset(lng=="en"?'icons/flags/png/us.png':'icons/flags/png/mm.png', package: 'country_icons'),onPressed: (){},),
            title: Text(AppLocalizations.of(context).translate("changelanguage")),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeLanguageScreen(lng: lng,)));
            },
          ),
          ListTile(
            leading: Icon(MyqrApp.info_outline,color: MyColors.blueGreyColor,),
            title: Text(AppLocalizations.of(context).translate("aboutus")),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  goToTabBarItems(int index){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageScreen(selectedPage: index,)));
  }
}