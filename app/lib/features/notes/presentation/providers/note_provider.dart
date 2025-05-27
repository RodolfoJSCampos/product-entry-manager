// lib/features/notes/presentation/providers/note_provider.dart
import 'package:provider/provider.dart';

import '/core/services/firestore_service.dart';
import '../../data/note_repository.dart';
import '../../domain/add_note.dart';
import '../../domain/delete_note.dart';
import '../../domain/get_all_notes.dart';
import '../../domain/update_note.dart';
import '../controllers/note_controller.dart';

ChangeNotifierProvider<NoteController> noteControllerProvider() {
  final firestore = FirestoreService();
  final repo = NoteRepository(firestore);

  return ChangeNotifierProvider<NoteController>(
    create: (_) => NoteController(
      addNote: AddNote(repo),
      getAllNotes: GetAllNotes(repo),
      deleteNote: DeleteNote(repo),
      updateNote: UpdateNote(repo),
    )..loadNotes(), // Carrega as notas ao iniciar
  );
}
