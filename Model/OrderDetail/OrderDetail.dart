import 'dart:convert';
import '../Api.dart';
import '../Order/Order.dart';
import '../Product/Product.dart';

class OrderDetail extends Api {
  int orderDetailID;
  int productID;
  int orderID;
  int orderCount;
  double productPrice;
  String sendingWay;
  Order order;
  Product product;

  OrderDetail(
      {this.orderDetailID,
      this.productID,
      this.orderID,
      this.orderCount,
      this.productPrice,
      this.sendingWay,
      this.order});

  OrderDetail.fromjson(x) {
    if(x==null)
    return;
    this.orderDetailID = x["orderDetailID"];
    this.productID = x["productID"];
    this.orderID = x["orderID"];
    this.orderCount = x["orderCount"];
    this.productPrice = x["productPrice"];
    this.sendingWay = x["sendingWay"];
    this.order = x["order"];
  }

  Future<List<OrderDetail>> getOrderDetails() async {
    var res = await getUrl('OrderDetail');
    var w = jsonDecode(res.body);
    var orderdetails = new List<OrderDetail>();
    for (var orderdetail in w) {
      orderdetails.add(orderdetail.fromjson(orderdetail));
    }
    return orderdetails;
  }

  Future<OrderDetail> getOrderDetail(int id) async {
    var res = await getUrl('OrderDetail/' + id.toString());
    var w = jsonDecode(res.body);
    return OrderDetail.fromjson(w);
  }

  Future<OrderDetail> createOrderDetail(OrderDetail orderdetail) async {
    var res = await postUrl(url: 'OrderDetail', body: orderdetail);
    var w = jsonDecode(res.body);
    return OrderDetail.fromjson(w);
  }

  Future<int> editOrderDetail(int id, OrderDetail orderdetail) async {
    var res =
        await putUrl(url: 'OrderDetail' + id.toString(), body: orderdetail);
    return res.statusCode;
  }

  Future<OrderDetail> deleteOrderDetail(int id) async {
    var res = await deleteUrl('OrderDetail' + id.toString());
    var w = jsonDecode(res.body);
    return OrderDetail.fromjson(w);
  }

  Map<String, dynamic> toMap() {
    return {
      'orderDetailID': this.orderDetailID,
      'productID': this.productID,
      'orderID': this.orderID,
      'orderCount': this.orderCount,
      'productPrice': this.productPrice,
      'sendingWay': this.sendingWay,
      'order': this.order
    };
  }
}
