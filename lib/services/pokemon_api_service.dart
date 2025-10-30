import 'dart:convert';
import 'dart:developer' show log;
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
import '../models/pokemon_details.dart';

/// Pokemon API service
class PokemonApiService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  /// Fetch Pokemon list with pagination
  Future<PokemonResponse> fetchPokemonList({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/pokemon?limit=$limit&offset=$offset');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return PokemonResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load Pokemon list: ${response.statusCode}');
      }
    } catch (e) {
      log('Network error: $e');
      throw Exception('Please check your internet connection');
    }
  }

  /// Search Pokemon by name
  Future<List<Pokemon>> searchPokemon(String query) async {
    try {
      final response = await fetchPokemonList(limit: 1000);
      return response.results
          .where(
            (pokemon) =>
                pokemon.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }

  /// Fetch detailed Pokemon information by ID
  Future<PokemonDetails> fetchPokemonDetails(int id) async {
    try {
      final url = Uri.parse('$_baseUrl/pokemon-species/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final speciesData = json.decode(response.body) as Map<String, dynamic>;

        // Fetch Pokemon data for stats
        final pokemonUrl = Uri.parse('$_baseUrl/pokemon/$id');
        final pokemonResponse = await http.get(pokemonUrl);

        if (pokemonResponse.statusCode == 200) {
          final pokemonData =
              json.decode(pokemonResponse.body) as Map<String, dynamic>;

          // Combine species and Pokemon data
          final combinedData = {
            ...pokemonData,
            'flavor_text_entries': speciesData['flavor_text_entries'],
            'habitat': speciesData['habitat'],
            'capture_rate': speciesData['capture_rate'],
            'base_happiness': speciesData['base_happiness'],
            'egg_groups': speciesData['egg_groups'],
          };

          return PokemonDetails.fromJson(combinedData);
        } else {
          throw Exception(
            'Failed to load Pokemon data: ${pokemonResponse.statusCode}',
          );
        }
      } else {
        throw Exception(
          'Failed to load Pokemon species: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('Pokemon details error: $e');
      throw Exception('Failed to load Pokemon details: $e');
    }
  }
}
