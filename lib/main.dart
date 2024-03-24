import 'package:favorite_place/screens/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

// final colorScheme = ColorScheme.fromSeed(
//   brightness: Brightness.dark,
//   seedColor: const Color.fromARGB(8, 24, 126, 112),
//   background: const Color.fromARGB(255, 79, 155, 132),
// );

// final theme = ThemeData().copyWith(
//   scaffoldBackgroundColor: colorScheme.background,
//   colorScheme: colorScheme,
//   textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
//     titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
//     titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
//     titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
//   ),
// );

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greate Places',
      theme: FlexThemeData.light(scheme: FlexScheme.bahamaBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.bahamaBlue),
      themeMode: ThemeMode.system,
      home: const PlaceScreen(),
    );
  }
}
