import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pokemon_details.dart';
import '../services/pokemon_api_service.dart';

/// Pokemon details API service provider
final pokemonDetailsApiServiceProvider = Provider<PokemonApiService>((ref) {
  return PokemonApiService();
});

/// Pokemon details state notifier
class PokemonDetailsNotifier
    extends StateNotifier<AsyncValue<PokemonDetails?>> {
  PokemonDetailsNotifier(this._apiService) : super(const AsyncValue.data(null));

  final PokemonApiService _apiService;

  /// Load Pokemon details by ID
  Future<void> loadPokemonDetails(int id) async {
    state = const AsyncValue.loading();
    try {
      final details = await _apiService.fetchPokemonDetails(id);
      state = AsyncValue.data(details);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Clear current Pokemon details
  void clearDetails() {
    state = const AsyncValue.data(null);
  }
}

/// Pokemon details provider
final pokemonDetailsProvider =
    StateNotifierProvider<PokemonDetailsNotifier, AsyncValue<PokemonDetails?>>((
      ref,
    ) {
      final apiService = ref.watch(pokemonDetailsApiServiceProvider);
      return PokemonDetailsNotifier(apiService);
    });
