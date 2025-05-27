import 'package:uuid/uuid.dart';
import '../../../models/product_model.dart';
import '../../../core/services/firestore_service.dart';

class ProductRepository {
  final FirestoreService _firestoreService;
  final String _collectionPath = 'products';

  ProductRepository(this._firestoreService);

  Future<void> addProduct(ProductModel product) async {
    final sku = _generateSku(product);
    final newProduct = product.copyWith(sku: sku);

    await _firestoreService.setDocument(
      collectionPath: _collectionPath,
      docId: sku,
      data: newProduct.toMap(),
    );
  }

  Future<ProductModel?> getProduct(String sku) async {
    final data = await _firestoreService.getDocument(
      collectionPath: _collectionPath,
      docId: sku,
    );
    return data != null ? ProductModel.fromMap(data) : null;
  }

  Future<void> updateProduct(ProductModel product) async {
    await _firestoreService.updateDocument(
      collectionPath: _collectionPath,
      docId: product.sku,
      data: product.toMap(),
    );
  }

  Future<void> deleteProduct(String sku) async {
    await _firestoreService.deleteDocument(
      collectionPath: _collectionPath,
      docId: sku,
    );
  }

  Future<List<ProductModel>> getAllProducts() async {
    final dataList = await _firestoreService.getCollection(
      collectionPath: _collectionPath,
    );
    return dataList.map(ProductModel.fromMap).toList();
  }

  String _generateSku(ProductModel product) {
    final uuid = const Uuid().v4().substring(0, 6).toUpperCase();
    final base = '${product.name}-${product.brand}'.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
    return '$base-$uuid';
  }
}
