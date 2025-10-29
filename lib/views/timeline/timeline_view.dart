import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/timeline_entry.dart';
import '../../widgets/timeline_list.dart';
import '../../providers/theme_provider.dart';
import '../../core/utils/app_utils.dart';

/// Timeline view screen
class TimelineView extends ConsumerWidget {
  const TimelineView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = TimelineDataService.getHardcodedEntries();
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
        actions: [
          // Dark mode toggle button
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeNotifier.toggleTheme();
              AppUtils.showSuccessSnackBar(
                context,
                themeMode == ThemeMode.dark
                    ? 'Switched to light mode'
                    : 'Switched to dark mode',
              );
            },
            tooltip: themeMode == ThemeMode.dark
                ? 'Switch to light mode'
                : 'Switch to dark mode',
          ),
          // Theme mode menu
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.palette),
            tooltip: 'Theme options',
            onSelected: (ThemeMode mode) {
              themeNotifier.setThemeMode(mode);
              String message;
              switch (mode) {
                case ThemeMode.light:
                  message = 'Switched to light mode';
                  break;
                case ThemeMode.dark:
                  message = 'Switched to dark mode';
                  break;
                case ThemeMode.system:
                  message = 'Using system theme';
                  break;
              }
              AppUtils.showSuccessSnackBar(context, message);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    Icon(
                      Icons.light_mode,
                      color: themeMode == ThemeMode.light
                          ? CaremixerColors.orange
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Light',
                      style: TextStyle(
                        color: themeMode == ThemeMode.light
                            ? CaremixerColors.orange
                            : null,
                        fontWeight: themeMode == ThemeMode.light
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    Icon(
                      Icons.dark_mode,
                      color: themeMode == ThemeMode.dark
                          ? CaremixerColors.orange
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Dark',
                      style: TextStyle(
                        color: themeMode == ThemeMode.dark
                            ? CaremixerColors.orange
                            : null,
                        fontWeight: themeMode == ThemeMode.dark
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    Icon(
                      Icons.settings_system_daydream,
                      color: themeMode == ThemeMode.system
                          ? CaremixerColors.orange
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'System',
                      style: TextStyle(
                        color: themeMode == ThemeMode.system
                            ? CaremixerColors.orange
                            : null,
                        fontWeight: themeMode == ThemeMode.system
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: TimelineListWidget(entries: entries),
    );
  }
}
