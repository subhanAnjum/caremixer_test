import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/utils/app_utils.dart';
import '../../core/utils/pokemon_utils.dart';
import '../../models/pokemon.dart';
import '../../providers/theme_provider.dart';
import '../../views/pokemon_details/pokemon_details_view.dart';

/// Pokemon card widget
class PokemonCard extends ConsumerStatefulWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  ConsumerState<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends ConsumerState<PokemonCard>
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
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final pokemonType = PokemonUtils.getPokemonType(widget.pokemon.id);
    final typeColor = PokemonUtils.getTypeColor(pokemonType);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: InkWell(
              onTap: () => _navigateToDetails(context),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isDarkMode
                      ? const Color(0xFF2D2D2D)
                      : CaremixerColors.white,
                  border: Border.all(
                    color: typeColor.withValues(alpha: 0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: typeColor.withValues(alpha: 0.2),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Subtle background pattern
                    Positioned(
                      bottom: 5,
                      left: -20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: typeColor.withValues(alpha: 0.001),
                          boxShadow: [
                            BoxShadow(
                              color: typeColor.withValues(alpha: 0.3),
                              blurRadius: 18,
                              spreadRadius: 2,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Content
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Column(
                        children: [
                          // Type accent bar
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: typeColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header with ID
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: typeColor.withValues(
                                            alpha: 0.15,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: typeColor.withValues(
                                              alpha: 0.3,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                                          style: TextStyle(
                                            color: isDarkMode
                                                ? CaremixerColors.white
                                                : typeColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      // Type icon
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: typeColor.withValues(
                                            alpha: 0.15,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: typeColor.withValues(
                                              alpha: 0.3,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          PokemonUtils.getTypeIcon(pokemonType),
                                          size: 16,
                                          color: isDarkMode
                                              ? CaremixerColors.white
                                              : typeColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Pokemon name
                                  Text(
                                    widget.pokemon.name.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                      color: isDarkMode
                                          ? CaremixerColors.white
                                          : CaremixerColors.darkGreen,
                                      letterSpacing: 1,
                                      height: 1.2,
                                      shadows: [
                                        // Primary shadow for depth
                                        Shadow(
                                          color: isDarkMode
                                              ? Colors.black.withValues(
                                                  alpha: 0.6,
                                                )
                                              : typeColor.withValues(
                                                  alpha: 0.3,
                                                ),
                                          blurRadius: 0,
                                          offset: const Offset(2, 2),
                                        ),
                                        // Secondary shadow for elevation
                                        Shadow(
                                          color: isDarkMode
                                              ? Colors.black.withValues(
                                                  alpha: 0.4,
                                                )
                                              : typeColor.withValues(
                                                  alpha: 0.2,
                                                ),
                                          blurRadius: 0,
                                          offset: const Offset(1, 1),
                                        ),
                                        // Soft glow effect
                                        Shadow(
                                          color: typeColor.withValues(
                                            alpha: 0.1,
                                          ),
                                          blurRadius: 4,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                  ),
                                  const Spacer(),
                                  // Type badge
                                  AnimatedBuilder(
                                    animation: _scaleAnimation,
                                    builder: (context, child) {
                                      return TweenAnimationBuilder<double>(
                                        tween: Tween<double>(
                                          begin: 0.0,
                                          end: 1.0,
                                        ),
                                        duration: const Duration(
                                          milliseconds: 800,
                                        ),
                                        curve: Curves.elasticOut,
                                        builder: (context, value, child) {
                                          return Transform.scale(
                                            scale: _scaleAnimation.value,
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12 * value,
                                                vertical: 6 * value,
                                              ),
                                              decoration: BoxDecoration(
                                                color: typeColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: typeColor.withValues(
                                                      alpha: 0.3 * value,
                                                    ),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                pokemonType,
                                                style: TextStyle(
                                                  color: CaremixerColors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Overlapping Pokemon image
                    Positioned(
                      bottom: 5,
                      left: -20,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            // BoxShadow(
                            //   color: typeColor.withValues(alpha: 0.3),
                            //   blurRadius: 12,
                            //   spreadRadius: 2,
                            //   offset: const Offset(0, 4),
                            // ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Hero(
                            tag: 'pokemon-${widget.pokemon.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: CachedNetworkImage(
                                imageUrl: widget.pokemon.imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        typeColor.withValues(alpha: 0.1),
                                        typeColor.withValues(alpha: 0.05),
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        CaremixerColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        typeColor.withValues(alpha: 0.1),
                                        typeColor.withValues(alpha: 0.05),
                                      ],
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.pets,
                                    color: typeColor.withValues(alpha: 0.5),
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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

  /// Navigate to Pokemon details page
  void _navigateToDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PokemonDetailsView(
          pokemonId: widget.pokemon.id,
          heroImageUrl: widget.pokemon.imageUrl,
        ),
      ),
    );
  }
}
