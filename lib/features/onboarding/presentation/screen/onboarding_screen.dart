import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Icon(
                Icons.sports_soccer_rounded,
                color: AppColors.accent,
                size: 56,
              ),
              const SizedBox(height: 24),
              Text(
                'Scoee',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              Text(
                '친구들과 함께 경기 스코어를 예측해보세요.\n가장 멀리 빗나간 친구가 오늘의 꼴찌입니다.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.secondaryText,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 32),
              const _SelectionPreview(
                title: '관심 리그',
                values: ['FIFA World Cup', 'Premier League'],
              ),
              const SizedBox(height: 12),
              const _SelectionPreview(
                title: '관심 팀',
                values: ['Korea Republic', 'FC Seoul'],
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => context.go('/'),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text('계속하기', textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionPreview extends StatelessWidget {
  const _SelectionPreview({required this.title, required this.values});

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: AppColors.secondaryText)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: values
                  .map(
                    (value) => Chip(
                      label: Text(value),
                      backgroundColor: AppColors.surfaceAlt,
                      side: const BorderSide(color: AppColors.border),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
