class ItemModel {
  final String productSku;
  final double quantity;
  final double price;
  final DateTime? expiration;
  final double? discount;
  final double? taxes;
  final double? shipping;

  ItemModel({
    required this.productSku,
    required this.quantity,
    required this.price,
    this.expiration,
    this.discount,
    this.taxes,
    this.shipping,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      productSku: map['productSku'],
      quantity: (map['quantity'] as num).toDouble(),
      price: (map['price'] as num).toDouble(),
      expiration: map['expiration'] != null
          ? DateTime.parse(map['expiration'])
          : null,
      discount: map['discount'] != null ? (map['discount'] as num).toDouble() : null,
      taxes: map['taxes'] != null ? (map['taxes'] as num).toDouble() : null,
      shipping: map['shipping'] != null ? (map['shipping'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productSku': productSku,
      'quantity': quantity,
      'price': price,
      'expiration': expiration?.toIso8601String(),
      'discount': discount,
      'taxes': taxes,
      'shipping': shipping,
    };
  }

  ItemModel copyWith({
    String? productSku,
    double? quantity,
    double? price,
    DateTime? expiration,
    double? discount,
    double? taxes,
    double? shipping,
  }) {
    return ItemModel(
      productSku: productSku ?? this.productSku,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      expiration: expiration ?? this.expiration,
      discount: discount ?? this.discount,
      taxes: taxes ?? this.taxes,
      shipping: shipping ?? this.shipping,
    );
  }
}
