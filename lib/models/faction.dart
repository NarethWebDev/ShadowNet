enum Faction { hacker, enforcer, ghost }

class FactionData {
  final Faction faction;
  final String displayName;
  final String description;
  final String imagePath;
  final String seedColorHex; 

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
    seedColorHex: '#00FF41', 
  ),
  FactionData(
    faction: Faction.enforcer,
    displayName: 'Enforcer',
    description: 'Ejecuta órdenes. La fuerza es la ley.',
    imagePath: 'assets/images/enforcer.png',
    seedColorHex: '#FF4500', 
  ),
  FactionData(
    faction: Faction.ghost,
    displayName: 'Ghost',
    description: 'Desaparece en las sombras. Nadie te vio.',
    imagePath: 'assets/images/ghost.png',
    seedColorHex: '#8A2BE2', 
  ),
];