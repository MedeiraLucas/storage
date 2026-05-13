import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> salvarToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> recuperarToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> deletarToken() async {
    await storage.delete(key: 'token');
  }
}
