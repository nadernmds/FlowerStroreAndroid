import 'dart:convert';
import '../Api.dart';
import '../User/User.dart';

class Order extends Api {
  int orderID;
  double sendingPrice;
  String data;
  int conditionID;
  int userID;
  int addressID;
  User user;
  Condition condition;

  Order(
      {this.orderID,
      this.sendingPrice,
      this.data,
      this.conditionID,
      this.userID,
      this.addressID,
      this.user});

  Order.fromjson(x) {
    if(x==null)
    return;
    this.orderID = x["orderID"];
    this.sendingPrice = x["sendingPrice"];
    this.data = x["data"];
    this.conditionID = x["conditionID"];
    this.userID = x["userID"];
    this.addressID = x["adressID"];
    this.user = x["user"];
  }

  Future<List<Order>> getOrders() async {
    var res = await getUrl('Order');
    var w = jsonDecode(res.body);
    var orders = new List<Order>();
    for (var order in w) {
      orders.add(order.fromjson(order));
    }
    return orders;
  }

  Future<Order> getOrder(int id) async {
    var res = await getUrl('Order/' + id.toString());
    var w = jsonDecode(res.body);
    return Order.fromjson(w);
  }

  Future<Order> createOrder(Order order) async {
    var res = await postUrl(url: 'Order', body: order);
    var w = jsonDecode(res.body);
    return Order.fromjson(w);
  }

  Future<int> editOrder(int id, Order order) async {
    var res = await putUrl(url: 'Order' + id.toString(), body: order);
    return res.statusCode;
  }

  Future<Order> deleteOrder(int id) async {
    var res = await deleteUrl('Order' + id.toString());
    var w = jsonDecode(res.body);
    return Order.fromjson(w);
  }

  Map<String, dynamic> toMap() {
    return {
      'orderID': this.orderID,
      'sendingPrice': this.sendingPrice,
      'data': this.data,
      'conditionID': this.conditionID,
      'userID': this.userID,
      'addressID': this.addressID,
      'user': this.user
    };
  }
}

class Condition {
  int conditionID;
  String description;

  Condition({this.conditionID, this.description});

  Condition.fromjson(x) {
    if (x == null) return;
    this.conditionID = x["conditionID"];
    this.description = x["description"];
  }
}
