import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<void> salvarTema(bool valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tema', valor);
  }

  Future<bool> carregarTema() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tema') ?? false;
  }

  Future<void> salvarIdioma(String idioma) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', idioma);
  }

  Future<String> carregarIdioma() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('idioma') ?? 'Português';
  }

  Future<void> salvarNotificacao(bool valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificacao', valor);
  }

  Future<bool> carregarNotificacao() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notificacao') ?? true;
  }
}
