import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/note_model.dart';
import '../../presentation/controllers/note_controller.dart';

class NoteFormPage extends StatefulWidget {
  const NoteFormPage({super.key});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _keyController = TextEditingController();
  DateTime? _selectedDate;
  final _supplierController = TextEditingController();
  final _shopController = TextEditingController();
  final _discountController = TextEditingController();
  final _taxesController = TextEditingController();
  final _shippingController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione a data da nota')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final note = NoteModel(
      key: _keyController.text.trim(),
      date: _selectedDate!,
      supplier: _supplierController.text.trim(),
      shop: _shopController.text.trim().isEmpty ? null : _shopController.text.trim(),
      discount: double.tryParse(_discountController.text.trim()) ?? 0,
      taxes: double.tryParse(_taxesController.text.trim()) ?? 0,
      shipping: double.tryParse(_shippingController.text.trim()) ?? 0,
      items: [], // inicialmente vazio
    );

    try {
      await context.read<NoteController>().add(note);
      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar nota: $e')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  void dispose() {
    _keyController.dispose();
    _supplierController.dispose();
    _shopController.dispose();
    _discountController.dispose();
    _taxesController.dispose();
    _shippingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Nota de Entrada')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _keyController,
                decoration: const InputDecoration(labelText: 'Chave da Nota'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a chave da nota'
                    : null,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Data da Nota',
                      hintText: _selectedDate == null
                          ? 'Selecione a data'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                    validator: (_) =>
                        _selectedDate == null ? 'Selecione a data' : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _supplierController,
                decoration: const InputDecoration(labelText: 'Fornecedor'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe o fornecedor'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _shopController,
                decoration: const InputDecoration(labelText: 'Loja do Marketplace (opcional)'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: 'Desconto Geral (opcional)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  return double.tryParse(value) == null ? 'Número inválido' : null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _taxesController,
                decoration: const InputDecoration(labelText: 'Impostos (opcional)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  return double.tryParse(value) == null ? 'Número inválido' : null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _shippingController,
                decoration: const InputDecoration(labelText: 'Frete (opcional)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  return double.tryParse(value) == null ? 'Número inválido' : null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Salvar Nota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
