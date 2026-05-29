import 'package:flutter/material.dart';
import '../models/faction.dart';
import '../widgets/faction_selector.dart';

/// Pantalla principal de perfil del agente ShadowNet.
class AgentProfileScreen extends StatefulWidget {
  final ValueChanged<Color> onSeedColorChanged;

  const AgentProfileScreen({
    super.key,
    required this.onSeedColorChanged,
  });

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  Faction? _selectedFaction;
  Color _backgroundColor = const Color(0xFF0A0A0F);

  FactionData? get _currentFaction => _selectedFaction == null
      ? null
      : factions.firstWhere((f) => f.faction == _selectedFaction);

  /// Maneja la selección de facción y actualiza el color de fondo y el tema.
  void _onFactionSelected(Faction faction) {
    final data = factions.firstWhere((f) => f.faction == faction);

    setState(() {
      _selectedFaction = faction;
      _backgroundColor = Color.lerp(
        const Color(0xFF0A0A0F),
        data.seedColor,
        0.15,
      )!;
    });

    widget.onSeedColorChanged(data.seedColor);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      color: _backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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

                // Imagen del agente con semántica para lector de pantalla
                Center(
                  child: Semantics(
                    image: true,
                    label: _currentFaction == null
                        ? 'Imagen de perfil: ninguna facción seleccionada'
                        : 'Logo de la facción ${_currentFaction!.displayName}: ${_currentFaction!.description}',
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        key: ValueKey(_currentFaction?.faction),
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _currentFaction != null
                                ? colorScheme.primary.withOpacity(0.6)
                                : Colors.white24,
                            width: 2,
                          ),
                          color: _currentFaction != null
                              ? colorScheme.primaryContainer.withOpacity(0.1)
                              : Colors.white.withOpacity(0.05),
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
                ),

                const SizedBox(height: 32),

                FactionSelector(
                  selectedFaction: _selectedFaction,
                  onFactionSelected: _onFactionSelected,
                ),

                const SizedBox(height: 24),

                if (_currentFaction != null) ...[
                  Divider(color: colorScheme.primary.withOpacity(0.3)),
                  const SizedBox(height: 16),

                  // Nombre de la facción con semántica
                  Semantics(
                    label: 'Nombre de facción: ${_currentFaction!.displayName}',
                    child: Text(
                      _currentFaction!.displayName.toUpperCase(),
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Descripción de la facción con semántica
                  Semantics(
                    label: 'Descripción de la facción: ${_currentFaction!.description}',
                    child: Text(
                      _currentFaction!.description,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ] else ...[

                  // Instrucción inicial con semántica en tiempo real
                  Semantics(
                    liveRegion: true,
                    label: 'Instrucción: selecciona una facción para continuar',
                    child: const Center(
                      child: Text(
                        '> Selecciona tu facción para continuar_',
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: 13,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}