import 'dart:convert';
import '../Api.dart';


class ProductCategory extends Api
{
  int productCategoryID;
  String categoryName;

  ProductCategory({
    this.productCategoryID,
    this.categoryName
  });

  ProductCategory.fromjson(x)
  {
    if(x==null)
    return;
    this.productCategoryID=x["productCategoryID"];
    this.categoryName=x["categoryName"];
  }

  Future<List<ProductCategory>> getProductCategories() async {
    var res=await getUrl('ProductCategory');
    var w=jsonDecode(res.body);
    var categories=new List<ProductCategory>();
    for (var category in w) {
      categories.add(category.fromjson(category));
    }
    return categories;
  }

  Future<ProductCategory> getProductCategory(int id) async{
    var res=await getUrl('ProductCategory/'+id.toString());
    var w=jsonDecode(res.body);
    return ProductCategory.fromjson(w);
  }

  Future<ProductCategory> createProductCategory(ProductCategory productcategory) async{
    var res=await postUrl(url: 'ProductCategory',body: productcategory);
    var w=jsonDecode(res.body);
    return ProductCategory.fromjson(w);
  }

  Future<int> editProductCategory(int id,ProductCategory productcategory) async{
    var res=await putUrl(url: 'ProductCategory'+id.toString(),body: productcategory);
    return res.statusCode;
  }

  Future<ProductCategory> deleteProductCategory(int id) async{
    var res=await deleteUrl('ProductCategory'+id.toString());
    var w=jsonDecode(res.body);
    return ProductCategory.fromjson(w);
  }

  Map<String,dynamic> toMap()
  {
    return
    {
      'productCategoryID':this.productCategoryID,
      'categoryName':this.categoryName
    };
  }
}