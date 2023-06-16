class ProductModel {
  String? productName;
  String? productPrice;
  String? productImage;
  String? productDescribtion;
  String? productCategory ;
  bool? productVerified;


  ProductModel ({
    required this.productName ,
    required this.productPrice,
    required this.productImage,
    required this.productDescribtion,
    required this.productCategory ,
    required this.productVerified ,


  });

  ProductModel.fromFire(Map <String , dynamic> fire){
    productName = fire['productName'];
    productPrice = fire['productPrice'];
    productImage = fire['productImage'];
    productDescribtion = fire['productDescribtion'];
    productCategory = fire['productCategory'];
    productVerified = fire['productVerified'];

  }

  Map <String , dynamic> toMap ()
  {
    return{
      'productName' : productName,
      'productPrice' : productPrice,
      'productImage' : productImage,
      'productDescribtion' : productDescribtion,
      'productCategory' : productCategory,
      'productVerified' : productVerified,
    };
  }

}