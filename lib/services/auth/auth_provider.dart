import 'package:fluttynotes/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  // authUser is from auth_user.dart
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
