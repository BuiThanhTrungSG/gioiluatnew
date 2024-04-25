import 'dart:convert';

import 'package:flutter/services.dart';

class Xu_ly_json {

  late String _file;


  Xu_ly_json(this._file);

  Future<List> loadData() async {
    List _menu = [];
    var data = await rootBundle.loadString(_file);
    List catalogdata = json.decode(data);
    catalogdata.forEach((element) {
      var ten = element['trichyeu'];
      _menu.add(ten);
    });
    setState(){

    }
    return _menu;
  }
}