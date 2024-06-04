import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gioiluat/Todo.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Noi_dung_luat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Noi_dung_luat_State();
  }

}
class Noi_dung_luat_State extends State<Noi_dung_luat>{

  List<String> noidung = [];
  List<String> DanhSachDoiChieu = ['điều','tiểu','mục','chương','phần'];
  ItemScrollController itemScrollController = ItemScrollController();

  Future loadData(String DieuLuatDen) async {
    var dataJson = await rootBundle.loadString('assets/data/5000.json');
    List laws = json.decode(dataJson);
    var law = laws[17];
    LineSplitter ls = LineSplitter();
    noidung = ls.convert(law['text']);
    setState(() {
      cuonDenDieu(DieuLuatDen);
    });
  }

  Widget noidungchu(String noidungluat, String DieuLuatDen){

    late TextStyle kieuchu;

    if (noidungluat.contains(DieuLuatDen)){
      kieuchu = TextStyle(backgroundColor: Colors.yellowAccent);
    }else{
      kieuchu = TextStyle();
    }

    return SelectableText(noidungluat, style: kieuchu);
  }

  Future<void> cuonDenDieu(String DieuLuatDen) async {

    int ViTri = -1;

    for(final element in noidung){
      ViTri = ViTri + 1;
      if (element.contains(DieuLuatDen)){
        break;
      }
    }

    await Future.delayed(Duration(milliseconds: 200));
    itemScrollController.scrollTo(index: ViTri, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Todo;
    final dieuluatden = args.thongtin;

    if (noidung.isEmpty){
      loadData(dieuluatden);
    }

    return SelectionArea(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(5),
            child: ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                itemCount: noidung.length,
                itemBuilder: (context, indext){
                  return GestureDetector(
                      onTap: (){
                      },
                      child: noidungchu(noidung[indext], dieuluatden));
            
            })
          ),
        ),
      ),
    );
  }

}