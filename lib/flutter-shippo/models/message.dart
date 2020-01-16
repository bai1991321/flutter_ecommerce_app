class Message {
  String _code;
  String _message;

  Message({String code, String message}) {
    this._code = code;
    this._message = message;
  }

  Message.fromMap(Map<String, dynamic> obj) {
    this._code = obj['code'];
    this._message = obj['text'];
  }

  Message.map(dynamic obj) {
    this._code = obj['code'];
    this._message = obj['text'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['code'] = this._code;
    map['text'] = this._message;

    return map;
  }

  String get code => this._code;

  String get message => this._message;
}
