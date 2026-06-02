import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/model/match_summary.dart';

class PredictionStatusBadge extends StatelessWidget {
  const PredictionStatusBadge({required this.status, super.key});

  final MatchStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      MatchStatus.scheduled => AppColors.accent,
      MatchStatus.live => AppColors.success,
      MatchStatus.finished => AppColors.secondaryText,
      MatchStatus.predictionClosed => AppColors.warning,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.36)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          status.label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
