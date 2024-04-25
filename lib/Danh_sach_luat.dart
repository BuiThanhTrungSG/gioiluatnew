import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Danh_sach_luat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Danh_sach_luat_state();
  }  
}

class Danh_sach_luat_state extends State<Danh_sach_luat>{

  TextEditingController Text_controller = TextEditingController();
  static const double doCong = 10;
  List group = [];

  Future loadData() async {
    var data = await rootBundle.loadString('assets/data/5000.json');
    List catalogdata = json.decode(data);
    catalogdata.forEach((element) {
      var ten = element['trichyeu'];
      group.add(ten);
    });
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    if (group.isEmpty){
      loadData();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              color: Color(0xa3ebffeb),
              child: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        enabled: true,
                        controller: Text_controller,
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: TextAlign.center,
                        maxLines: null,
                        obscureText: false,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xa3ebffeb),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(doCong)),
                            borderSide: BorderSide(width: 1,color: Colors.yellow),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(doCong)),
                            borderSide: BorderSide(width: 1,color: Colors.orange),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(doCong)),
                            borderSide: BorderSide(width: 1,color: Colors.green),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(doCong)),
                              borderSide: BorderSide(width: 1,)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(doCong)),
                              borderSide: BorderSide(width: 1,color: Colors.black)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(doCong)),
                              borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                          ),
                          hintText: "Tìm kiếm văn bản ...",
                          hintStyle: TextStyle(fontSize: 14,color: Color(0xFFB3B1B1)),
                          contentPadding: EdgeInsets.all(1.0),

                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: const Icon(Icons.search),
                    color: Colors.green,
                    onPressed: () {

                    },
                  ),
                ],
              ),

            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(1),
                  color: Color(0x6eebffeb),
                  child: ListView.builder(
                    itemCount: group.length,
                    itemBuilder: (context, position) {
                      return Container(
                          decoration: BoxDecoration(
                            color: Color(0xa3ebffeb),
                            border: Border(
                                left: BorderSide(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                              bottom: BorderSide(
                                  color: Colors.green,
                                  width: 1.0,
                                ),
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)
                            ),
                          ),
                          margin: EdgeInsets.all(3),
                          padding: EdgeInsets.only(left: 5, right: 3, top: 3, bottom: 3),
                          child: Text(group[position])
                      );
                    },
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
  
}