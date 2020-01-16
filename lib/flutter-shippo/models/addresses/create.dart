class AddressCreateBody {
  String name;
  String company;
  String street1;
  String street_no;
  String street2;
  String street3;
  String city;
  String zip;
  String state;
  String country;
  String phone;
  String email;
  String is_residential;
  String validate;
  String metadata;

  AddressCreateBody(
      {this.name,
      this.company,
      this.street1,
      this.street_no,
      this.street2,
      this.street3,
      this.city,
      this.zip,
      this.state,
      this.country,
      this.phone,
      this.email,
      this.is_residential,
      this.validate,
      this.metadata});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this.name != null) map['name'] = this.name;
    if (this.company != null) map['company'] = this.company;
    if (this.street1 != null) map['street1'] = this.street1;
    if (this.street_no != null) map['street_no'] = this.street_no;
    if (this.street2 != null) map['street2'] = this.street2;
    if (this.street3 != null) map['street3'] = this.street3;
    if (this.city != null) map['city'] = this.city;
    if (this.zip != null) map['zip'] = this.zip;
    if (this.state != null) map['state'] = this.state;
    if (this.country != null) map['country'] = this.country;
    if (this.phone != null) map['phone'] = this.phone;
    if (this.email != null) map['email'] = this.email;
    if (this.is_residential != null)
      map['is_residential'] = this.is_residential;
    if (this.validate != null) map['validate'] = this.validate;
    if (this.metadata != null) map['metadada'] = this.metadata;

    return map;
  }
}
