import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/model/match_summary.dart';
import 'prediction_status_badge.dart';
import 'team_logo_name.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    required this.match,
    this.primaryActionLabel = '예측하기',
    this.onTap,
    super.key,
  });

  final MatchSummary match;
  final String primaryActionLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final timeLabel = DateFormat('M월 d일 HH:mm').format(match.kickoffTime);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      match.leagueName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  PredictionStatusBadge(status: match.status),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: TeamLogoName(team: match.homeTeam)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'VS',
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TeamLogoName(team: match.awayTeam, alignEnd: true),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 16,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      timeLabel,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ),
                  TextButton(onPressed: onTap, child: Text(primaryActionLabel)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
