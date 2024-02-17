class Product {
  String? image;

  Product({this.image});

  Product.fromJson(Map<String, dynamic> json) {
    image = json['url'];
  }
}
