class CustomDeclaration {
  String _object_state;
  String _object_created;
  String _object_updated;
  String _object_id;
  String _object_owner;
  String _certify_signer;
  String _certify;
  List<String> _items;
  String _non_delivery_option;
  String _contents_type;
  String _contents_explanation;
  String _exporter_reference;
  String _importer_reference;
  String _invoice;
  String _license;
  String _certificate;
  String _notes;
  String _eel_pfc;
  String _aes_itn;
  String _incoterm;
  String _disclaimer;
  String _metadata;
  String _test;

  String get object_state => this._object_state;

  String get object_created => this._object_created;

  String get object_updated => this._object_updated;

  String get object_id => this._object_id;

  String get object_owner => this._object_owner;

  String get certify_signer => this._certify_signer;

  String get certify => this._certify;

  List<String> get items => this._items;

  String get non_delivery_option => this._non_delivery_option;

  String get contents_type => this._contents_type;

  String get contents_explanation => this._contents_explanation;

  String get exporter_reference => this._exporter_reference;

  String get importer_reference => this._importer_reference;

  String get invoice => this._invoice;

  String get license => this._license;

  String get certificate => _certificate;

  String get notes => this._notes;

  String get eel_pfc => this._eel_pfc;

  String get aes_itn => this._aes_itn;

  String get incoterm => this._incoterm;

  String get metadata => this._metadata;

  String get disclaimer => this._disclaimer;

  String get test => this._test;

  CustomDeclaration({
    String object_state,
    String object_created,
    String object_updated,
    String object_id,
    String object_owner,
    String certify_signer,
    String certify,
    List<String> items,
    String non_delivery_option,
    String contents_type,
    String contents_explanation,
    String exporter_reference,
    String importer_reference,
    String invoice,
    String license,
    String certificate,
    String notes,
    String eel_pfc,
    String aes_itn,
    String incoterm,
    String disclaimer,
    String metadata,
    String test,
  }) {
    this._object_state = object_state;
    this._object_created = object_created;
    this._object_updated = object_updated;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._certify_signer = certify_signer;
    this._certify = certify;
    this._items = items;
    this._non_delivery_option = non_delivery_option;
    this._contents_type = contents_type;
    this._contents_explanation = contents_explanation;
    this._exporter_reference = exporter_reference;
    this._importer_reference = importer_reference;
    this._invoice = invoice;
    this._license = license;
    this._certificate = certificate;
    this._notes = notes;
    this._eel_pfc = eel_pfc;
    this._aes_itn = aes_itn;
    this._incoterm = incoterm;
    this._disclaimer = disclaimer;
    this._metadata = metadata;
    this._test = test;
  }

