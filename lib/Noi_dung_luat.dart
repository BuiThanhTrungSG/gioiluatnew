import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Noi_dung_luat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Noi_dung_luat_State();
  }

}
class Noi_dung_luat_State extends State<Noi_dung_luat>{

  List<String> noidung = [];
  List<String> DanhSachDoiChieu = ['điều','tiểu','mục','chương','phần'];

  Future loadData() async {
    var dataJson = await rootBundle.loadString('assets/data/5000.json');
    List laws = json.decode(dataJson);
    var law = laws[17];
    LineSplitter ls = LineSplitter();
    noidung = ls.convert(law['text']);
    setState(() {
    });
  }

  Widget noidungchu(String noidungluat){
    String tach = noidungluat.split(' ')[0].toLowerCase();
    late TextStyle kieuchu;

    for (final element in DanhSachDoiChieu){

      if (tach.toLowerCase() == element){
        kieuchu = TextStyle(fontWeight: FontWeight.bold);
        break;
      }else{
        kieuchu = TextStyle();
      }
    }

    return Text(noidungluat, style: kieuchu);
  }

  @override
  Widget build(BuildContext context) {

    if (noidung.isEmpty){
      loadData();
    }


    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
              itemCount: noidung.length,
              itemBuilder: (context, indext){
                return noidungchu(noidung[indext]);

          })
        ),
      ),
    );
  }

}