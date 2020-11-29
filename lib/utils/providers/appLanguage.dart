import 'package:flutter/material.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale ;
  AppLocalizations localizations;

  Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
   // localizations.locale=_appLocale;
    print(_appLocale.languageCode);
    return Null;
  }

  Future<void> changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale('mm')) {
      _appLocale = Locale('mm');
      await prefs.setString('language_code', 'mm');
      await prefs.setString('countryCode', 'MM');
    }
    else{
      _appLocale = Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
  
}