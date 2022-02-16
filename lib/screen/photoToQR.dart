import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
// import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myqrscanner/utils/designUtils/myColors.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class PhotoToQRScreen extends StatefulWidget {
  @override
  _PhotoToQRScreenState createState() => _PhotoToQRScreenState();
}

class _PhotoToQRScreenState extends State<PhotoToQRScreen> {

  final qrText=TextEditingController();
  static GlobalKey previewContainer = new GlobalKey();
  String errorText="";
  String type="";//bool qrVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              textToQRField(),
              Container(
                child: RepaintBoundary(
                  key: previewContainer,
                  child: GestureDetector(
                    child: Column(children: <Widget>[
                      qrSection(),
                      barcodeSection(),
                    ],),
                    onTap: (){
                      confirmSs();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  confirmSs(){
    showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.translate("confirmation")!),
          content: Text(AppLocalizations.of(context)!.translate("areyousure")!),
          actions: <Widget>[
            FlatButton(child: Text(AppLocalizations.of(context)!.translate("ok")!),onPressed: (){
              Navigator.pop(context);
              takeScreenShot();
            },),
            FlatButton(child: Text(AppLocalizations.of(context)!.translate("cancel")!),onPressed: (){
              Navigator.pop(context);
            },)
          ],
        );
      }
    );
  }

  takeScreenShot()async{
    RenderRepaintBoundary boundary = previewContainer.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await (image.toByteData(format: ui.ImageByteFormat.png) as FutureOr<ByteData>);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile =new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
    final snackBar = SnackBar(
    content: Text('Saved to $directory'),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        Scaffold.of(context).hideCurrentSnackBar();
      },
    ),
  );
  Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget textToQRField(){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width*2.5/3,
      child: TextFormField(
        controller: qrText,
        decoration: InputDecoration(
          suffixIcon: IconButton(icon: Icon(Icons.arrow_forward),onPressed: (){
            showqr();
          },),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: MyColors.blueGreyColor)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: MyColors.primaryColor)
          ),
          hintText: AppLocalizations.of(context)!.translate("entertext"),
          hintStyle: TextStyle(fontSize: 14),
          labelText: AppLocalizations.of(context)!.translate("qrorbarcode"),
          labelStyle: TextStyle(fontSize: 11)
        ),
        onFieldSubmitted: (text){
          showqr();
        },
      ),
    );
  }

  showqr(){
    showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.translate("select")!),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text("QR"),
                  onPressed: (){
                    Navigator.pop(context);
                    showQROrBarcode("qr");},
                ),
                FlatButton(
                  child: Text("Barcode"),
                  onPressed: (){
                    Navigator.pop(context);
                    showQROrBarcode("barcode");},
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  showQROrBarcode(String prevType){
    type=prevType;
    setState(() {
      
    });
  }

  Widget qrSection(){
    return Container(
      margin: EdgeInsets.only(top:20),
      child: qrText.text!=null&&qrText.text!=""&&type!=null&&type=="qr"?GestureDetector(
        child: Center(
          child: Card(
            color: MyColors.whiteColor,
            child: Container(
              padding: EdgeInsets.all(6),
              child:QrImage(
                foregroundColor: MyColors.primaryColor,
                data: qrText.text,
                version: QrVersions.auto,
                gapless: true,
                size: 250.0,
              ),
            ),
          ),
        ),
      ):Container()
    );
  }

  Widget barcodeSection(){
    return Container(
      margin: EdgeInsets.only(top:20),
      child: qrText.text!=null&&qrText.text!=""&&type!=null&&type=="barcode"?GestureDetector(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            // child:BarCodeImage(
            //   padding: EdgeInsets.symmetric(horizontal: 5),
            //   foregroundColor: MyColors.primaryColor,
            //   backgroundColor: MyColors.whiteColor,
            //   params: Code39BarCodeParams(
            //     qrText.text,
            //     withText: true,
            //     lineWidth: 2,
            //     barHeight: 130.0,
            //     altText: qrText.text
            //   ),
            //   onError: (error) {               // Error handler
            //     print('error = $error');
            //   },
            // ),
          ),
        ),
      ):Container()
    );
  }

}