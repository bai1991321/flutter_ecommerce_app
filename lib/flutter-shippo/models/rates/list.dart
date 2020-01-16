import 'rate.dart';

class RateList {
  String _next;
  String _previous;
  List<Rate> _result;

  RateList(this._next, this._previous, this._result);

  RateList.map(dynamic obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._result = obj['results'].map((e) => Rate.map(e)).toList();
  }

  RateList.fromMap(Map<String, dynamic> obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._result = obj['results'].map((e) => Rate.map(e)).toList();
  }

  String get next => this._next ?? '';

  String get previous => this._previous ?? '';

  List<Rate> get rates => this._result;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['next'] = this._next;
    map['previous'] = this._previous;
    map['results'] = this._result.map((f) => f.toMap());

    return map;
  }
}
