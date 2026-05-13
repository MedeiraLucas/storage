# LocalVault

Aluno: Lucas Medeira

## Descrição
Aplicativo Flutter utilizando SharedPreferences, Hive e flutter_secure_storage para armazenamento local.

## SharedPreferences
Foi utilizado para salvar configurações simples como tema, idioma e notificações.

## Hive
Foi utilizado para salvar o perfil do usuário porque possui boa performance e trabalha com objetos.

## flutter_secure_storage
Foi utilizado para salvar o token porque os dados ficam protegidos e criptografados.

## Como rodar

```bash
flutter pub get
flutter packages pub run build_runner build
flutter run
```

## Estrutura
- Configurações com SharedPreferences
- Perfil com Hive
- Token com flutter_secure_storage
- Migração simples de dados

## LGPD
O aplicativo armazena nome, email, configurações e token fictício.
O usuário pode excluir os dados através do botão de limpar perfil e deletar token.
