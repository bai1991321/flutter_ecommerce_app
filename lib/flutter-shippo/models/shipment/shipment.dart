import '../../models/addresses/address.dart';
import '../../models/parcels/parcel.dart';
import '../carrierAccounts/carrierAccount.dart';
import '../message.dart';
import '../rates/rate.dart';
import 'extra.dart';

class Shipment {
  String _status;
  String _object_created;
  String _object_updated;
  String _object_id;
  String _object_owner;
  Address _address_from;
  Address _address_to;
  List<Parcel> _parcels;
  String _shipment_date;
  Address _address_return;
  String _customs_declaration;
  List<CarrierAccount> _carrier_accounts;
  String _metadada;
  ShipmentExtra _extra;
  List<Rate> _rates;
  List<Message> _messages;
  bool _test;

  Shipment({
    String status,
    String object_created,
    String object_updated,
    String object_id,
    String object_owner,
    Address address_from,
    Address address_to,
    List<Parcel> parcels,
    String shipment_date,
    Address address_return,
    String customs_declaration,
    List<CarrierAccount> carrier_accounts,
    String metadada,
    ShipmentExtra extra,
    List<Rate> rates,
    List<Message> messages,
    bool test,
  }) {
    this._status = status;
    this._object_created = object_created;
    this._object_updated = object_updated;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._address_from = address_from;
    this._address_to = address_to;
    this._address_return = address_return;
    this._parcels = parcels;
    this._shipment_date = shipment_date;
    this._customs_declaration = customs_declaration;
    this._carrier_accounts = carrier_accounts;
    this._metadada = metadada;
    this._extra = extra;
    this._rates = rates;
    this._messages = messages;
    this._test = test;
  }

  Shipment.fromMap(Map<String, dynamic> obj) {
    this._status = obj['status'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._address_from = Address.map(obj['address_from']);
    this._address_to = Address.map(obj['address_to']);
    this._parcels = (obj['parcels'] as List).map((e) => Parcel.map(e)).toList();
    this._shipment_date = obj['shipment_date'];
    this._address_return = Address.map(obj['address_return']);
    this._carrier_accounts = (obj['carrier_accounts'] as List)
        .map((f) => CarrierAccount.map(f))
        .toList();
    this._customs_declaration = obj['custom_declaration'];
    this._metadada = obj['metadata'];
    this._rates = (obj['rates'] as List).map((f) => Rate.map(f)).toList();
    this._extra = ShipmentExtra.map(obj['extra']);
    this._messages =
        (obj['messages'] as List).map((e) => Message.map(e)).toList();
    this._test = obj['test'];
  }

  Shipment.map(dynamic obj) {
    this._status = obj['status'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._address_from = Address.map(obj['address_from']);
    this._address_to = Address.map(obj['address_to']);
    this._parcels = (obj['parcels'] as List).map((e) => Parcel.map(e)).toList();
    this._shipment_date = obj['shipment_date'];
    this._address_return = obj['address_return'];
    this._carrier_accounts = (obj['carrier_accounts'] as List)
        .map((f) => CarrierAccount.map(f))
        .toList();
    this._customs_declaration = obj['custom_declaration'];
    this._metadada = obj['metadata'];
    this._rates = (obj['rates'] as List).map((f) => Rate.map(f)).toList();
    this._extra = ShipmentExtra.map(obj['extra']);
    this._messages = obj['messages'].map((e) => Message.map(e)).toList();
    this._test = obj['test'];
  }

  String get status => this._status ?? '';

  String get object_created => this._object_created ?? '';

  String get object_updated => this._object_updated ?? '';

  String get object_id => this._object_id ?? '';

  String get object_owner => this._object_owner ?? '';

  Address get address_from => this._address_from;

  Address get address_to => this._address_to;

  Address get address_return => this._address_return;

  List<CarrierAccount> get carrier_accounts => this._carrier_accounts;

  List<Parcel> get parcels => this._parcels;

  String get shipment_date => this._shipment_date;

  String get customs_declaration => this._customs_declaration;

  String get metadata => this._metadada;

  List<Rate> get rates => this._rates;

  ShipmentExtra get extra => this._extra;

  List<Message> get messages => this._messages;

  bool get test => this.test;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._status != null) map['status'] = this._status;
    if (this._object_created != null)
      map['object_created'] = this._object_created;
    if (this._object_updated != null)
      map['object_updated'] = this._object_updated;
    if (this._object_id != null) map['object_id'] = this._object_id;
    if (this._object_owner != null) map['object_owner'] = this._object_owner;
    if (this._address_from != null)
      map['address_from'] = this._address_from.toMap();
    if (this._address_to != null) map['address_to'] = this._address_to.toMap();
    if (this._parcels != null)
      map['parcels'] = this._parcels.map((f) => f.toMap()).toList();
    if (this._shipment_date != null) map['shipment_date'] = this._shipment_date;
    if (this._address_return != null)
      map['address_return'] = this._address_return.toMap();
    if (this._carrier_accounts != null)
      map['carrier_accounts'] =
          this._carrier_accounts.map((f) => f.toMap()).toList();
    if (this._customs_declaration != null)
      map['customs_declaration'] = this._customs_declaration;
    if (this._metadada != null) map['metadata'] = this._metadada;
    if (this._extra != null) map['extra'] = this._extra.toMap();
    if (this._rates != null)
      map['rates'] = this._rates.map((f) => f.toMap()).toList();
    if (this._messages != null)
      map['messages'] = this._messages.map((f) => f.toMap()).toList();
    if (this._test != null) map['test'] = this._test;
    return map;
  }
}
