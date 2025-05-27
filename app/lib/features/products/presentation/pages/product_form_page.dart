import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../products/presentation/controllers/product_controller.dart';
import '../../../../models/product_model.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _eanController = TextEditingController();
  final _weightController = TextEditingController();
  final _brandController = TextEditingController();
  final _fabricanteController = TextEditingController();
  final _categoriesController = TextEditingController();
  final _imageController = TextEditingController();

  bool _isSubmitting = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final sku = DateTime.now().millisecondsSinceEpoch.toString(); // Geração simples de SKU
    final product = ProductModel(
      sku: sku,
      name: _nameController.text.trim(),
      ean: _eanController.text.trim(),
      weight: double.tryParse(_weightController.text.trim()) ?? 0,
      brand: _brandController.text.trim(),
      fabricante: _fabricanteController.text.trim(),
      categories: _categoriesController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      image: _imageController.text.trim().isEmpty ? null : _imageController.text.trim(),
    );

    await context.read<ProductController>().add(product);

    setState(() => _isSubmitting = false);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _eanController.dispose();
    _weightController.dispose();
    _brandController.dispose();
    _fabricanteController.dispose();
    _categoriesController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _eanController,
                decoration: const InputDecoration(labelText: 'EAN'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o EAN' : null,
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Peso (g ou ml)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    double.tryParse(value ?? '') == null ? 'Informe um peso válido' : null,
              ),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a marca' : null,
              ),
              TextFormField(
                controller: _fabricanteController,
                decoration: const InputDecoration(labelText: 'Fabricante'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o fabricante' : null,
              ),
              TextFormField(
                controller: _categoriesController,
                decoration: const InputDecoration(
                  labelText: 'Categorias (separadas por vírgula)',
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Informe ao menos uma categoria' : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'URL da Imagem (opcional)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
