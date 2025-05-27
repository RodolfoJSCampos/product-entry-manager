import '../data/note_repository.dart';
import '../../../../models/note_model.dart';

class UpdateNote {
  final NoteRepository repository;

  UpdateNote(this.repository);

  Future<void> call(NoteModel note) async {
    await repository.updateNote(note);
  }
}
