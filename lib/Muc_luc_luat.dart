import 'dart:convert';
import 'dart:math';
// import 'dart:html';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'Model/Menu.dart';
import 'Todo.dart';

class Muc_luc_luat extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return Muc_luc_luat_state();
  }
}

class Muc_luc_luat_state extends State<Muc_luc_luat>{

  List<String> DanhSachDoiChieu = ['điều','tiểu','mục','chương','phần'];
  String TenVanBan = '';
  bool An_hien_thongtin = false;
  bool Dong_mo_menu = false;
  List<Menu> data = [];
  List<String> MucLucLuat = [];
  final _key = GlobalKey<ExpandableFabState>();
  final TextStyle Kieuchu = const TextStyle(fontSize: 17, color: Color(0xFF365B6D), fontWeight: FontWeight.bold);
  final Color mauchu = Color(0xFF365B6D);
  final Color mauchu2 = Color(0xFFF2F1EC);

  static const double doCong = 20;
  TextEditingController Text_controller = TextEditingController();
  final FloatingActionButtonBuilder nutmorong = RotateFloatingActionButtonBuilder(
    child: Image.asset('assets/images/sau_icon.png'),
    fabSize: ExpandableFabSize.regular,
    backgroundColor: Colors.yellowAccent,
    shape: const CircleBorder(),
  );
  final ButtonStyle maunutmorong = TextButton.styleFrom(backgroundColor: Colors.yellow);

