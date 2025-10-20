import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pmdm_ra02/models/user.dart';

final _server = 'https://jsonplaceholder.typicode.com';

Uri _uri(String s) => Uri.parse('$_server/$s');

Map<String, String> _headers = {HttpHeaders.acceptHeader: 'application/json'};

class ApiResult<T> {
  final T? data;
  final int? statusCode;
  final String? error;

  ApiResult({this.data, this.statusCode, this.error});

  bool get hasError => error != null;
}

Future<ApiResult<User?>> getUser(int id) async {
  http.Response res = await http.get(_uri('users/$id'), headers: _headers);

  if (res.statusCode == 200) {
    User user = User.fromJson(jsonDecode(res.body));
    return ApiResult(data: user, statusCode: res.statusCode);
  } else {
    return ApiResult(statusCode: res.statusCode, error: res.reasonPhrase ?? 'Error HTTP: ${res.statusCode}');
  }
}

Future<ApiResult<List<User>?>> getUsers() async {
  try {
    http.Response res = await http.get(_uri('users'), headers: _headers);

    if (res.statusCode == 200) {
      List<dynamic> list = jsonDecode(res.body);
      List<User> users = list.map((user) => User.fromJson(user)).toList();
      return ApiResult(data: users, statusCode: res.statusCode);
    } else {
      return ApiResult(statusCode: res.statusCode, error: res.reasonPhrase ?? 'Error HTTP: ${res.statusCode}');
    }
  } catch (e) {
    return ApiResult(error: "Error: $e");
  }
}

User _getUserFromUser(User user, http.Response res) {

  final userRes = User.fromJson(jsonDecode(res.body));
  user.id = userRes.id;
  return user;
}

Future<ApiResult<User?>> postUser(User user) async {
  try {
    final body = jsonEncode(user.toJson());

    final res = await http.post(_uri('users'), headers: _headers, body: body);

    if (res.statusCode == 201) {
      return ApiResult(data: _getUserFromUser(user, res), statusCode: res.statusCode);
    } else {
      return ApiResult(statusCode: res.statusCode, error: res.reasonPhrase ?? 'Error HTTP: ${res.statusCode}');
    }
  } catch (e) {
    return ApiResult(error: "Error: $e");
  }
}

Future<ApiResult<User?>> putUser(User user) async {
  try {
    final body = jsonEncode(user.toJson());

    final res = await http.put(_uri('users/${user.id}'), headers: _headers, body: body);

    if (res.statusCode == 200) {

      final userRes = User.fromJson(jsonDecode(res.body));
      user.id = userRes.id;
      return ApiResult(data: _getUserFromUser(user, res), statusCode: res.statusCode);
    } else {
      return ApiResult(statusCode: res.statusCode, error: res.reasonPhrase ?? 'Error HTTP: ${res.statusCode}');
    }
  } catch (e) {
    return ApiResult(error: "Error: $e");
  }
}

Future<ApiResult<User?>> patchUser(User user) async {
  try {
    final body = jsonEncode(user.toJson());

    final res = await http.patch(_uri('users/${user.id}'), headers: _headers, body: body);

    if (res.statusCode == 200) {

      final userRes = User.fromJson(jsonDecode(res.body));
      user.id = userRes.id;
      return ApiResult(data: _getUserFromUser(user, res), statusCode: res.statusCode);
    } else {
      return ApiResult(statusCode: res.statusCode, error: res.reasonPhrase ?? 'Error HTTP: ${res.statusCode}');
    }
  } catch (e) {
    return ApiResult(error: "Error: $e");
  }
}

Future<ApiResult<void>> deleteUser(int id) async {
  try {
    final res = await http.delete(_uri('users/$id'), headers: _headers);

    if (res.statusCode == 200) {
      return ApiResult(statusCode: res.statusCode);
    } else {
      return ApiResult(statusCode: res.statusCode, error: res.reasonPhrase ?? 'Error HTTP: ${res.statusCode}');
    }
  } catch (e) {
    return ApiResult(error: "Error: $e");
  }
}
