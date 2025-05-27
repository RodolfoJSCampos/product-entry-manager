// lib/features/products/presentation/controllers/product_controller.dart
import 'package:flutter/material.dart';
import '../../../../models/product_model.dart';
import '../../../products/domain/add_product.dart';
import '../../domain/get_all_products.dart';
import '../../domain/delete_product.dart';
import '../../domain/update_product.dart';

class ProductController extends ChangeNotifier {
  final AddProduct _addProduct;
  final GetAllProducts _getAllProducts;
  final DeleteProduct _deleteProduct;
  final UpdateProduct _updateProduct;

  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  ProductController({
    required AddProduct addProduct,
    required GetAllProducts getAllProducts,
    required DeleteProduct deleteProduct,
    required UpdateProduct updateProduct,
  })  : _addProduct = addProduct,
        _getAllProducts = getAllProducts,
        _deleteProduct = deleteProduct,
        _updateProduct = updateProduct;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _getAllProducts();
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar produtos: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> add(ProductModel product) async {
    try {
      await _addProduct(product);
      await loadProducts();
    } catch (e) {
      _error = 'Erro ao adicionar produto: $e';
      notifyListeners();
    }
  }

  Future<void> update(ProductModel product) async {
    try {
      await _updateProduct(product);
      await loadProducts();
    } catch (e) {
      _error = 'Erro ao atualizar produto: $e';
      notifyListeners();
    }
  }

  Future<void> delete(String sku) async {
    try {
      await _deleteProduct(sku);
      await loadProducts();
    } catch (e) {
      _error = 'Erro ao remover produto: $e';
      notifyListeners();
    }
  }
}
