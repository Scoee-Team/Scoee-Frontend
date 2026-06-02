import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../widget/match_card.dart';

class MatchListScreen extends ConsumerWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matches = ref.watch(upcomingMatchesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('경기')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const _FilterBar(),
          const SizedBox(height: 20),
          ...matches.map(
            (match) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MatchCard(
                match: match,
                onTap: () => context.go('/matches/${match.id}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context) {
    const filters = ['날짜', '리그', '관심 팀', '상태'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: filters
          .map(
            (label) => FilterChip(
              selected: label == '날짜',
              label: Text(label),
              onSelected: (_) {},
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.surfaceAlt,
              side: const BorderSide(color: AppColors.border),
              labelStyle: const TextStyle(color: AppColors.primaryText),
            ),
          )
          .toList(),
    );
  }
}
