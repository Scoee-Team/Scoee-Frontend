import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../widget/team_logo_name.dart';

class MatchDetailScreen extends ConsumerWidget {
  const MatchDetailScreen({required this.matchId, super.key});

  final int matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final match = ref
        .watch(upcomingMatchesProvider)
        .firstWhere((item) => item.id == matchId);
    final kickoff = DateFormat('yyyy년 M월 d일 HH:mm').format(match.kickoffTime);

    return Scaffold(
      appBar: AppBar(title: const Text('경기 상세')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    match.leagueName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 28),
                  TeamLogoName(team: match.homeTeam),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'VS',
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TeamLogoName(team: match.awayTeam),
                  const SizedBox(height: 28),
                  _InfoRow(label: '킥오프', value: kickoff),
                  const SizedBox(height: 10),
                  const _InfoRow(label: '예측 마감', value: '경기 시작 전'),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.go('/rooms/create'),
                    icon: const Icon(Icons.group_add_outlined),
                    label: const Text('예측방 만들기'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.secondaryText),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
