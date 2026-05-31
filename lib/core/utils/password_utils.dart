import 'dart:convert';

import 'package:crypto/crypto.dart';

String hashPassword(String password, String salt) {
  final bytes = utf8.encode('$password$salt');
  return sha256.convert(bytes).toString();
}

bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}
