import 'package:flutter/material.dart';
import '../core/utils/app_utils.dart';
import '../models/pokemon_details.dart';

/// Stat dial widget for displaying Pokemon stats
class StatDial extends StatelessWidget {
  final String label;
  final int value;
  final int maxValue;
  final Color? color;
  final double size;

  const StatDial({
    super.key,
    required this.label,
    required this.value,
    this.maxValue = 255,
    this.color,
    this.size = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final progress = (value / maxValue).clamp(0.0, 1.0);
    final dialColor = color ?? CaremixerColors.orange;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background circle
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode
                ? const Color(0xFF2D2D2D)
                : CaremixerColors.lightGrey,
            border: Border.all(
              color: dialColor.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
        ),
        // Progress arc
        CustomPaint(
          size: Size(size, size),
          painter: StatDialPainter(
            progress: progress,
            color: dialColor,
            strokeWidth: 6.0,
          ),
        ),
        // Center content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: size * 0.25,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? CaremixerColors.white
                      : CaremixerColors.darkGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: size * 0.12,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? CaremixerColors.grey
                      : CaremixerColors.darkGreen,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom painter for stat dial progress arc
class StatDialPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  StatDialPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Create gradient for the arc
    final gradient = SweepGradient(
      colors: [
        color.withValues(alpha: 0.3),
        color,
        color.withValues(alpha: 0.8),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw the progress arc
    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      rect,
      -3.14159 / 2, // Start from top
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is StatDialPainter &&
        (oldDelegate.progress != progress || oldDelegate.color != color);
  }
}

/// Stat dials grid widget
class StatDialsGrid extends StatelessWidget {
  final PokemonStats stats;
  final Color? primaryColor;

  const StatDialsGrid({super.key, required this.stats, this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final dialColor = primaryColor ?? CaremixerColors.orange;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      padding: const EdgeInsets.all(0),
      childAspectRatio: 1.0,
      children: [
        StatDial(label: 'HP', value: stats.hp, color: dialColor),
        StatDial(label: 'ATK', value: stats.attack, color: dialColor),
        StatDial(label: 'DEF', value: stats.defense, color: dialColor),
        StatDial(label: 'SP.ATK', value: stats.specialAttack, color: dialColor),
        StatDial(
          label: 'SP.DEF',
          value: stats.specialDefense,
          color: dialColor,
        ),
        StatDial(label: 'SPD', value: stats.speed, color: dialColor),
      ],
    );
  }
}
