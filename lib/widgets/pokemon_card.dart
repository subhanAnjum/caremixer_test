import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/utils/app_utils.dart';
import '../../models/pokemon.dart';

/// Pokemon card widget
class PokemonCard extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () => _showPokemonDetails(context),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pokemon image
                    CachedNetworkImage(
                      imageUrl: widget.pokemon.imageUrl,
                      height: 80,
                      width: 80,
                      placeholder: (context, url) => Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? CaremixerColors.darkGreen
                              : CaremixerColors.lightGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? CaremixerColors.darkGreen
                              : CaremixerColors.lightGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.error,
                          color: isDarkMode
                              ? CaremixerColors.white
                              : CaremixerColors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Pokemon name
                    Text(
                      widget.pokemon.name.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? CaremixerColors.white
                            : CaremixerColors.darkGreen,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Pokemon ID
                    Text(
                      '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: CaremixerColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPokemonDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.pokemon.name.toUpperCase()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: widget.pokemon.imageUrl,
              height: 120,
              width: 120,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            Text('Pokemon ID: #${widget.pokemon.id}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
