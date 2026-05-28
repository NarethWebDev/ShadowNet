// ============================================================
// PUNTO 1 — Modelo de Facción
// Este archivo define las 3 facciones disponibles.
// Los compañeros que trabajen M3 y tipografía usan este enum.
// ============================================================

enum Faction { hacker, enforcer, ghost }

class FactionData {
  final Faction faction;
  final String displayName;
  final String description;
  final String imagePath;
  final String seedColorHex; // PUNTO 2 (M3): tu compañero leerá esto

  const FactionData({
    required this.faction,
    required this.displayName,
    required this.description,
    required this.imagePath,
    required this.seedColorHex,
  });
}

// Catálogo completo de facciones
const List<FactionData> factions = [
  FactionData(
    faction: Faction.hacker,
    displayName: 'Hacker',
    description: 'Infiltra sistemas. El conocimiento es poder.',
    imagePath: 'assets/images/hacker.png',
    seedColorHex: '#00FF41', // verde terminal
  ),
  FactionData(
    faction: Faction.enforcer,
    displayName: 'Enforcer',
    description: 'Ejecuta órdenes. La fuerza es la ley.',
    imagePath: 'assets/images/enforcer.png',
    seedColorHex: '#FF4500', // rojo sangre
  ),
  FactionData(
    faction: Faction.ghost,
    displayName: 'Ghost',
    description: 'Desaparece en las sombras. Nadie te vio.',
    imagePath: 'assets/images/ghost.png',
    seedColorHex: '#8A2BE2', // violeta oscuro
  ),
];