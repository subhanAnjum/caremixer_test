import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/utils/app_utils.dart';
import '../../core/utils/pokemon_utils.dart';
import '../../models/pokemon_details.dart';
import '../../providers/pokemon_details_provider.dart';
import '../../widgets/stat_dial.dart';

/// Pokemon details view
class PokemonDetailsView extends ConsumerStatefulWidget {
  final int pokemonId;
  final String? heroImageUrl;

  const PokemonDetailsView({
    super.key,
    required this.pokemonId,
    this.heroImageUrl,
  });

  @override
  ConsumerState<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends ConsumerState<PokemonDetailsView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Load Pokemon details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(pokemonDetailsProvider.notifier)
          .loadPokemonDetails(widget.pokemonId);
    });

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonDetails = ref.watch(pokemonDetailsProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {}
      },
      child: Scaffold(
        body: pokemonDetails.when(
          data: (details) {
            if (details == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildPokemonDetails(context, details);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: CaremixerColors.darkRed,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load Pokemon details',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(pokemonDetailsProvider.notifier)
                        .loadPokemonDetails(widget.pokemonId);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPokemonDetails(BuildContext context, PokemonDetails details) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryType = details.primaryType;
    final typeColor = PokemonUtils.getTypeColor(primaryType);
    final typeGradient = PokemonUtils.getTypeGradient(primaryType);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomScrollView(
        slivers: [
          // App bar with Pokemon artwork
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: typeColor.withValues(alpha: 0.1),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      typeColor.withValues(alpha: 0.1),
                      typeColor.withValues(alpha: 0.05),
                      typeColor.withValues(alpha: 0.02),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Pokemon artwork
                    Center(
                      child: Hero(
                        tag: 'pokemon-${widget.pokemonId}',
                        child: Material(
                          color: Colors.transparent,
                          child: CachedNetworkImage(
                            imageUrl: widget.heroImageUrl ?? details.imageUrl,
                            width: 280,
                            height: 280,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => Container(
                              width: 280,
                              height: 280,
                              decoration: BoxDecoration(
                                color: typeColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: typeColor,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 280,
                              height: 280,
                              decoration: BoxDecoration(
                                color: typeColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.image_not_supported,
                                size: 64,
                                color: typeColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Type accent
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(gradient: typeGradient),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode
                    ? CaremixerColors.white
                    : CaremixerColors.darkGreen,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: isDarkMode
                      ? CaremixerColors.white
                      : CaremixerColors.darkGreen,
                ),
                onPressed: () {
                  // TODO: Add to favorites
                },
              ),
            ],
          ),
          // Content
          SliverToBoxAdapter(
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pokemon name and ID
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            details.name.toUpperCase(),
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: typeColor,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: typeColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: typeColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '#${details.id.toString().padLeft(3, '0')}',
                            style: TextStyle(
                              color: typeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Types
                    Row(
                      children: details.types.map((type) {
                        final typeColor = PokemonUtils.getTypeColor(type);
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: typeColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: typeColor.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                PokemonUtils.getTypeIcon(type),
                                size: 16,
                                color: CaremixerColors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                type,
                                style: const TextStyle(
                                  color: CaremixerColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    // Description
                    _buildSection(
                      context,
                      'Description',
                      Icons.description,
                      typeColor,
                      Text(
                        details.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Stats
                    _buildSection(
                      context,
                      'Base Stats',
                      Icons.trending_up,
                      typeColor,
                      StatDialsGrid(
                        stats: details.stats,
                        primaryColor: typeColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Physical Info
                    _buildSection(
                      context,
                      'Physical Info',
                      Icons.straighten,
                      typeColor,
                      Row(
                        children: [
                          _buildInfoCard(
                            context,
                            'Height',
                            details.formattedHeight,
                            Icons.height,
                            typeColor,
                          ),
                          const SizedBox(width: 16),
                          _buildInfoCard(
                            context,
                            'Weight',
                            details.formattedWeight,
                            Icons.fitness_center,
                            typeColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Abilities
                    _buildSection(
                      context,
                      'Abilities',
                      Icons.auto_awesome,
                      typeColor,
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: details.abilities.map((ability) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: typeColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: typeColor.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              ability,
                              style: TextStyle(
                                color: typeColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Additional Info
                    _buildSection(
                      context,
                      'Additional Info',
                      Icons.info,
                      typeColor,
                      Column(
                        children: [
                          _buildInfoRow(
                            'Generation',
                            'Gen ${details.generation}',
                          ),
                          _buildInfoRow('Habitat', details.habitat),
                          _buildInfoRow(
                            'Capture Rate',
                            details.formattedCaptureRate,
                          ),
                          _buildInfoRow(
                            'Base Happiness',
                            details.baseHappiness.toString(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    Color accentColor,
    Widget child,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accentColor, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color accentColor,
  ) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: accentColor, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                color: accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: CaremixerColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: CaremixerColors.grey),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
