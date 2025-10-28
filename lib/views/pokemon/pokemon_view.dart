import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/app_utils.dart';
import '../../providers/pokemon_provider.dart';
import '../../widgets/pokemon_grid.dart';
import '../../widgets/pokemon_search_bar.dart';

/// Pokemon view screen
class PokemonView extends ConsumerStatefulWidget {
  const PokemonView({super.key});

  @override
  ConsumerState<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends ConsumerState<PokemonView> {
  @override
  void initState() {
    super.initState();
    // Setup scroll listener for pagination
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pokemonListProvider.notifier).setupScrollListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonNotifier = ref.read(pokemonListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              pokemonNotifier.refreshPokemon();
              AppUtils.showSuccessSnackBar(context, 'Pokemon list refreshed');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          PokemonSearchBar(controller: pokemonNotifier.searchController),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await pokemonNotifier.refreshPokemon();
              },
              child: PokemonGrid(
                scrollController: pokemonNotifier.scrollController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
