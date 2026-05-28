import 'package:flutter/material.dart';
import 'screens/agent_profile_screen.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,             
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: AgentProfileScreen(
        onSeedColorChanged: _onSeedColorChanged, 
      ),
    );
  }
}