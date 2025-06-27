import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _myUser;
  String? _errorMsg;
  bool _loading = false;

  User? get user => _myUser;
  String? get errorMessage => _errorMsg;
  bool get isLoading => _loading;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _myUser = user;
      _errorMsg = null;
      notifyListeners();
    });
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    _loading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _errorMsg = null;
    } on FirebaseAuthException catch (e) {
      _errorMsg = e.message;
    } catch (e) {
      _errorMsg = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    _loading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _errorMsg = null;
    } on FirebaseAuthException catch (e) {
      _errorMsg = e.toString();
    } catch (e) {
      _errorMsg = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _errorMsg = null;
    notifyListeners();
  }
}