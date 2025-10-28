import 'dart:convert';
import 'dart:developer' show log;
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

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
}
