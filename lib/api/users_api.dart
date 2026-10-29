import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:futurebuilder_example/model/user.dart';

class UsersApi {
  // Load JSON bundled with the Flutter application.
  static Future<List<User>> getUsersLocally() async {
    final String data = await rootBundle.loadString(
      'assets/users.json',
    );

    return _parseUsers(data);
  }

  // Load JSON from a remote server (or web host / local asset fallback for mobile emulator).
  static Future<List<User>> getUsers() async {
    final uri = Uri.parse(
      'assets/users.json',
    );

    // On web or when an absolute HTTP/HTTPS URL is provided, use http client.
    if (kIsWeb || (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'))) {
      try {
        final response = await http.get(uri).timeout(const Duration(seconds: 15));

        if (response.statusCode == 200) {
          return _parseUsers(response.body);
        }
      } catch (_) {
        // Fallback to local asset if network request fails
      }
    }

    // On mobile platforms (like Android emulator) where relative URIs cannot be resolved by http client
    final String data = await rootBundle.loadString('assets/users.json');
    return _parseUsers(data);
  }


  // Convert JSON text into a list of User objects.
  static List<User> _parseUsers(String data) {
    final dynamic decoded = jsonDecode(data);

    if (decoded is! List) {
      throw const FormatException(
        'Invalid JSON format. Expected a list of users.',
      );
    }

    return decoded.map<User>((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException(
          'Invalid user object in JSON data.',
        );
      }

      return User.fromJson(item);
    }).toList();
  }
}
