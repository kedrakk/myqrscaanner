import 'package:flutter/material.dart';
import 'package:myqrscanner/utils/designUtils/baseTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRAppTheme extends ChangeNotifier{
  ThemeData? _currentTheme;

  QRAppTheme(){
    fetchTheme();
  }

  fetchTheme()async{
    var prefs=await SharedPreferences.getInstance();
    if(prefs.getString("theme")=="dark"){
      _currentTheme=MyThemeData.darkTheme();
    }
    else{
      _currentTheme=MyThemeData.ligthTheme();
    }
    notifyListeners();
  }

  ThemeData get getTheme=>_currentTheme??MyThemeData.ligthTheme();

  void changeTheme(ThemeData newTheme)async{

    var prefs=await SharedPreferences.getInstance();
    if(newTheme==MyThemeData.darkTheme()){
      await prefs.setString("theme", "dark");
    }else{
      await prefs.setString("theme", "light");
    }
    _currentTheme=newTheme;
    notifyListeners();
  }

}