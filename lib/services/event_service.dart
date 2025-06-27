import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kanektme/config/firebase_constants.dart';
import '../models/event_details.dart';

class EventService with ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<EventDetails> _events = [];
  String? _errorMsg;
  bool _loading = false;

  String? get errorMessage => _errorMsg;
  List<EventDetails> get events => _events;
  bool get isLoading => _loading;



  Future<void> addEvent(EventDetails event) async {
    _loading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      await _db.collection(FirebaseConstants.event).add(event.toJson());
      await fetchItems();
    } on FirebaseException catch (e) {
      _errorMsg = e.message;
    } catch (e) {
      _errorMsg = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchItems() async {

    _loading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      final querySnapshot = await _db.collection(FirebaseConstants.event).get();
      _events = querySnapshot.docs
          .map((doc) => EventDetails.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      _errorMsg = e.message;
    } catch (e) {
      _errorMsg = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
