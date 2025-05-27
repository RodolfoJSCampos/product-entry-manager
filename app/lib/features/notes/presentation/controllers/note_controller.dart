// lib/features/notes/presentation/controllers/note_controller.dart
import 'package:flutter/material.dart';
import '../../../../models/note_model.dart';
import '../../domain/add_note.dart';
import '../../domain/get_all_notes.dart';
import '../../domain/delete_note.dart';
import '../../domain/update_note.dart';

class NoteController extends ChangeNotifier {
  final AddNote _addNote;
  final GetAllNotes _getAllNotes;
  final DeleteNote _deleteNote;
  final UpdateNote _updateNote;

  List<NoteModel> _notes = [];
  bool _isLoading = false;
  String? _error;

  NoteController({
    required AddNote addNote,
    required GetAllNotes getAllNotes,
    required DeleteNote deleteNote,
    required UpdateNote updateNote,
  })  : _addNote = addNote,
        _getAllNotes = getAllNotes,
        _deleteNote = deleteNote,
        _updateNote = updateNote;

  List<NoteModel> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notes = await _getAllNotes();
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar notas: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> add(NoteModel note) async {
    try {
      await _addNote(note);
      await loadNotes();
    } catch (e) {
      _error = 'Erro ao adicionar nota: $e';
      notifyListeners();
    }
  }

  Future<void> update(NoteModel note) async {
    try {
      await _updateNote(note);
      await loadNotes();
    } catch (e) {
      _error = 'Erro ao atualizar nota: $e';
      notifyListeners();
    }
  }

  Future<void> delete(String key) async {
    try {
      await _deleteNote(key);
      await loadNotes();
    } catch (e) {
      _error = 'Erro ao excluir nota: $e';
      notifyListeners();
    }
  }
}
