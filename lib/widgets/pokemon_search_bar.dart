import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_provider.dart';

/// Pokemon search bar
class PokemonSearchBar extends ConsumerWidget {
  const PokemonSearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search Pokemon...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              return value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        ref.read(searchQueryProvider.notifier).state = '';
                        ref.read(pokemonListProvider.notifier).clearSearch();
                      },
                    )
                  : const SizedBox.shrink();
            },
          ),
        ),
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
          ref.read(pokemonListProvider.notifier).searchPokemon(value);
        },
      ),
    );
  }
}
