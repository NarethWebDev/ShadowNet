// ============================================================
// PUNTO 1 — Widget Selector de Facción
// Muestra los 3 botones de facción.
// El compañero del PUNTO 2 (M3) conectará selectedFaction
// al ColorScheme dinámico desde aquí.
// ============================================================

import 'package:flutter/material.dart';
import '../models/faction.dart';

class FactionSelector extends StatelessWidget {
  final Faction? selectedFaction;
  final ValueChanged<Faction> onFactionSelected;

  const FactionSelector({
    super.key,
    required this.selectedFaction,
    required this.onFactionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '// SELECCIONA TU FACCIÓN',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: factions.map((factionData) {
            final isSelected = selectedFaction == factionData.faction;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                // PUNTO 3 (Semantics): tu compañero envolverá esto
                // con Semantics(label: 'Seleccionar facción ${factionData.displayName}')
                child: _FactionButton(
                  factionData: factionData,
                  isSelected: isSelected,
                  onTap: () => onFactionSelected(factionData.faction),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _FactionButton extends StatelessWidget {
  final FactionData factionData;
  final bool isSelected;
  final VoidCallback onTap;

  const _FactionButton({
    required this.factionData,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.white : Colors.white24,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected
            ? Colors.white.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            child: Column(
              children: [
                // Ícono placeholder — tu compañero del PUNTO 2
                // reemplazará esto con Image.asset(factionData.imagePath)
                Icon(
                  _iconForFaction(factionData.faction),
                  color: isSelected ? Colors.white : Colors.white54,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  factionData.displayName.toUpperCase(),
                  style: TextStyle(
                    // PUNTO 4 (Tipografía): tu compañero cambiará
                    // fontFamily aquí a JetBrains Mono o Urbanist
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: isSelected ? Colors.white : Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconForFaction(Faction faction) {
    switch (faction) {
      case Faction.hacker:
        return Icons.terminal;
      case Faction.enforcer:
        return Icons.shield;
      case Faction.ghost:
        return Icons.visibility_off;
    }
  }
}