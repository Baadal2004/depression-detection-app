/// Animated emotion display widget with glassmorphism effect
import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EmotionDisplay extends StatefulWidget {
  final String? emotion;
  final Map<String, double> confidenceScores;
  final bool isDetecting;

  const EmotionDisplay({
    super.key,
    this.emotion,
    this.confidenceScores = const {},
    this.isDetecting = false,
  });

  @override
  State<EmotionDisplay> createState() => _EmotionDisplayState();
}

class _EmotionDisplayState extends State<EmotionDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  String? _previousEmotion;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(EmotionDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.emotion != _previousEmotion && widget.emotion != null) {
      _previousEmotion = widget.emotion;
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: widget.emotion != null
                  ? AppColors.emotionGradient(widget.emotion!)
                  : null,
              color: widget.emotion == null ? AppColors.glassWhite : null,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: (widget.emotion != null
                          ? AppColors.emotionColors[widget.emotion]
                          : AppColors.accentPurple)!
                      .withAlpha(80),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Status indicator
                if (widget.isDetecting && widget.emotion == null)
                  _buildDetectingIndicator()
                else if (widget.emotion != null)
                  _buildEmotionResult()
                else
                  _buildNoFaceDetected(),

                // Confidence bars
                if (widget.confidenceScores.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  _buildConfidenceBars(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetectingIndicator() {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.accentCyan,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Detecting...',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildEmotionResult() {
    final emoji = AppColors.emotionEmojis[widget.emotion] ?? '🤔';
    final confidence = widget.confidenceScores[widget.emotion] ?? 0.0;

    return Column(
      children: [
        // Animated emoji
        ScaleTransition(
          scale: _scaleAnimation,
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 72),
          ),
        ),
        const SizedBox(height: 12),

        // Emotion name
        ScaleTransition(
          scale: _scaleAnimation,
          child: Text(
            widget.emotion!,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Confidence percentage
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${(confidence * 100).toStringAsFixed(1)}% confident',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withAlpha(230),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoFaceDetected() {
    return Column(
      children: [
        Icon(
          Icons.face_outlined,
          size: 60,
          color: Colors.white.withAlpha(150),
        ),
        const SizedBox(height: 12),
        Text(
          'No Face Detected',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white.withAlpha(180),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Point camera at a face',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha(120),
          ),
        ),
      ],
    );
  }

  Widget _buildConfidenceBars() {
    // Sort by confidence
    final sortedEmotions = widget.confidenceScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Show top 3
    final topEmotions = sortedEmotions.take(3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: topEmotions.map((entry) {
        final color = AppColors.emotionColors[entry.key] ?? Colors.grey;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: entry.value),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: 8,
                        backgroundColor: Colors.white.withAlpha(30),
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                child: Text(
                  '${(entry.value * 100).toInt()}%',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withAlpha(180),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
