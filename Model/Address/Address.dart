import 'dart:convert';
import '../Api.dart';
import '../Order/Order.dart';
import '../User/User.dart';

class Address extends Api {
  int addressID;
  String addressDetail;
  String postalCode;
  int userID;
  User user;
  Order order;

  Address(
      {this.addressID,
      this.addressDetail,
      this.postalCode,
      this.userID,
      this.user});

  Address.fromjson(x) {
    if(x==null)
    return;
    this.addressID = x["addressID"];
    this.addressDetail = x["addressDetail"];
    this.postalCode = x["postalCode"];
    this.userID = x["userID"];
    this.user = x["user"];
  }

  Future<List<Address>> getAddresses() async {
    var res = await getUrl('Address');
    var w = jsonDecode(res.body);
    var addresses = new List<Address>();
    for (var address in w) {
      addresses.add(address.fromjson(address));
    }
    return addresses;
  }

  Future<Address> getAddress(int id) async {
    var res = await getUrl('Address/' + id.toString());
    var w = jsonDecode(res.body);
    return Address.fromjson(w);
  }

  Future<Address> createAddress(Address address) async {
    var res = await postUrl(url: 'Address', body: address);
    var w = jsonDecode(res.body);
    return Address.fromjson(w);
  }

  Future<int> editAddress(int id, Address address) async {
    var res = await putUrl(url: 'Address' + id.toString(), body: address);
    return res.statusCode;
  }

  Future<Address> deleteAddress(int id) async {
    var res = await deleteUrl('Address' + id.toString());
    var w = jsonDecode(res.body);
    return Address.fromjson(w);
  }

  Map<String, dynamic> toMap() {
    return {
      'addressID': this.addressID,
      'addressDetail': this.addressDetail,
      'postalCode': this.postalCode,
      'userID': this.userID,
      'user': this.user
    };
  }
}
