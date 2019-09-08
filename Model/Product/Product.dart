import 'dart:convert';
import '../Api.dart';
import '../ProductCategory/ProductCategory.dart';

class Product extends Api {
  int productID;
  String productName;
  int existingCount;
  double price;
  bool exisitState;
  bool activeProduct;
  String description;
  int productCategoryID;
  ProductCategory productCategory;

  Product(
      {this.productID,
      this.productName,
      this.existingCount,
      this.price,
      this.exisitState,
      this.activeProduct,
      this.description,
      this.productCategoryID,
      this.productCategory});

  Product.fromjson(x) {
    if(x==null)
    return;
    this.productID = x["productID"];
    this.productName = x["productName"];
    this.existingCount = x["existingCount"];
    this.price = x["price"];
    this.exisitState = x["exisitState"];
    this.activeProduct = x["activeProduct"];
    this.description = x["description"];
    this.productCategoryID = x["productCategoryID"];
    this.productCategory = x["productCategory"];
  }

  Future<List<Product>> getProducts() async {
    var res = await getUrl('product');
    var w = jsonDecode(res.body);
    var products = new List<Product>();
    for (var product in w) {
      products.add(product.fromjson(product));
    }
    return products;
  }

  Future<Product> getProduct(int id) async {
    var res = await getUrl('product/' + id.toString());
    var w = jsonDecode(res.body);
    return Product.fromjson(w);
  }

  Future<Product> createProduct(Product product) async {
    var res = await postUrl(url: 'product/', body: product);
    var w = jsonDecode(res.body);
    return Product.fromjson(w);
  }

  Future<int> editProduct(int id, Product product) async {
    var res = await putUrl(url: 'product/' + id.toString(), body: product);
    return res.statusCode;
  }

  Future<Product> deleteProduct(int id) async {
    var res = await deleteUrl('product' + id.toString());
    var w = jsonDecode(res.body);
    return Product.fromjson(w);
  }

  Map<String, dynamic> toMap() {
    return {
      'productID': this.productID,
      'productName': this.productName,
      'existingCount': this.existingCount,
      'price': this.price,
      'exisitState': this.exisitState,
      'activeProduct': this.activeProduct,
      'description': this.description,
      'productCategoryID': this.productCategoryID,
      'productCategory': this.productCategory
    };
  }
}
