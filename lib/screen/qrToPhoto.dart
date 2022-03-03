import 'dart:io';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myqrscanner/main.dart';
import 'package:myqrscanner/utils/designUtils/myColors.dart';
import 'package:myqrscanner/utils/designUtils/myqr_app_icons.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

class QRToPhotoScreen extends StatefulWidget {
  @override
  _QRToPhotoScreenState createState() => _QRToPhotoScreenState();
}

class _QRToPhotoScreenState extends State<QRToPhotoScreen> {
  String? result = "";
  String tempres = "";
  String type = "";
  File? _image;
  ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  autoScan() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.translate("select")!),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.center_focus_strong),
                    onPressed: () {
                      Navigator.pop(context);
                      scanWithScanner();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      Navigator.pop(context);
                      takePhoto();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      Navigator.pop(context);
                      choosePhoto();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  takePhoto() async {
    final img = await _imagePicker.getImage(
        source: ImageSource.camera, maxWidth: 200, maxHeight: 200);
    if (img != null) {
      tempres = "tempres";
      setState(() {
        _image = File(img.path);
      });
      getScanType();
    }
  }

  choosePhoto() async {
    final img = await _imagePicker.getImage(
        source: ImageSource.gallery, maxWidth: 200, maxHeight: 200);
    if (img != null) {
      tempres = "tempres";
      setState(() {
        _image = File(img.path);
      });
      getScanType();
    }
  }

  getScanType() async {
    // FirebaseVisionImage visionImage=FirebaseVisionImage.fromFile(_image!);
    // final BarcodeDetector barcodeDetector =FirebaseVision.instance.barcodeDetector();
    // final List<Barcode> barcodes =await barcodeDetector.detectInImage(visionImage);
    // if(barcodes.length>0){
    //   for (Barcode barcode in barcodes) {
    //     final String? rawValue = barcode.rawValue;
    //     setState(() {
    //       result=rawValue;
    //     });
    //     storeInBox();
    //   }
    // }
    // else{
    //   setState(() {
    //     result="Unidentified qr!!Try again";
    //   });
    // }
    // barcodeDetector.close();
    // if(result!.contains("http")){
    //   confirmLaunch();
    // }
  }

  scanWithScanner() async {
    String? scanResult = await scanner.scan();
    result = scanResult;
    setState(() {});
    storeInBox();
    if (result!.contains("http")) {
      confirmLaunch();
    }
  }

  storeInBox() async {
    var box = await Hive.openBox('qrHistory');
    var history = QrHistory()
      ..id = 1
      ..name = result
      ..processingDate = DateTime.now().toString();
    await box.put('allhistory', history);
    box.close();
  }

  confirmLaunch() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(result!),
            content:
                Text(AppLocalizations.of(context)!.translate("openinbrowser")!),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalizations.of(context)!.translate("cancel")!),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(AppLocalizations.of(context)!.translate("ok")!),
                onPressed: () {
                  Navigator.pop(context);
                  _launchURL(result!);
                },
              ),
            ],
          );
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if ((result == "" || result == null) && _image == null && tempres == "") {
        autoScan();
      }
    });
    return Scaffold(
      body: Container(
        child: result == "" || result == null
            ? Center(
                child: Text(
                AppLocalizations.of(context)!.translate("scannow")!,
                style: TextStyle(fontSize: 18),
              ))
            : SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: <Widget>[scanResultSection()],
                )),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
        foregroundColor: MyColors.whiteColor,
        onPressed: () => autoScan(),
        tooltip: AppLocalizations.of(context)!.translate("scannow"),
        child: Icon(
          MyqrApp.qrcode,
        ),
      ),
    );
  }

  Widget scanResultSection() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 10),
      child: Column(
        children: <Widget>[
          qrImageSection(),
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
              child: Text(
                result == "Unidentified qr!!Try again"
                    ? AppLocalizations.of(context)!.translate("unidentifiedqr")!
                    : result!,
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }

  Widget qrImageSection() {
    return Center(
      child: result == "Unidentified qr!!Try again" && _image != null
          ? Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 5 / 6,
                height: MediaQuery.of(context).size.height * 1 / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(_image!))),
              ),
            )
          : Card(
              color: MyColors.whiteColor,
              child: Container(
                padding: EdgeInsets.all(6),
                child: QrImage(
                  foregroundColor: MyColors.primaryColor,
                  data: result!,
                  version: QrVersions.auto,
                  gapless: true,
                  size: 250.0,
                ),
              ),
            ),
    );
  }
}
