#  ShadowNet — Operación Camaleón: El Perfil Dinámico

> Aplicación Flutter que muestra una **Pantalla de Perfil de Agente** cuya personalidad visual cambia dinámicamente según la facción elegida.

---

##  Equipo y responsabilidades

| Punto | Feature | Responsable |
|-------|---------|-------------|
| 1 | Selector de Facción (3 botones: Hacker, Enforcer, Ghost) | [Tu nombre] |
| 2 | Color Dinámico M3 (imagen central + tema completo por facción) | [Compañero 2] |
| 3 | Accesibilidad / Semantics (etiquetas para lectores de pantalla) | [Compañero 3] |
| 4 | Tipografía M3 con Google Fonts (JetBrains Mono / Urbanist) | [Compañero 4] |

---

##  Estructura del proyecto

```
shadownet/
├── lib/
│   ├── main.dart                        # Punto de entrada de la app
│   ├── app.dart                         # MaterialApp + ThemeData (M3)
│   ├── models/
│   │   └── faction.dart                 # Punto 1 — Enum Faction + FactionData
│   ├── screens/
│   │   └── agent_profile_screen.dart    # Punto 1 — Pantalla principal
│   ├── widgets/
│   │   └── faction_selector.dart        # Punto 1 — Botones de facción
│   └── theme/
│       └── app_theme.dart               # Punto 2 — ColorScheme dinámico M3
├── assets/
│   └── images/
│       ├── hacker.png                   # Punto 2 — Logo facción Hacker
│       ├── enforcer.png                 # Punto 2 — Logo facción Enforcer
│       └── ghost.png                    # Punto 2 — Logo facción Ghost
├── pubspec.yaml
└── README.md
```

---

## Cómo correr el proyecto

```bash
# 1. Clonar el repositorio
git clone https://github.com/<usuario>/shadownet.git
cd shadownet

# 2. Instalar dependencias
flutter pub get

# 3. Correr la app
flutter run
```

> Requiere Flutter 3.x o superior. Verificar con `flutter doctor`.

---

##  Dependencias principales

dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0       # Punto 4 — Tipografía

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

---

##  Punto 1 — Selector de Facción

### ¿Qué hace?
Renderiza **3 botones** (Hacker, Enforcer, Ghost) que permiten al usuario seleccionar su facción. Al presionar uno, el estado global de la pantalla cambia y notifica a los demás módulos (M3, Semantics, Tipografía).

### Archivos involucrados
- `lib/models/faction.dart`
- `lib/widgets/faction_selector.dart`
- `lib/screens/agent_profile_screen.dart`

### Cómo funciona
```dart
Faction? _selectedFaction;

void _onFactionSelected(Faction faction) {
  setState(() => _selectedFaction = faction);
}

FactionSelector(
  selectedFaction: _selectedFaction,
  onFactionSelected: _onFactionSelected,
)
```

### Facciones disponibles

| Facción | Ícono base | SeedColor |
|---------|-----------|-----------|
| Hacker | `Icons.terminal` | `#00FF41` (verde terminal) |
| Enforcer | `Icons.shield` | `#FF4500` (rojo sangre) |
| Ghost | `Icons.visibility_off` | `#8A2BE2` (violeta oscuro) |

---

##  Punto 2 — Color Dinámico M3

### ¿Qué hace?
Al presionar una facción, **toda la aplicación** (AppBar, botones, fondos, íconos) cambia de color usando `ColorScheme.fromSeed()` de Material 3. También reemplaza el ícono placeholder por `Image.asset()` con el logo real de la facción.

### Cómo se extrae el SeedColor
Cada `FactionData` expone un campo `seedColorHex`:

```dart
const FactionData(
  faction: Faction.hacker,
  seedColorHex: '#00FF41',
  imagePath: 'assets/images/hacker.png',
  ...
)
```

Ese valor se convierte a `Color` y se pasa a `ColorScheme.fromSeed()`:

```dart
ColorScheme.fromSeed(
  seedColor: Color(int.parse('0xFF' + seedColorHex.substring(1))),
  brightness: Brightness.dark,
)
```

### Dónde conectar el código (Punto 2)
```dart
// En AgentProfileScreen._onFactionSelected():
void _onFactionSelected(Faction faction) {
  setState(() => _selectedFaction = faction);
}

theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: currentSeedColor),
  useMaterial3: true,
)
```

---

##  Punto 3 — Accesibilidad / Semantics

### ¿Qué hace?
Envuelve los elementos clave con el widget `Semantics` de Flutter para que los lectores de pantalla (TalkBack en Android, VoiceOver en iOS) describan correctamente cada elemento.

### Árbol de Semantics del proyecto

```
MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Semantics(label: 'Botón: Finalizar misión y borrar rastro')
    │       └── IconButton(icon: Icons.logout)           ← botón cerrar sesión
    └── Body
        └── Column
            ├── _FactionImage
            │   └── Semantics(label: 'Logo de la facción [Nombre]')
            │       └── Image.asset(...)
            └── FactionSelector
                └── Row
                    ├── Semantics(label: 'Seleccionar facción Hacker')
                    │   └── _FactionButton
                    ├── Semantics(label: 'Seleccionar facción Enforcer')
                    │   └── _FactionButton
                    └── Semantics(label: 'Seleccionar facción Ghost')
                        └── _FactionButton
```

### Ejemplo de implementación
```dart
// Botón de cerrar sesión — lector de pantalla dirá exactamente esto:
Semantics(
  label: 'Botón: Finalizar misión y borrar rastro',
  button: true,
  child: IconButton(
    icon: const Icon(Icons.logout),
    onPressed: () { /* lógica de cierre */ },
  ),
)
```

---

## Punto 4 — Tipografía M3 con Google Fonts

### ¿Qué hace?
Aplica las fuentes **JetBrains Mono** (textos tipo terminal/código) y **Urbanist** (títulos y UI general) usando el paquete `google_fonts`, integradas con el `TextTheme` de Material 3.

### Fuentes utilizadas

| Fuente | Uso | Razón |
|--------|-----|-------|
| `JetBrains Mono` | Labels de facciones, textos de código, etiquetas técnicas | Estética de terminal hacker |
| `Urbanist` | Títulos, nombre de facción, descripciones | Tipografía moderna y limpia |

### Cómo integrar en `app.dart`
```dart
import 'package:google_fonts/google_fonts.dart';

ThemeData(
  useMaterial3: true,
  colorScheme: ...,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.urbanist(
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
    titleLarge: GoogleFonts.urbanist(
      fontWeight: FontWeight.w600,
    ),
    // Textos técnicos / código → JetBrains Mono
    bodyMedium: GoogleFonts.jetBrainsMono(),
    labelSmall: GoogleFonts.jetBrainsMono(
      letterSpacing: 1.5,
    ),
  ),
)
```

---

## Flujo de datos entre puntos

```
Usuario presiona un botón de facción (Punto 1)
         │
         ▼
_onFactionSelected(faction) actualiza _selectedFaction
         │
         ├──► Cambia imagen central (Punto 2)
         │
         ├──► Cambia ColorScheme completo con seedColorHex (Punto 2)
         │
         ├──► Semantics actualiza label del botón activo (Punto 3)
         │
         └──► Tipografía M3 ya está aplicada globalmente (Punto 4)
```
---
