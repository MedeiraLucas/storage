import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user_profile.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserProfileAdapter());
  await Hive.openBox<UserProfile>('profileBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LocalVault',
      home: const HomeScreen(),
    );
  }
}