  @override
  Widget build(BuildContext context) {

    if (data.isEmpty){
      loadData();
    }

    double chieuRongMH = MediaQuery.of(context).size.width;
    double chieuCaoMH = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        openButtonBuilder: nutmorong,
        closeButtonBuilder: nutmorong,
        overlayStyle: ExpandableFabOverlayStyle(blur: 3),
        distance: 60,
        type: ExpandableFabType.up,
        children: [
          TextButton(
            style: maunutmorong,
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
            child: Text('VĂN BẢN GỐC', style: Kieuchu,),
          ),
          TextButton(
            style: maunutmorong,
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
              setState(() {
                An_hien_thongtin = !An_hien_thongtin;
              });
            },
            child: Text('THUỘC TÍNH VĂN BẢN', style: Kieuchu,),
          ),
          TextButton(
            style: maunutmorong,
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
            child: Text('VĂN BẢN HƯỚNG DẪN', style: Kieuchu,),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: mauchu2,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    child: Image.asset('assets/images/icon_quochuy.png',width: 70, height: 70,),
                    margin: EdgeInsets.all(5),
                  ),
                  Text(TenVanBan.toUpperCase(), style: const TextStyle(fontSize: 17, color: Color(0xFF365B6D), fontWeight: FontWeight.bold, fontFamily: "aachenb"), textAlign: TextAlign.center,),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: Flexible(
                      child: TextField(
                        enabled: true,
                        controller: Text_controller,
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: TextAlign.center,
                        maxLines: null,
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff1f1f1),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(doCong)),
                            borderSide: BorderSide(width: 1,color: Color(0xff289dd2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(doCong)),
                            borderSide: BorderSide(width: 1,color: mauchu),
                          ),
                          hintText: "Tìm kiếm điều luật",
                          hintStyle: TextStyle(fontSize: 14,color: Color(0xFFB3B1B1)),
                          contentPadding: EdgeInsets.all(2),
                          suffixIcon:Text_controller.text != '' ?
                          IconButton(
                            onPressed: (){
                              setState(() {
                                Text_controller.clear();
                                data.clear();
                                data.addAll(LayMucLucMenu(MucLucLuat));
                              });
                            },
                            icon: Icon(Icons.clear, color: mauchu,),
                          ) : IconButton(
                            onPressed: (){
                              setState(() {
                                Dong_mo_menu = true;
                              });

                            },
                            icon: Icon(Icons.search, color: mauchu,),
                          ),
                        ),
                        onChanged: (text){
                          setState(() {
                            // controller.expand();
                            data.clear();
                            if (Text_controller.text != ''){
                              List<String> danhsachtam = [];
                              MucLucLuat.forEach((dongmenu) {
                                if (dongmenu.toLowerCase().contains('điều')){
                                  if (dongmenu.toLowerCase().contains(Text_controller.text.toLowerCase())){
                                    danhsachtam.add(dongmenu);
                                  }
                                }else{
                                  danhsachtam.add(dongmenu);
                                }
                              });
                              data.addAll(LayMucLucMenu(danhsachtam));

                            }else{
                              data.addAll(LayMucLucMenu(MucLucLuat));
                            }
                          });
                        },
                      ),
                    ),
                  ),
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
                  ),
                ],
              ),
              Visibility(
                  visible: An_hien_thongtin,
                  child: Stack(
                    children: [
                      Expanded(child: GestureDetector(
                        child: Container(
                          child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: Container(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                          )
                        ),
                        onTap: (){
                            setState(() {
                              An_hien_thongtin = !An_hien_thongtin;
                            });
                        },
                      )),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.amberAccent,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)
                            ),
                          ),
                          width: chieuRongMH/4*3,
                          height: chieuCaoMH/2,
                          child: Column(
                            children: [
                              Container(
                                width: chieuRongMH/4*3,
                                color: Colors.amberAccent,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Text('THUỘC TÍNH VĂN BẢN',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mauchu),),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Cơ quan ban hành: ', style: TextStyle(fontWeight: FontWeight.bold, color: mauchu)),
                                  Flexible(child: Text('Cộng hòa xã hội chủ nghia việt nam sdf lkwj;f lá ;lừ a;slfj lưefjslj flwejfwelfjsljf l'))
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Ngày ban hành: ', style: TextStyle(fontWeight: FontWeight.bold, color: mauchu)),
                                  Text('21/5/2022')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Ngày có hiệu lực: ', style: TextStyle(fontWeight: FontWeight.bold, color: mauchu)),
                                  Text('21/5/2022')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Công báo: ', style: TextStyle(fontWeight: FontWeight.bold, color: mauchu)),
                                  Text('21/5/2022')
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ],

          )

        ),
      ),
    );
  }

  List<String> LayMucLuc (String vanban) {

    List<String> Danhsach = [];
    LineSplitter ls = LineSplitter();
    List<String> ListText = ls.convert(vanban);
    ListText.forEach((dongchu) {
      List tam = dongchu.split(' ');
      String word = tam[0];
      DanhSachDoiChieu.forEach((element) {
        if (element == word.toLowerCase()) {
          Danhsach.add(dongchu);
        }
      });
    });
    return Danhsach;
  }

  List<Menu> LayMucLucMenu (List<String> mucluc){
    List<Menu> DanhSachDieuKhoan = [];
    for (int i = 0; i < mucluc.length; i++){

      bool check = true;
      List tam = mucluc[i].split(' ');
      String word = tam[0];

      DanhSachDoiChieu.forEach((element) {
        if (element == word.toLowerCase()){
          Menu them = Menu(mucluc[i], []);
          DanhSachDieuKhoan.add(them);
          check = false;
        }
      });

      if (check && DanhSachDieuKhoan.isNotEmpty){
        Menu chuongtam = DanhSachDieuKhoan.last;
        String wordtam = chuongtam.name.split(' ')[0].toLowerCase();
        if (wordtam != 'điều'){
          DanhSachDieuKhoan[DanhSachDieuKhoan.length - 1] = Menu(chuongtam.name + ' ' + mucluc[i], chuongtam.subMenu);
        }
      }
    }
    List<Menu> sapxep = [];
    sapxep.addAll(xepThuTuMucLuc(DanhSachDieuKhoan).reversed);
    return sapxep;
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

    return DanhSachMenu;
  }

  Future loadData() async {
    var dataJson = await rootBundle.loadString('assets/data/5000.json');
    List laws = json.decode(dataJson);
    var law = laws[17];
    TenVanBan = law['trichyeu'];
    if (MucLucLuat.isEmpty){
      MucLucLuat.addAll(LayMucLuc(law['text']));
    }

    data.addAll(LayMucLucMenu(MucLucLuat));
    setState(() {
    });
  }

  Widget _buildlist(Menu list) {
    // tileControllers = List.generate(list., (_) => ExpansionTileController());
    if(list.subMenu.isEmpty && list.name.toLowerCase().contains('điều')){
      return Builder(builder: (context){
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.all(0.1),
                decoration: BoxDecoration(
                  color: mauchu2,
                  border: Border(
                    bottom: BorderSide(
                      color: mauchu2,
                      width: 1,
                    ),

                  ),
                ),
                child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/Noi_dung_luat", arguments: Todo(list.name));
                    },
                    child: _taoHightlightDieu(Text_controller.text, list.name)
                ),
                // child: Text(list.name, style: TextStyle(color: mauchu),),
              ),
            ),
          ],
        );

      });
    }
    return Container(
      decoration: BoxDecoration(
        color: mauchu,
        borderRadius: BorderRadius.all(
            Radius.circular(5.0)
        ),
      ),
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(0.2),
      child: ExpansionTile(
          initiallyExpanded: Dong_mo_menu,
          iconColor: Color(0xFF6C9286),
          collapsedIconColor: mauchu2,
          childrenPadding: EdgeInsets.all(0.1),
          title: Text(list.name, style: TextStyle(color: Colors.white)),
          children: list.subMenu.map(_buildlist).toList()
      ),
    );
  }

  Widget _taoHightlightDieu(String TuTimKiem, String Vanban){
    final search = TuTimKiem.toLowerCase();
    final text = Vanban;
    final matches = search.allMatches(text.toLowerCase()).toList();
    final spans = <TextSpan>[];

    if (matches.isEmpty) {
      spans.add(TextSpan(text: text));
    } else {
      for (var i = 0; i < matches.length; i++) {
        final strStart = i == 0 ? 0 : matches[i - 1].end;
        final match = matches[i];
        spans.add(
          TextSpan(
            text: text.substring(
              strStart,
              match.start,
            ),
          ),
        );
        spans.add(
          TextSpan(
            text: text.substring(
              match.start,
              match.end,
            ),
            style: const TextStyle(backgroundColor: Colors.yellow),
          ),
        );
      }
      spans.add(TextSpan(text: text.substring(matches.last.end)));
    }
    return RichText(text: TextSpan(
      style: TextStyle(color: mauchu),
      children: spans,
    ));

  }

}


