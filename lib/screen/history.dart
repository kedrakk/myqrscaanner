import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myqrscanner/main.dart';
import 'package:myqrscanner/utils/designUtils/myColors.dart';
import 'package:myqrscanner/utils/providers/appLocalizations.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<QrHistory> qrHistoryList=[];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData()async{
    var todoBox= await Hive.openBox('qrHistory');
    if(todoBox.values.isNotEmpty){
      todoBox.values.map((item){
        return qrHistoryList.add(item);
      }).toList();
    }
    todoBox.close();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:qrHistoryList!=null&&qrHistoryList.length>0?
        Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
              Text(AppLocalizations.of(context).translate("historylist")),
              Text(qrHistoryList.length.toString()+" "+AppLocalizations.of(context).translate("record"))
            ],),
          ),
          _imageSection(),
        ],
      ):Text(AppLocalizations.of(context).translate("nohistory"))),      
    );
  }

  Widget _imageSection(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context,index){
            return Card(
              color: MyColors.whiteColor,
              child: ListTile(
                leading: CircleAvatar(radius: 15,child: Text(qrHistoryList[index].id.toString()),),
                title: Text(qrHistoryList[index].name,style: TextStyle(color: MyColors.blackColor),overflow: TextOverflow.ellipsis,maxLines: 2,),
              ),
            );
          },
          itemCount: qrHistoryList.length,
        ),
      ),
    );
  }
}