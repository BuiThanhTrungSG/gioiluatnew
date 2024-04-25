import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Model/Menu.dart';

class Muc_luc_luat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Muc_luc_luat_state();
  }
}

class Muc_luc_luat_state extends State<Muc_luc_luat>{

  List<String> DanhSachDoiChieu = ['điều','tiểu','mục','chương','phần'];
  String TenVanBan = '';

  List<Menu> data = [];

  Future loadData() async {

    List<Menu> DanhSachDieuKhoan = [];

    var dataJson = await rootBundle.loadString('assets/data/5000.json');
    List laws = json.decode(dataJson);
    var law = laws[17];
    TenVanBan = law['trichyeu'];
    LineSplitter ls = LineSplitter();
    List<String> ListText = ls.convert(law['text']);


    for (int i = 0; i < ListText.length; i++){

      bool check = true;
      List tam = ListText[i].split(' ');
      String word = tam[0];

      DanhSachDoiChieu.forEach((element) {
        if (element == word.toLowerCase()){
          Menu them = Menu(ListText[i], []);
          DanhSachDieuKhoan.add(them);
          check = false;
        }
      });

      if (check && DanhSachDieuKhoan.isNotEmpty){
        Menu chuongtam = DanhSachDieuKhoan.last;
        print("ok");
        String wordtam = chuongtam.name.split(' ')[0].toLowerCase();
        if (wordtam != 'điều'){
          DanhSachDieuKhoan[DanhSachDieuKhoan.length - 1] = Menu(chuongtam.name + ' ' + ListText[i], chuongtam.subMenu);
        }
      }
    }

    data.addAll(xepThuTuMucLuc(DanhSachDieuKhoan).reversed);

    setState(() {
    });
  }

  List<Menu> xepThuTuMucLuc(List<Menu> Danhsach){

    List<Menu> DanhSachMenu = Danhsach.reversed.toList();


    DanhSachDoiChieu.forEach((element1) {

      List<Menu> lanLuot = [];
      List<Menu> tam = [];

      DanhSachMenu.forEach((element2) {
        String word = element2.name.split(' ')[0].toLowerCase();
        if (word == element1){
          tam.insert(0, element2);
        }else{
          element2.subMenu.addAll(tam);
          lanLuot.add(element2);
          tam.clear();
        }
      });
      if (lanLuot.isNotEmpty){
        DanhSachMenu.clear();
        DanhSachMenu.addAll(lanLuot);
      }


    });
    print(DanhSachMenu);
    return DanhSachMenu;
  }

  var Kieuchu = TextStyle(fontSize: 17, color: Color(0xFF007C00), fontWeight: FontWeight.bold, fontFamily: "aachenb");
  var Kieuchu2 = TextStyle(color: Color(0xFF004900));

  @override
  Widget build(BuildContext context) {

    if (data.isEmpty){
      loadData();
    }


    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(TenVanBan.toUpperCase(), style: Kieuchu, textAlign: TextAlign.center,),
              SizedBox(height: 10),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(1),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, position) {
                        return _buildlist(data[position]);
                      },
                    ),

                  )
              )
            ],

          ),
        ),
      ),
    );
  }
  Widget _buildlist(Menu list) {
    if(list.subMenu.isEmpty){
      return Builder(builder: (context){
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Color(0xa3ebffeb),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.green,
                      width: 0.5,
                    ),
                    // bottom: BorderSide(
                    //   color: Colors.green,
                    //   width: 1.0,
                    // ),
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0)
                  ),
                ),
                child: Text(list.name, style: Kieuchu2),
              ),
            ),
          ],
        );

      });
    }
    return Container(
      decoration: BoxDecoration(
        color: Color(0xa3ebffeb),
        border: Border(
          left: BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
          // bottom: BorderSide(
          //   color: Colors.green,
          //   width: 1.0,
          // ),
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0)
        ),
      ),
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.only(left: 2, right: 1, top: 1, bottom: 1),
      child: ExpansionTile(
          shape: Border(),
          // trailing: SizedBox(),
          title: Text(list.name, style: Kieuchu2),
          children: list.subMenu.map(_buildlist).toList()
      ),
    );
  }
}


