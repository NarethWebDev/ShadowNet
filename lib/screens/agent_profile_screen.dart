// ============================================================
// PUNTO 1 — Pantalla principal del perfil de agente
// Aquí se orquesta todo. Cada compañero encontrará su sección
// claramente marcada con comentarios.
// ============================================================

import 'package:flutter/material.dart';
import '../models/faction.dart';
import '../widgets/faction_selector.dart';

class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({super.key});

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  // PUNTO 1: estado de la facción seleccionada
  Faction? _selectedFaction;

  FactionData? get _currentFaction => _selectedFaction == null
      ? null
      : factions.firstWhere((f) => f.faction == _selectedFaction);

  void _onFactionSelected(Faction faction) {
    setState(() => _selectedFaction = faction);
    // PUNTO 2 (M3): aquí tu compañero deberá disparar
    // el cambio de ColorScheme usando el seedColorHex
    // del _currentFaction seleccionado.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F), // fondo base oscuro
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SHADOWNET // PERFIL DE AGENTE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            letterSpacing: 3,
            // PUNTO 4: tu compañero aplicará Google Fonts aquí
          ),
        ),
        // PUNTO 3 (Semantics): tu compañero agregará el botón
        // "Cerrar Sesión" con Semantics(label: 'Botón: Finalizar misión y borrar rastro')
        actions: const [
          // ==== PLACEHOLDER para el compañero del PUNTO 3 ====
          // Semantics(
          //   label: 'Botón: Finalizar misión y borrar rastro',
          //   child: IconButton(
          //     icon: const Icon(Icons.logout),
          //     onPressed: () {},
          //   ),
          // ),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── PUNTO 2: Imagen central de la facción ──────────
              _FactionImage(factionData: _currentFaction),
              const SizedBox(height: 32),

              // ── PUNTO 1: Selector de facción ───────────────────
              FactionSelector(
                selectedFaction: _selectedFaction,
                onFactionSelected: _onFactionSelected,
              ),
              const SizedBox(height: 24),

              // ── Info de la facción seleccionada ────────────────
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
                    // PUNTO 4: Google Fonts aquí
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

// Widget para la imagen central (PUNTO 2 la animará con M3)
class _FactionImage extends StatelessWidget {
  final FactionData? factionData;
  const _FactionImage({this.factionData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Container(
          key: ValueKey(factionData?.faction),
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
          child: factionData == null
              ? const Icon(Icons.question_mark,
                  color: Colors.white24, size: 48)
              : const Icon(
                  // PUNTO 2: reemplazar con Image.asset(factionData!.imagePath)
                  Icons.face,
                  color: Colors.white54,
                  size: 64,
                ),
        ),
      ),
    );
  }
}