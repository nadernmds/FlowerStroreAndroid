import 'dart:convert';
import '../Api.dart';
import '../Product/Product.dart';

class ProductImage extends Api
{
  int productImageID;
  int productID;
  Product product;

  ProductImage({
    this.productImageID,
    this.productID,
    this.product
  });

  ProductImage.fromjson(x)
  {
    if(x==null)
    return;
    this.productImageID=x["productImageID"];
    this.productID=x["productID"];
    this.product=x["product"];
  }

  Future<ProductImage> getProductImage(int id) async{
    var res=await getUrl('ProductImage/'+id.toString());
    var w=jsonDecode(res.body);
    return ProductImage.fromjson(w);
  }
  Future<ProductImage> createProductImage(ProductImage productimage) async{
    var res=await postUrl(url: 'ProductImage',body: productimage);
    var w=jsonDecode(res.body);
    return ProductImage.fromjson(w);
  }

  Future<int> editProductImage(int id,ProductImage productimage) async{
    var res=await putUrl(url: 'ProductImage'+id.toString(),body: productimage);
    return res.statusCode;
  }

  Future<ProductImage> deleteProductImage(int id) async{
    var res=await deleteUrl('ProductImage'+id.toString());
    var w=jsonDecode(res.body);
    return ProductImage.fromjson(w);
  }

  Map<String,dynamic> toMap()
  {
    return{
      'productImageID':this.productImageID,
      'productID':this.productID,
      'product':this.product
    };
  }
}