import 'package:shared_preferences/shared_preferences.dart';

class MigrationService {
  Future<void> migrate() async {
    final prefs = await SharedPreferences.getInstance();

    int versao = prefs.getInt('data_version') ?? 1;

    if (versao == 1) {
      String? antigoNome = prefs.getString('nome_antigo');

      if (antigoNome != null) {
        await prefs.setString('novo_nome', antigoNome);
        await prefs.remove('nome_antigo');
      }

      await prefs.setInt('data_version', 2);
    }
  }
}
