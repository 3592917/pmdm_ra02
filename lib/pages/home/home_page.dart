import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdm_ra02/api/api.dart';
import 'package:pmdm_ra02/models/user.dart';
import '../../api/api.dart' as api;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void log(Object? object) {
    if (kDebugMode) {
      print("Salida consola: $object");
    }
  }

  Future<void> _getOneUser() async {
    try {
      ApiResult<User?> response = await api.getUser(1);
      if (response.hasError) {
        log('Error: (${response.statusCode}) ${response.error}');
      } else {
        User? user = response.data;
        log(user);
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _getAllUsers() async {
    try {
      ApiResult<List<User>?> response = await api.getUsers();
      if (response.hasError) {
        log('Error: ${response.statusCode} - ${response.error}');
      } else {
        List<User>? users = response.data;
        users?.forEach((user) {
          log(user);
        });
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _createUser() async {}

  Future<void> _updateUser() async {}

  Future<void> _deleteUser() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: _getOneUser,
                      child: Text('Obtener usuario'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: _getAllUsers,
                      child: Text('Obtener todos los usuarios'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: _createUser,
                      child: Text('Crear un nuevo usuario'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: _updateUser,
                      child: Text('Modificar usuario'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: _deleteUser,
                      child: Text('Borrar usuario'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
