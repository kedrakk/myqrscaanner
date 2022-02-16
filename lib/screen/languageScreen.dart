import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:myqrscanner/utils/designUtils/myColors.dart';
import 'package:myqrscanner/utils/providers/appLanguage.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';
import 'package:provider/provider.dart';

class ChangeLanguageScreen extends StatefulWidget {
  final String? lng;
  ChangeLanguageScreen({this.lng}):super();
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {

  String? lng="";

  @override
  void initState() {
    getLocale();
    super.initState();
  }

  getLocale(){
    lng=widget.lng;
  }

  @override
  Widget build(BuildContext context) {

    var appLanguage = Provider.of<AppLanguage>(context);

    languageChange(String newlng){
      if(newlng==lng){
        return;
      }
      else{
        appLanguage.changeLanguage(newlng=='mm'?new Locale('mm'):new Locale('en'));
        Phoenix.rebirth(context);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.translate("changelanguage")!),elevation: 0.7,),
      body: SafeArea(
        child: Container(
          child: Column(children: <Widget>[
            ListTile(
              leading: IconButton(icon: new Image.asset('icons/flags/png/us.png', package: 'country_icons'),onPressed: (){},),
              title: Text("English"),
              trailing: Icon(Icons.radio_button_checked,color: lng=="en"?MyColors.primaryColor:MyColors.transparentColor,),
              onTap: (){
                languageChange("en");
              },
            ),
            ListTile(
              leading: IconButton(icon: new Image.asset('icons/flags/png/mm.png', package: 'country_icons'),onPressed: (){},),
              title: Text("မြန်မာ"),
              trailing: Icon(Icons.radio_button_checked,color: lng=="mm"?MyColors.primaryColor:MyColors.transparentColor,),
              onTap: (){
                languageChange("mm");
              },
            ),
          ],),
        ),
      ),
    );
  }
}