import 'package:flutter/material.dart';
import 'package:myqrscanner/utils/designUtils/baseTheme.dart';
import 'package:myqrscanner/utils/designUtils/myColors.dart';
import 'package:myqrscanner/utils/providers/appTheme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChangeScreen extends StatefulWidget {
  @override
  _ThemeChangeScreenState createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {
  String? curtheme="";

  @override
  void initState() {
    getThemename();
    super.initState();
  }

  getThemename()async{
    var prefs=await SharedPreferences.getInstance();
    if(prefs.getString("theme")!=null){
      curtheme=prefs.getString("theme");
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("change theme"),elevation: 0.7,),
      body: Container(
        margin: EdgeInsets.only(top:20),
        child: toChangeTheme()
      ),
    );
  }

  Widget toChangeTheme(){

    var provider=Provider.of<QRAppTheme>(context);

    return Container(
      margin: EdgeInsets.all(6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
        GestureDetector(
          child: Container(
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:5),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.blueGreyColor),
                  shape: BoxShape.circle,
                  color: MyColors.whiteColor
                ),
                padding: EdgeInsets.all(30),
              ),
              Text("Light"),
              Container(margin: EdgeInsets.only(top:3),),
              Icon(Icons.check_circle_outline,color: curtheme=="light"?MyColors.primaryColor:MyColors.transparentColor,)
            ],),
          ),
          onTap: (){
            provider.changeTheme(MyThemeData.ligthTheme());
          },
        ),
        GestureDetector(
          child: Container(
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:5),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.blueGreyColor),
                  shape: BoxShape.circle,
                  color: MyColors.blackColor
                ),
                padding: EdgeInsets.all(30),
              ),
              Container(margin: EdgeInsets.only(top:5),),
              Text("dark"),
              Container(margin: EdgeInsets.only(top:3),),
              Icon(Icons.check_circle_outline,color: curtheme=="dark"?MyColors.primaryColor:MyColors.transparentColor)
            ],),
          ),
          onTap: (){
            provider.changeTheme(MyThemeData.darkTheme());
          },
        )
      ],),
    );
  }
}