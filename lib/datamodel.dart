class Product {
  final String PName;
  final double price;
  final String PImage;
  final String brand;
  final String description;

  Product({
    required this.PName,
    required this.price,
    required this.PImage,
    required this.brand,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      PName: json['PName'] as String,
      price: json['price'] as double,
      PImage: json['PImage'] as String,
      brand: json['brand'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PName': PName,
      'price': price,
      'PImage': PImage,
      'brand': brand,
      'description': description,
    };
  }
}
