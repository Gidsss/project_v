class Product {
  final String imageURL;
  final String name;
  final String price;
  final String description;  // example of adding more fields

  Product({
    required this.imageURL,
    required this.name,
    required this.price,
    this.description = '',  // optional field with a default value
  });

  // Factory constructor to create a Product from a map (e.g., JSON)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imageURL: json['image_url'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      description: json['description'] ?? '',  // using get with a default if not present
    );
  }

  // Method to convert Product object to JSON map, useful for sending data to a backend or storing locally
  Map<String, dynamic> toJson() {
    return {
      'image_url': imageURL,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
