import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sdfe_task_manager_app/models/user.dart' as UserModel;
ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FlutterSecureStorage storage = FlutterSecureStorage();
  User? get currentUser => firebaseAuth.currentUser!;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword({
    required String email
  }) async {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  Future<void> updateUsername({
    required String username
  }) async {
    return currentUser!.updateDisplayName(username);
  }

  Future<void> deleteAccount({
    required String email,
    required String password
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }

  Future<void> signout() async {
    return firebaseAuth.signOut();
  }

// Metodos de Flutter Security Storage
  Future<void> setSession(UserModel.User user) async {
    await storage.write(key: 'user-${user.email}', value: jsonEncode(user.toJson()));
    return Future.value(true);
  }

  Future<UserModel.User> getSession(String identifier) async {
    final userInStorage = await storage.read(key: 'user-$identifier');
    dynamic store = jsonDecode(userInStorage.toString() ?? '{}');
    return UserModel.User.fromJson(store);
  }

}