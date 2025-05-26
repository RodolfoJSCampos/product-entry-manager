import 'item_model.dart';

class NoteModel {
  final String key;
  final DateTime date;
  final String supplier;
  final String? shop;
  final double? discount;
  final double? taxes;
  final double? shipping;
  final List<ItemModel> items;

  NoteModel({
    required this.key,
    required this.date,
    required this.supplier,
    this.shop,
    this.discount,
    this.taxes,
    this.shipping,
    required this.items,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      key: map['key'],
      date: DateTime.parse(map['date']),
      supplier: map['supplier'],
      shop: map['shop'],
      discount: map['discount'] != null ? (map['discount'] as num).toDouble() : null,
      taxes: map['taxes'] != null ? (map['taxes'] as num).toDouble() : null,
      shipping: map['shipping'] != null ? (map['shipping'] as num).toDouble() : null,
      items: (map['items'] as List)
          .map((item) => ItemModel.fromMap(item))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'date': date.toIso8601String(),
      'supplier': supplier,
      'shop': shop,
      'discount': discount,
      'taxes': taxes,
      'shipping': shipping,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  NoteModel copyWith({
    String? key,
    DateTime? date,
    String? supplier,
    String? shop,
    double? discount,
    double? taxes,
    double? shipping,
    List<ItemModel>? items,
  }) {
    return NoteModel(
      key: key ?? this.key,
      date: date ?? this.date,
      supplier: supplier ?? this.supplier,
      shop: shop ?? this.shop,
      discount: discount ?? this.discount,
      taxes: taxes ?? this.taxes,
      shipping: shipping ?? this.shipping,
      items: items ?? this.items,
    );
  }
}
