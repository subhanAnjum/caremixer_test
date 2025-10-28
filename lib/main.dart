import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_utils.dart';
import 'views/timeline/timeline_view.dart';
import 'views/pokemon/pokemon_view.dart';
import 'views/chat/chat_view.dart';

void main() {
  runApp(const MyApp());
}

/// Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Caremixer Assessment',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const MainNavigationView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/// Main navigation view with bottom navigation
class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
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

  bool get _isDarMode => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: _isDarMode
            ? CaremixerColors.darkGreen
            : CaremixerColors.white,
        selectedItemColor: CaremixerColors.orange,
        unselectedItemColor: _isDarMode
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
