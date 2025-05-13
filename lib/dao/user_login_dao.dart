import 'dart:convert';
import 'dart:io';

import 'package:collection_backend/infra/failures/dao_failure.dart';

import '../models/user_login_model.dart';
import '../infra/failures/i_failures.dart';
import 'package:http/http.dart' as http;

class UserLoginDao {
  UserLoginDao();

  final url = Uri.parse(
      'https://${Platform.environment['PROJECT_REF']}.supabase.co/auth/v1');

  final headers = {
    'apikey': '${Platform.environment['ANON_KEY']}',
    'content-type': 'application/json',
    // 'Accept': 'application/json',
  };

  Future<(UserLoginModel, IFailure)> register(UserLoginModel user) async {
    final registerUrl = Uri.parse('$url/signup');
    final response = await http.post(
      registerUrl,
      headers: headers,
      body: jsonEncode({
        'email': user.login,
        'password': user.password,
      }),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      user.accessToken = body['access_token'];
    } else {
      print(response.body);
      return (user, DaoFailure(message: 'Dao - Cannot register'));
    }
    return (user, Empty());
  }

  Future<(UserLoginModel, IFailure)> login(UserLoginModel user) async {
    final loginUrl = Uri.parse('$url/token?grant_type=password');
    final response = await http.post(
      loginUrl,
      headers: headers,
      body: jsonEncode({
        'email': user.login,
        'password': user.password,
      }),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      user.accessToken = body['access_token'];
    } else {
      return (user, DaoFailure(message: 'Dao - Login error'));
    }
    return (user, Empty());
  }

  Future<IFailure> logout(String accessToken) async {
    headers.addEntries({
      'Authorization': 'Bearer $accessToken',
    }.entries);

    final loginUrl = Uri.parse('$url/logout');
    final response = await http.post(
      loginUrl,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> notes = jsonDecode(response.body);
      for (final note in notes) {
        print(note);
      }
    } else {
      print(response.body);
    }
    return Empty();
  }
}
