import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_utils.dart';
import 'providers/theme_provider.dart';
import 'views/timeline/timeline_view.dart';
import 'views/pokemon/pokemon_view.dart';
import 'views/chat/chat_view.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

/// Main app widget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Caremixer Assessment',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const MainNavigationView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Main navigation view with bottom navigation
class MainNavigationView extends ConsumerStatefulWidget {
  const MainNavigationView({super.key});

  @override
  ConsumerState<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends ConsumerState<MainNavigationView> {
  int _currentIndex = 0;

  final List<Widget> _views = [
    const TimelineView(),
    const PokemonView(),
    const ChatView(),
  ];

  final List<String> _titles = ['Timeline', 'Pokemon', 'Chat'];

  final List<IconData> _icons = [
    Icons.timeline,
    Icons.catching_pokemon,
    Icons.chat,
  ];

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _views),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDarkMode
            ? const Color(0xFF1E1E1E)
            : CaremixerColors.white,
        selectedItemColor: CaremixerColors.orange,
        unselectedItemColor: isDarkMode
            ? CaremixerColors.white
            : CaremixerColors.grey,
        items: _icons.asMap().entries.map((entry) {
          final index = entry.key;
          final icon = entry.value;
          return BottomNavigationBarItem(
            icon: Icon(icon),
            label: _titles[index],
          );
        }).toList(),
      ),
    );
  }
}
