import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  bool loading = false;
  List<UserModel> users = [];
  String? error;

  final UserService _service = UserService();

  Future<void> getUsers() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final response = await _service.fetchUsers();
      users = response.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
