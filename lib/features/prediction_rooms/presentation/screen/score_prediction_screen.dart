import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ScorePredictionScreen extends StatelessWidget {
  const ScorePredictionScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('스코어 예측')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: const [
          _ScoreInputCard(homeTeam: 'Korea Republic', awayTeam: 'Japan'),
          SizedBox(height: 24),
          FilledButton(onPressed: null, child: Text('저장하기')),
        ],
      ),
    );
  }
}

class _ScoreInputCard extends StatelessWidget {
  const _ScoreInputCard({required this.homeTeam, required this.awayTeam});

  final String homeTeam;
  final String awayTeam;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _TeamScoreRow(teamName: homeTeam, score: 2),
            const Divider(height: 28, color: AppColors.border),
            _TeamScoreRow(teamName: awayTeam, score: 1),
          ],
        ),
      ),
    );
  }
}

class _TeamScoreRow extends StatelessWidget {
  const _TeamScoreRow({required this.teamName, required this.score});

  final String teamName;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            teamName,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.remove_rounded)),
        SizedBox(
          width: 42,
          child: Text(
            '$score',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.add_rounded)),
      ],
    );
  }
}
