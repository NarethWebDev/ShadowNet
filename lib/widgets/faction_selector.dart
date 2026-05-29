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
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      // Anuncia al lector de pantalla que este bloque es un selector de rol
      label: 'Selector de facción. Elige tu identidad operativa.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// SELECCIONA TU FACCIÓN',
            style: TextStyle(
              color: colorScheme.primary.withOpacity(0.6),
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
      ),
    );
  }
}

/// Botón individual de facción con semántica completa.
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
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      // El lector anuncia: nombre, estado actual, y descripción de la facción
      label:
          'Botón: Seleccionar facción ${factionData.displayName}. ${factionData.description}',
      hint: isSelected
          ? 'Facción actualmente seleccionada'
          : 'Activa esta facción para cambiar el tema visual',
      // Excluye los hijos para que no se repita la info
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? colorScheme.primaryContainer.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            splashColor: colorScheme.primary.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Column(
                children: [
                  Icon(
                    _iconForFaction(factionData.faction),
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withOpacity(0.4),
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    factionData.displayName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Devuelve el ícono correspondiente a cada facción.
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