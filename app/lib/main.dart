import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/notes/data/note_repository.dart';
import 'features/notes/domain/add_note.dart';
import 'features/notes/domain/delete_note.dart';
import 'features/notes/domain/get_all_note.dart';
import 'features/notes/domain/update_note.dart';
import 'features/products/data/product_repository.dart';
import 'features/products/domain/add_product.dart';
import 'features/products/domain/delete_product.dart';
import 'features/products/domain/get_all_products.dart';
import 'features/products/domain/update_product.dart';
import 'features/products/presentation/controllers/product_controller.dart';

import 'features/notes/presentation/controllers/note_controller.dart';

import 'core/services/firestore_service.dart';

import 'features/products/presentation/pages/product_form_page.dart';
import 'features/notes/presentation/pages/note_form_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),

        // Produtos
        Provider<ProductRepository>(
          create: (context) => ProductRepository(context.read<FirestoreService>()),
        ),
        Provider<AddProduct>(
          create: (context) => AddProduct(context.read<ProductRepository>()),
        ),
        Provider<GetAllProducts>(
          create: (context) => GetAllProducts(context.read<ProductRepository>()),
        ),
        Provider<DeleteProduct>(
          create: (context) => DeleteProduct(context.read<ProductRepository>()),
        ),
        Provider<UpdateProduct>(
          create: (context) => UpdateProduct(context.read<ProductRepository>()),
        ),
        ChangeNotifierProvider<ProductController>(
          create: (context) => ProductController(
            addProduct: context.read<AddProduct>(),
            getAllProducts: context.read<GetAllProducts>(),
            deleteProduct: context.read<DeleteProduct>(),
            updateProduct: context.read<UpdateProduct>(),
          ),
        ),

        // Notas
        Provider<NoteRepository>(
          create: (context) => NoteRepository(context.read<FirestoreService>()),
        ),
        Provider<AddNote>(
          create: (context) => AddNote(context.read<NoteRepository>()),
        ),
        Provider<GetAllNotes>(
          create: (context) => GetAllNotes(context.read<NoteRepository>()),
        ),
        Provider<DeleteNote>(
          create: (context) => DeleteNote(context.read<NoteRepository>()),
        ),
        Provider<UpdateNote>(
          create: (context) => UpdateNote(context.read<NoteRepository>()),
        ),
        ChangeNotifierProvider<NoteController>(
          create: (context) => NoteController(
            addNote: context.read<AddNote>(),
            getAllNotes: context.read<GetAllNotes>(),
            deleteNote: context.read<DeleteNote>(),
            updateNote: context.read<UpdateNote>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Gerenciador de Produtos e Notas',
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Inicial')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductFormPage()),
                );
              },
              child: const Text('Cadastrar Produto'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NoteFormPage()),
                );
              },
              child: const Text('Cadastrar Nota de Entrada'),
            ),
          ],
        ),
      ),
    );
  }
}
