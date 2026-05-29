import 'package:flutter/material.dart';
import 'screens/agent_profile_screen.dart';
import 'theme/app_theme.dart'; 

class ShadowNetApp extends StatefulWidget {
  const ShadowNetApp({super.key});

  @override
  State<ShadowNetApp> createState() => _ShadowNetAppState();
}

class _ShadowNetAppState extends State<ShadowNetApp> {
  Color _seedColor = const Color(0xFF00FF41);

  void _onSeedColorChanged(Color color) {
    setState(() => _seedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadowNet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(_seedColor), 
      home: AgentProfileScreen(
        onSeedColorChanged: _onSeedColorChanged,
      ),
    );
  }
}