import '../data/note_repository.dart';

class DeleteNote {
  final NoteRepository repository;

  DeleteNote(this.repository);

  Future<void> call(String key) async {
    await repository.deleteNote(key);
  }
}
