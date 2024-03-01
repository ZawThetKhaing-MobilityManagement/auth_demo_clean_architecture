import 'package:demo_login_ui/features/login/presentation/pages/material_page.dart';
import 'package:demo_login_ui/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialScreen();
  }
}
