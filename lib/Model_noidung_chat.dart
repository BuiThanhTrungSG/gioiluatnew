class Model_noidung_chat{

  bool _nguoichat;
  String _noidung;

  Model_noidung_chat(this._nguoichat, this._noidung);

  String get noidung => _noidung;

  set noidung(String value) {
    _noidung = value;
  }

  bool get nguoichat => _nguoichat;

  set nguoichat(bool value) {
    _nguoichat = value;
  }
}