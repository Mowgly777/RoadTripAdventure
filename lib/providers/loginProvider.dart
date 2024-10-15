import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:road_trip_adventure/providers/storageProvider.dart';

class Token {
  final String token;

  const Token({
    required this.token
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'token': String token} => Token(token: token),
      _ => throw const FormatException('Failed to load Token.'),
    };
  }
}

Future<bool> loginReq(String name, String password) async {

  final response = await http.post(
    Uri.parse('A website'),
    body: {
      'username': name,
      'password': password,
    }
  );

  if (response.statusCode == 200) {

    Token token = Token.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    await StorageProvider.add(key: StorageKeys.auth_token, value: token.token);
    return true;
  } else {
    throw Exception('failure');
  }
}

Future logoutReq() async {

  //TODO: django logout
  return await StorageProvider.delete(key: StorageKeys.auth_token);
}

Future<bool> isLoggedIn() async {
  return await StorageProvider.exists(key: StorageKeys.auth_token);
}