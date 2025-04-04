import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:veggies/core/errors/failures.dart';
import 'package:veggies/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  );
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerFailure();
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return UserModel.fromFirebaseUser(_firebaseAuth.currentUser!);
  }

  @override
  Future<void> signOut() {
    _firebaseAuth.signOut();
    return Future.value();
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    final fbUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(fbUser.user!);
  }

  // Implement other methods
}

class ThridAuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerFailure();
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return UserModel.fromFirebaseUser(_firebaseAuth.currentUser!);
  }

  @override
  Future<void> signOut() {
    _firebaseAuth.signOut();
    return Future.value();
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    final fbUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(fbUser.user!);
  }

  // Implement other methods
}
