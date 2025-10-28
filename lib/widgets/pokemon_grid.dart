import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/app_utils.dart';
import '../providers/pokemon_provider.dart';
import 'pokemon_card.dart';

/// Pokemon grid widget
class PokemonGrid extends ConsumerWidget {
  const PokemonGrid({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonSearchProvider);

    return pokemonAsync.when(
      data: (pokemon) => pokemon.isEmpty
          ? Center(child: Text('No Pokémon found. Try a different search.'))
          : GridView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: pokemon.length,
              itemBuilder: (context, index) {
                return PokemonCard(pokemon: pokemon[index]);
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: CaremixerColors.darkRed,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading Pokemon',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(pokemonListProvider.notifier).refreshPokemon(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
