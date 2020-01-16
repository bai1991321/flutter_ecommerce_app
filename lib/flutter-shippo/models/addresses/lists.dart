import 'address.dart';

class AdressesList {
  String _next;
  String _previous;
  List<Address> _result;

  AdressesList(this._next, this._previous, this._result);

  AdressesList.map(dynamic obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._result = obj['results'].map((e) => Address.map(e)).toList();
  }

  AdressesList.fromMap(Map<String, dynamic> obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._result = obj['results'].map((e) => Address.map(e)).toList();
  }

  String get next => this._next ?? '';

  String get previous => this._previous ?? '';

  List<Address> get addresses => this._result;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['next'] = this._next;
    map['previous'] = this._previous;
    map['results'] = this._result.map((f) => f.toMap());
    return map;
  }
}
