import 'package:flutter/material.dart';
import '../models/faction.dart';
import '../widgets/faction_selector.dart';

class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({super.key});

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  Faction? _selectedFaction;

  FactionData? get _currentFaction => _selectedFaction == null
      ? null
      : factions.firstWhere((f) => f.faction == _selectedFaction);

  void _onFactionSelected(Faction faction) {
    setState(() => _selectedFaction = faction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SHADOWNET // PERFIL DE AGENTE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            letterSpacing: 3,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    key: ValueKey(_currentFaction?.faction),
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white24,
                        width: 2,
                      ),
                      color: Colors.white.withOpacity(0.05),
                    ),
                    child: _currentFaction == null
                        ? const Icon(
                            Icons.question_mark,
                            color: Colors.white24,
                            size: 48,
                          )
                        : ClipOval(
                            child: Image.asset(
                              _currentFaction!.imagePath,
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Selector de facción
              FactionSelector(
                selectedFaction: _selectedFaction,
                onFactionSelected: _onFactionSelected,
              ),

              const SizedBox(height: 24),

              if (_currentFaction != null) ...[
                const Divider(color: Colors.white12),
                const SizedBox(height: 16),
                Text(
                  _currentFaction!.displayName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _currentFaction!.description,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ] else ...[
                const Center(
                  child: Text(
                    '> Selecciona tu facción para continuar_',
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 13,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}