import 'package:crm_android/services/auth.services.dart';

class AuthRepo {
  final AuthServices authServices;

  // Constructor with dependency injection for testing or flexibility
  AuthRepo({required this.authServices});

  Future<bool> login({required String userId, required String password}) async {
    return await authServices.login(userId: userId, password: password);
  }
}
