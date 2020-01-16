import 'manifest.dart';

class ManifestList {
  String _next;
  String _previous;
  List<Manifest> _result;

  ManifestList(this._next, this._previous, this._result);

  ManifestList.map(dynamic obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._result = obj['results'].map((e) => Manifest.map(e)).toList();
  }

  ManifestList.fromMap(Map<String, dynamic> obj) {
    this._next = obj['next'];
    this._previous = obj['previous'];
    this._result = obj['results'].map((e) => Manifest.map(e)).toList();
  }

  String get next => this._next ?? '';

  String get previous => this._previous ?? '';

  List<Manifest> get parcels => this._result;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['next'] = this._next;
    map['previous'] = this._previous;
    map['results'] = this._result.map((f) => f.toMap());

    return map;
  }
}
