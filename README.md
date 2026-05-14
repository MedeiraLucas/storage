# LocalVault

Aluno: Lucas Medeira

## Descrição do App

O LocalVault é um aplicativo Flutter desenvolvido para demonstrar diferentes formas de armazenamento local de dados. O projeto utiliza SharedPreferences para configurações, Hive para armazenamento de perfil do usuário e flutter_secure_storage para armazenamento seguro de token.

---

## Por que foi escolhido SharedPreferences para configurações?

O SharedPreferences foi utilizado porque é simples e eficiente para armazenar dados pequenos e leves, como configurações do aplicativo. Nesse projeto ele foi utilizado para salvar:

- Tema escuro/claro
- Idioma
- Notificações

Esses dados permanecem salvos mesmo após fechar o aplicativo.

---

## Por que foi escolhido Hive para o perfil do usuário?

O Hive foi escolhido porque possui ótima performance e permite salvar objetos diretamente no armazenamento local. Ele facilita o gerenciamento de dados mais estruturados.

No projeto foi utilizado para armazenar:

- Nome
- Email
- Data de cadastro
- Pontuação

Também foi implementado o TypeAdapter utilizando @HiveType e @HiveField.

---

## Por que foi escolhido flutter_secure_storage para o token?

O flutter_secure_storage foi utilizado porque oferece armazenamento seguro e criptografado para dados sensíveis.

Nesse projeto ele foi utilizado para salvar um token fictício de autenticação, garantindo maior segurança dos dados armazenados localmente.

---