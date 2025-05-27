import '../data/note_repository.dart';
import '../../../../models/note_model.dart';

class GetNote {
  final NoteRepository repository;

  GetNote(this.repository);

  Future<NoteModel?> call(String key) async {
    return repository.getNote(key);
  }
}
