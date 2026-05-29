import 'package:flutter/material.dart';
import '../models/faction.dart';
import '../widgets/faction_selector.dart';

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

  void _resetSession() {
    setState(() {
      _selectedFaction = null;
      _backgroundColor = const Color(0xFF0A0A0F);
    });
    widget.onSeedColorChanged(const Color(0xFF00FF41));
  }

  void _handleLogout() {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0D0D14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: colorScheme.primary.withOpacity(0.4),
            width: 1,
          ),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: colorScheme.primary, size: 18),
            const SizedBox(width: 8),
            Text(
              '¡ALERTA DE SEGURIDAD!',
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 13,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Esta acción borrará tu rastro operativo y finalizará la misión activa.\n\nConfirmas si quieres salir y abortar la misión:(',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 13,
            height: 1.6,
          ),
        ),
        actions: [
          // Botón cancelar
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white38,
            ),
            child: const Text(
              '[ ABORTAR ]',
              style: TextStyle(letterSpacing: 1.5, fontSize: 12),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _resetSession();
            },
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.primary,
            ),
            child: const Text(
              '[ CONFIRMAR SALIDA ]',
              style: TextStyle(
                letterSpacing: 1.5,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
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
          // Título con semántica de encabezado
          title: Semantics(
            header: true,
            label: 'ShadowNet, pantalla de perfil de agente',
            child: const Text(
              'SHADOWNET // PERFIL DE AGENTE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                letterSpacing: 3,
              ),
            ),
          ),
          actions: [
            Semantics(
              button: true,
              label: 'Botón: Finalizar misión y borrar rastro',
              hint: 'Cierra la sesión y resetea el perfil del agente',
              excludeSemantics: true,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton.icon(
                  onPressed: _handleLogout,
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary.withOpacity(0.7),
                    side: BorderSide(
                      color: colorScheme.primary.withOpacity(0.3),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                  ),
                  icon: const Icon(Icons.power_settings_new, size: 14),
                  label: const Text(
                    'SALIR',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

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

                  Semantics(
                    label:
                        'Descripción de la facción: ${_currentFaction!.description}',
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

                  Semantics(
                    liveRegion: true,
                    label: 'Instrucción: selecciona una facción para continuar',
                    child: const Center(
                      child: Text(
                        '> Selecciona tu facción para continuar =)',
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