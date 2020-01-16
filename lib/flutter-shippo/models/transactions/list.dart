import 'transaction.dart';

class TransactionList {
  String _next;
  String _previous;
  List<Transactions> _results;

  ShipmentList({String next, String previous, List<Transactions> results}) {
    this._next = next;
    this._previous = previous;
    this._results = results;
  }

  TransactionList.fromMap(Map<String, dynamic> obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._results = obj['results'].map((e) => Transactions.map(e)).toList();
  }

  TransactionList.map(dynamic obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._results = obj['results'].map((e) => Transactions.map(e)).toList();
  }

  String get next => this._next ?? '';

  String get previous => this._previous ?? '';

  List<Transactions> get shipments => this._results;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['next'] = this._next;
    map['previous'] = this._previous;
    map['results'] = this._results.map((f) => f.toMap());

    return map;
  }
}
