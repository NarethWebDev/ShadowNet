import 'package:flutter/material.dart';
import 'screens/agent_profile_screen.dart';

class ShadowNetApp extends StatelessWidget {
  const ShadowNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadowNet',
      debugShowCheckedModeBanner: false,
      // PUNTO 2 (M3): tu compañero reemplazará este theme
      // con un ColorScheme.fromSeed() dinámico según la facción
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AgentProfileScreen(),
    );
  }
}