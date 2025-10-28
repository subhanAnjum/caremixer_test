import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pokemon.dart';
import '../services/pokemon_api_service.dart';

/// Pokemon API service provider
final pokemonApiServiceProvider = Provider<PokemonApiService>((ref) {
  return PokemonApiService();
});

/// Pokemon list state notifier
class PokemonListNotifier extends StateNotifier<AsyncValue<List<Pokemon>>> {
  PokemonListNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadPokemon();
  }

  final PokemonApiService _apiService;
  int _currentOffset = 0;
  static const int _pageSize = 20;

  // Controllers
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  /// Load initial Pokemon list
  Future<void> loadPokemon() async {
    state = const AsyncValue.loading();
    try {
      final response = await _apiService.fetchPokemonList(
        limit: _pageSize,
        offset: _currentOffset,
      );
      state = AsyncValue.data(response.results);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Load more Pokemon (pagination)
  Future<void> loadMorePokemon() async {
    if (state.hasValue) {
      final currentPokemon = state.value!;
      _currentOffset += _pageSize;

      try {
        final response = await _apiService.fetchPokemonList(
          limit: _pageSize,
          offset: _currentOffset,
        );

        final updatedPokemon = [...currentPokemon, ...response.results];
        state = AsyncValue.data(updatedPokemon);
      } catch (error, stackTrace) {
        // Revert offset on error
        _currentOffset -= _pageSize;
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }

  /// Refresh Pokemon list
  Future<void> refreshPokemon() async {
    _currentOffset = 0;
    await loadPokemon();
  }

  /// Search Pokemon
  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      // Reset to initial state and load fresh Pokemon
      _currentOffset = 0;
      await loadPokemon();
      return;
    }

    state = const AsyncValue.loading();
    try {
      final results = await _apiService.searchPokemon(query);
      state = AsyncValue.data(results);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Get scroll controller
  ScrollController get scrollController => _scrollController;

  /// Get search controller
  TextEditingController get searchController => _searchController;

  /// Update search query
  void updateSearchQuery(String query) {
    _searchController.text = query;
  }

  /// Clear search
  void clearSearch() {
    _searchController.clear();
    _currentOffset = 0; // Reset pagination offset
    loadPokemon(); // Load fresh Pokemon list
  }

  /// Setup scroll listener for pagination
  void setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        loadMorePokemon();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

/// Pokemon list provider
final pokemonListProvider =
    StateNotifierProvider<PokemonListNotifier, AsyncValue<List<Pokemon>>>((
      ref,
    ) {
      final apiService = ref.watch(pokemonApiServiceProvider);
      return PokemonListNotifier(apiService);
    });

/// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Pokemon search provider
final pokemonSearchProvider = Provider<AsyncValue<List<Pokemon>>>((ref) {
  final pokemonList = ref.watch(pokemonListProvider);

  // Always return the current pokemon list state
  // The search filtering is now handled in the provider's searchPokemon method
  return pokemonList;
});
