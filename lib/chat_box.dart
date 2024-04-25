import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gioiluat/Model_noidung_chat.dart';

import 'Todo.dart';

class chat_box extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return chat_box_state();
  }
}

class chat_box_state extends State<chat_box>{

  TextEditingController Text_controller = TextEditingController();
  static const double doCong = 10;
  static const double doCongChat = 15;
  List<Model_noidung_chat> danhsach = [];
  late Todo arg;
  @override
  Widget build(BuildContext context) {

    arg = ModalRoute.of(context)!.settings.arguments as Todo;
    double chieuRongMH = MediaQuery.of(context).size.width * 4 / 5;
    if (danhsach.isEmpty){
      danhsach.add(Model_noidung_chat(false, arg.thongtin));
    }

    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  color: Colors.green,
                  child: Row(
                    children: [
                      Image.asset('assets/images/sau_icon.png', height: 40, width: 40,),
                      SizedBox(width: 5),
                      Text("Sâu giỏi luật", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        itemCount: danhsach.length,
                        reverse: true,
                        itemBuilder: (context, position){
                          if (danhsach[position].nguoichat){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 5,),
                                Image.asset('assets/images/sau_icon.png', height: 30, width: 30,),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: chieuRongMH),
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(doCongChat),
                                              topRight: Radius.circular(doCongChat),
                                              bottomRight: Radius.circular(doCongChat)
                                          ),
                                          border: Border.all(color: Color(
                                              0x6660c560)),
                                          color: Color(0xa3ebffeb)
                                      ),
                                      child: Text(danhsach[position].noidung)),
                                )
                              ],
                            );
                          }else{
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: chieuRongMH),
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(doCongChat),
                                            topRight: Radius.circular(doCongChat),
                                            bottomLeft: Radius.circular(doCongChat)
                                        ),
                                          border: Border.all(color: Color(0x1a807f7f)),
                                          color: Color(0x1ac0c0c0)
                                      ),
                                      child: Text(danhsach[position].noidung)),
                                )
                              ],
                            );
                          }
                        }),
                  ),
                ),
                Container(
                  color: Colors.black12,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Flexible(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: chieuRongMH),
                          child: TextField(
                            enabled: true,
                            controller: Text_controller,
                            textCapitalization: TextCapitalization.sentences,
                            // textAlign: TextAlign.center,
                            maxLines: null,
                            obscureText: false,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(doCong)),
                                borderSide: BorderSide(width: 1,color: Colors.green),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(doCong)),
                                borderSide: BorderSide(width: 1,color: Colors.orange),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(doCong)),
                                borderSide: BorderSide(width: 1,color: Colors.black26),
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
                              hintText: "Đặt câu hỏi của bạn ở đây ...",
                              hintStyle: TextStyle(fontSize: 14,color: Color(0xFFB3B1B1)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        width: 65,
                        height: 55,
                        child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                            onPressed: (){
                              if (Text_controller.text.isNotEmpty){
                                setState(() {
                                  danhsach.insert(0, Model_noidung_chat(false, Text_controller.text));
                                  Text_controller.text = '';
                                });
                              }
                            },
                            child: Text('GỬI')),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}