  CustomDeclaration.fromMap(Map<String, dynamic> obj) {
    this._object_state = obj['object_state'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._certify_signer = obj['certify_signer'];
    this._certify = obj['certify'];
    this._items = obj['items'].map((e) => e.toString()).toList();
    this._non_delivery_option = obj['non_delivery_option'];
    this._contents_type = obj['contents_type'];
    this._contents_explanation = obj['contents_explanation'];
    this._exporter_reference = obj['exporter_reference'];
    this._importer_reference = obj['importer_reference'];
    this._invoice = obj['invoice'];
    this._license = obj['license'];
    this._certificate = obj['certificate'];
    this._notes = obj['notes'];
    this._eel_pfc = obj['eel_pfc'];
    this._aes_itn = obj['aes_itn'];
    this._incoterm = obj['incoterm'];
    this._disclaimer = obj['disclaimer'];
    this._metadata = obj['metadata'];
    this._test = obj['test'];
  }

  CustomDeclaration.map(dynamic obj) {
    this._object_state = obj['object_state'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._certify_signer = obj['certify_signer'];
    this._certify = obj['certify'];
    this._items = obj['items'].map((e) => e.toString()).toList();
    this._non_delivery_option = obj['non_delivery_option'];
    this._contents_type = obj['contents_type'];
    this._contents_explanation = obj['contents_explanation'];
    this._exporter_reference = obj['exporter_reference'];
    this._importer_reference = obj['importer_reference'];
    this._invoice = obj['invoice'];
    this._license = obj['license'];
    this._certificate = obj['certificate'];
    this._notes = obj['notes'];
    this._eel_pfc = obj['eel_pfc'];
    this._aes_itn = obj['aes_itn'];
    this._incoterm = obj['incoterm'];
    this._disclaimer = obj['disclaimer'];
    this._metadata = obj['metadata'];
    this._test = obj['test'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._object_state != null) map['object_state'] = this._object_state;
    if (this._object_created != null)
      map['object_created'] = this._object_created;
    if (this._object_updated != null)
      map['object_updated'] = this._object_updated;
    if (this._object_id != null) map['object_id'] = this._object_id;
    if (this._object_owner != null) map['object_owner'] = this._object_owner;
    if (this._certify_signer != null)
      map['certify_signer'] = this._certify_signer;
    if (this._certify != null) map['certify'] = this._certify;
    if (this._items != null) map['items'] = this._items.map((f) => f);
    if (this._non_delivery_option != null)
      map['non_delivery_option'] = this._non_delivery_option;
    if (this._contents_type != null) map['contents_type'] = this._contents_type;
    if (this._contents_explanation != null)
      map['contents_explanation'] = this._contents_explanation;
    if (this._exporter_reference != null)
      map['exporter_reference'] = this._exporter_reference;
    if (this._importer_reference != null)
      map['importer_reference'] = this._importer_reference;
    if (this._invoice != null) map['invoice'] = this._invoice;
    if (this._license != null) map['license'] = this._license;
    if (this._certificate != null) map['certificate'] = this._certificate;
    if (this._notes != null) map['notes'] = this._notes;
    if (this._eel_pfc != null) map['eel_pfc'] = this._eel_pfc;
    if (this._aes_itn != null) map['aes_itn'] = this._aes_itn;
    if (this._incoterm != null) map['incoterm'] = this._incoterm;
    if (this._disclaimer != null) map['disclaimer'] = this._disclaimer;
    if (this._metadata != null) map['metadata'] = this._metadata;
    if (this._test != null) map['test'] = this._test;
    return map;
  }
}

class CustomDeclarationBody {
  String _certify_signer;
  String _certify;
  List<String> _items;
  String _non_delivery_option;
  String _contents_type;
  String _contents_explanation;
  String _exporter_reference;
  String _importer_reference;
  String _invoice;
  String _license;
  String _certificate;
  String _notes;
  String _eel_pfc;
  String _aes_itn;
  String _incoterm;
  String _metadata;

  String get certify_signer => this._certify_signer;

  String get certify => this._certify;

  List<String> get items => this._items;

  String get non_delivery_option => this._non_delivery_option;

  String get contents_type => this._contents_type;

  String get contents_explanation => this._contents_explanation;

  String get exporter_reference => this._exporter_reference;

  String get importer_reference => this._importer_reference;

  String get invoice => this._invoice;

  String get license => this._license;

  String get certificate => _certificate;

  String get notes => this._notes;

  String get eel_pfc => this._eel_pfc;

  String get aes_itn => this._aes_itn;

  String get incoterm => this._incoterm;

  String get metadata => this._metadata;

  CustomDeclarationBody({
    String certify_signer,
    String certify,
    List<String> items,
    String non_delivery_option,
    String contents_type,
    String contents_explanation,
    String exporter_reference,
    String importer_reference,
    String invoice,
    String license,
    String certificate,
    String notes,
    String eel_pfc,
    String aes_itn,
    String incoterm,
    String metadata,
  }) {
    this._certify_signer = certify_signer;
    this._certify = certify;
    this._items = items;
    this._non_delivery_option = non_delivery_option;
    this._contents_type = contents_type;
    this._contents_explanation = contents_explanation;
    this._exporter_reference = exporter_reference;
    this._importer_reference = importer_reference;
    this._invoice = invoice;
    this._license = license;
    this._certificate = certificate;
    this._notes = notes;
    this._eel_pfc = eel_pfc;
    this._aes_itn = aes_itn;
    this._incoterm = incoterm;
    this._metadata = metadata;
  }

  CustomDeclarationBody.fromMap(Map<String, dynamic> obj) {
    this._certify_signer = obj['certify_signer'];
    this._certify = obj['certify'];
    this._items = obj['items'].map((e) => e.toString()).toList();
    this._non_delivery_option = obj['non_delivery_option'];
    this._contents_type = obj['contents_type'];
    this._contents_explanation = obj['contents_explanation'];
    this._exporter_reference = obj['exporter_reference'];
    this._importer_reference = obj['importer_reference'];
    this._invoice = obj['invoice'];
    this._license = obj['license'];
    this._certificate = obj['certificate'];
    this._notes = obj['notes'];
    this._eel_pfc = obj['eel_pfc'];
    this._aes_itn = obj['aes_itn'];
    this._incoterm = obj['incoterm'];
    this._metadata = obj['metadata'];
  }

  CustomDeclarationBody.map(dynamic obj) {
    this._certify_signer = obj['certify_signer'];
    this._certify = obj['certify'];
    this._items = obj['items'].map((e) => e.toString()).toList();
    this._non_delivery_option = obj['non_delivery_option'];
    this._contents_type = obj['contents_type'];
    this._contents_explanation = obj['contents_explanation'];
    this._exporter_reference = obj['exporter_reference'];
    this._importer_reference = obj['importer_reference'];
    this._invoice = obj['invoice'];
    this._license = obj['license'];
    this._certificate = obj['certificate'];
    this._notes = obj['notes'];
    this._eel_pfc = obj['eel_pfc'];
    this._aes_itn = obj['aes_itn'];
    this._incoterm = obj['incoterm'];
    this._metadata = obj['metadata'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._certify_signer != null)
      map['certify_signer'] = this._certify_signer;
    if (this._certify != null) map['certify'] = this._certify;
    if (this._items != null) map['items'] = this._items.map((f) => f);
    if (this._non_delivery_option != null)
      map['non_delivery_option'] = this._non_delivery_option;
    if (this._contents_type != null) map['contents_type'] = this._contents_type;
    if (this._contents_explanation != null)
      map['contents_explanation'] = this._contents_explanation;
    if (this._exporter_reference != null)
      map['exporter_reference'] = this._exporter_reference;
    if (this._importer_reference != null)
      map['importer_reference'] = this._importer_reference;
    if (this._invoice != null) map['invoice'] = this._invoice;
    if (this._license != null) map['license'] = this._license;
    if (this._certificate != null) map['certificate'] = this._certificate;
    if (this._notes != null) map['notes'] = this._notes;
    if (this._eel_pfc != null) map['eel_pfc'] = this._eel_pfc;
    if (this._aes_itn != null) map['aes_itn'] = this._aes_itn;
    if (this._incoterm != null) map['incoterm'] = this._incoterm;
    if (this._metadata != null) map['metadata'] = this._metadata;

    return map;
  }
}
