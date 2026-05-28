import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = false;
  String? _errorMessage;

  User? _user;
  UserModel? _userProfile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _user;
  UserModel? get userProfile => _userProfile;

  AuthViewModel() {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authService.authStateChanges.listen((User? firebaseUser) async {
      _user = firebaseUser;

      if (firebaseUser != null) {
        await _fetchUserProfile();
      } else {
        _userProfile = null;
      }

      notifyListeners();
    });
  }

  Future<void> _fetchUserProfile() async {
    try {
      _userProfile = await _firestoreService.getUserProfile();
    } catch (e) {
      debugPrint("Fetch profile error: $e");
    }

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// ================= LOGIN =================
  Future<String?> signIn(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final result =
          await _authService.signInWithEmailAndPassword(email, password);

      if (result == null || result.user == null) {
        _errorMessage = "Login failed. Please try again.";
        return _errorMessage;
      }

      _user = result.user;
      await _fetchUserProfile();

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          _errorMessage = "Invalid email or password.";
          break;

        case 'invalid-email':
          _errorMessage = "Invalid email format.";
          break;

        case 'user-disabled':
          _errorMessage = "This account has been disabled.";
          break;

        default:
          _errorMessage = e.message ?? "Login failed.";
      }

      return _errorMessage;
    } catch (e) {
      _errorMessage = "Something went wrong.";
      return _errorMessage;
    } finally {
      _setLoading(false);
    }
  }

  /// ================= SIGNUP =================
  Future<String?> signUp(String name, String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final result = await _authService
          .signUpWithEmailAndPassword(email, password, name);

      if (result == null || result.user == null) {
        _errorMessage = "Signup failed.";
        return _errorMessage;
      }

      _user = result.user;

      final newUser = UserModel(
        id: result.user!.uid,
        name: name,
        email: email,
      );

      await _firestoreService.updateUserProfile(newUser);

      _userProfile = newUser;

      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          _errorMessage = "Email already in use.";
          break;

        case 'weak-password':
          _errorMessage = "Password is too weak.";
          break;

        case 'invalid-email':
          _errorMessage = "Invalid email format.";
          break;

        default:
          _errorMessage = e.message ?? "Signup failed.";
      }

      return _errorMessage;
    } catch (e) {
      _errorMessage = "Something went wrong.";
      return _errorMessage;
    } finally {
      _setLoading(false);
    }
  }

  /// ================= UPDATE PROFILE =================
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String location,
    required String imageUrl,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final updatedUser = UserModel(
        id: _user?.uid ?? _userProfile?.id ?? "",
        name: name,
        email: _user?.email ?? _userProfile?.email ?? "",
        phone: phone,
        location: location,
        image: imageUrl.isNotEmpty
            ? imageUrl
            : (_userProfile?.image ?? ""),
      );

      await _firestoreService.updateUserProfile(updatedUser);

      _userProfile = updatedUser;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Profile update failed.";
      debugPrint("Update profile error: $e");
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// ================= SIGN OUT =================
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      _user = null;
      _userProfile = null;
      notifyListeners();
    } catch (e) {
      debugPrint("Logout error: $e");
    }
  }
}