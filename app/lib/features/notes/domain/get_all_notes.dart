import '../data/note_repository.dart';
import '../../../../models/note_model.dart';

class GetAllNotes {
  final NoteRepository repository;

  GetAllNotes(this.repository);

  Future<List<NoteModel>> call() async {
    return repository.getAllNotes();
  }
}
