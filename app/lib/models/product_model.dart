class ProductModel {
  final String sku;
  final String ean;
  final String name;
  final double weight;
  final String image;
  final List<String> categories;
  final String brand;
  final String fabricante;

  ProductModel({
    required this.sku,
    required this.ean,
    required this.name,
    required this.weight,
    required this.image,
    required this.categories,
    required this.brand,
    required this.fabricante,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      sku: map['sku'],
      ean: map['ean'],
      name: map['name'],
      weight: (map['weight'] as num).toDouble(),
      image: map['image'],
      categories: List<String>.from(map['categories']),
      brand: map['brand'],
      fabricante: map['fabricante'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sku': sku,
      'ean': ean,
      'name': name,
      'weight': weight,
      'image': image,
      'categories': categories,
      'brand': brand,
      'fabricante': fabricante,
    };
  }

  ProductModel copyWith({
    String? sku,
    String? ean,
    String? name,
    double? weight,
    String? image,
    List<String>? categories,
    String? brand,
    String? fabricante,
  }) {
    return ProductModel(
      sku: sku ?? this.sku,
      ean: ean ?? this.ean,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      image: image ?? this.image,
      categories: categories ?? this.categories,
      brand: brand ?? this.brand,
      fabricante: fabricante ?? this.fabricante,
    );
  }
}
