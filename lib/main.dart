import 'package:flutter/material.dart';
import 'package:gioiluat/Muc_luc_luat.dart';
import 'package:gioiluat/Noi_dung_luat.dart';
import 'package:gioiluat/Todo.dart';
import 'package:gioiluat/Danh_sach_luat.dart';
import 'package:gioiluat/chat_box.dart';
import 'package:provider/provider.dart';

import 'Model_chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Model_chat>(create: (context) => Model_chat()),
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/chat_box": (context) => chat_box(),
          "/Danh_sach_luat": (context) => Danh_sach_luat(),
          "/Muc_luc_luat": (context) => Muc_luc_luat(),
          "/Noi_dung_luat": (context) => Noi_dung_luat(),
        },
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController Text_controller = TextEditingController();
  bool Visible_button = false;
  static const double doCong = 20;
  List<Todo> todos = [Todo("thong tin dau")];

  @override
  Widget build(BuildContext context) {

    Text_controller.addListener(() {
      if (this.Text_controller.text == '') {
        Visible_button = false;
      }else{
        Visible_button = true;
      }
      setState(() {

      });
    });
    double chieuRongMH = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0x6eebffeb),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/anhnen.jpg"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Center(
            child: Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/anh_sau.png',width: 100, height: 100,),
                    const Text(
                      "Hi! Tôi là chú sâu GIỎI LUẬT",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Tôi đã học hết các sách luật và tôi ở đây để tư vấn cho bạn",
                      style: TextStyle(color: Colors.green,fontSize: 10), textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30,),
                    Flexible(
                      child: SizedBox(width: chieuRongMH*4/5,
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
                            hintText: "Đặt câu hỏi của bạn ở đây ...",
                            hintStyle: TextStyle(fontSize: 14,color: Color(0xFFB3B1B1)),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: Visible_button,
                        child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                            onPressed: (){
                              Navigator.pushNamed(context, "/chat_box", arguments: Todo(Text_controller.text));
                              Text_controller.text = '';
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context) => chat_box()
                              // ));

                            },
                            child: Text('GỬI', style: TextStyle(fontWeight: FontWeight.bold),))
                    ),
                    ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                        onPressed: (){
                          Navigator.pushNamed(context, "/Danh_sach_luat", arguments: Todo(Text_controller.text));
                          Text_controller.text = '';
                        },
                        child: Text('Danh sach luat', style: TextStyle(fontWeight: FontWeight.bold),)
                    ),
                    ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                        onPressed: (){
                          Navigator.pushNamed(context, "/Muc_luc_luat", arguments: Todo(Text_controller.text));
                          Text_controller.text = '';
                        },
                        child: Text('Muc luc luat', style: TextStyle(fontWeight: FontWeight.bold),)
                    ),
                    ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                        onPressed: (){
                          Navigator.pushNamed(context, "/Noi_dung_luat", arguments: Todo(Text_controller.text));
                          Text_controller.text = '';
                        },
                        child: Text('Noi_dung_luat', style: TextStyle(fontWeight: FontWeight.bold),)
                    )
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );

  }
}
