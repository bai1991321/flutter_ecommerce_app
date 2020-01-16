import 'carrierAccount.dart';

class CarrierAccountList {
  String _next;
  String _previous;
  List<CarrierAccount> _result;

  CarrierAccountList(this._next, this._previous, this._result);

  CarrierAccountList.map(dynamic obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._result = obj['results'].map((e) => CarrierAccount.map(e)).toList();
  }

  CarrierAccountList.fromMap(Map<String, dynamic> obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._result = obj['results'].map((e) => CarrierAccount.map(e)).toList();
  }

  String get next => this._next ?? '';

  String get previous => this._previous ?? '';

  List<CarrierAccount> get parcels => this._result;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['next'] = this._next;
    map['previous'] = this._previous;
    map['results'] = this._result.map((f) => f.toMap());

    return map;
  }
}
