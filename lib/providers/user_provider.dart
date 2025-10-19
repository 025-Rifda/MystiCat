import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProvider extends ChangeNotifier {
  final Box _userBox;
  late String _username;

  String get username => _username;

  UserProvider(this._userBox) {
    _username = _userBox.get('username', defaultValue: 'User');
  }

  Future<void> setUsername(String newUsername) async {
    _username = newUsername;
    await _userBox.put('username', newUsername);
    notifyListeners();
  }
}
