import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme mode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((
  ref,
) {
  return ThemeModeNotifier();
});

/// Theme mode notifier
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  /// Toggle between light and dark mode
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  /// Set specific theme mode
  void setThemeMode(ThemeMode mode) {
    state = mode;
  }

  /// Check if current mode is dark
  bool get isDarkMode => state == ThemeMode.dark;

  /// Check if current mode is light
  bool get isLightMode => state == ThemeMode.light;
}
