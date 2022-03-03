import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:myqrscanner/mySplash.dart';
import 'package:myqrscanner/utils/providers/appLanguage.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';
import 'package:myqrscanner/utils/providers/appTheme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

part 'main.g.dart';

@HiveType(typeId: 1)
class QrHistory {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? processingDate;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = (await getApplicationDocumentsDirectory()).path;
  Hive
    ..init(path)
    ..registerAdapter(QrHistoryAdapter());

  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  QRAppTheme qrAppTheme = QRAppTheme();
  await qrAppTheme.fetchTheme();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppLanguage>(
        create: (_) => AppLanguage(),
      ),
      ChangeNotifierProvider<QRAppTheme>(
        create: (_) => QRAppTheme(),
      ),
    ],
    child: Phoenix(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<QRAppTheme>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('mm', 'MM'),
        ],
        title: 'Flutter Demo',
        theme: provider.getTheme,
        home: MySplashScreen());
  }
}
