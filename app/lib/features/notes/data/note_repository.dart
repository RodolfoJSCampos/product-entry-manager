import '../../../models/note_model.dart';
import '../../../core/services/firestore_service.dart';

class NoteRepository {
  final FirestoreService _firestoreService;
  final String _collectionPath = 'notes';

  NoteRepository(this._firestoreService);

  Future<void> addNote(NoteModel note) async {
    await _firestoreService.setDocument(
      collectionPath: _collectionPath,
      docId: note.key,
      data: note.toMap(),
    );
  }

  Future<NoteModel?> getNote(String key) async {
    final data = await _firestoreService.getDocument(
      collectionPath: _collectionPath,
      docId: key,
    );
    return data != null ? NoteModel.fromMap(data) : null;
  }

  Future<void> updateNote(NoteModel note) async {
    await _firestoreService.updateDocument(
      collectionPath: _collectionPath,
      docId: note.key,
      data: note.toMap(),
    );
  }

  Future<void> deleteNote(String key) async {
    await _firestoreService.deleteDocument(
      collectionPath: _collectionPath,
      docId: key,
    );
  }

  Future<List<NoteModel>> getAllNotes() async {
    final dataList = await _firestoreService.getCollection(
      collectionPath: _collectionPath,
      queryBuilder: (query) => query.orderBy('date', descending: true),
    );
    return dataList.map(NoteModel.fromMap).toList();
  }
}
