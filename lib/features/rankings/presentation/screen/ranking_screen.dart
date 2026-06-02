import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('랭킹')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: const [
          _RankingRow(rank: 1, name: 'Minwoo', label: '평균 편차 1.8'),
          _RankingRow(rank: 2, name: 'Jamie', label: '평균 편차 2.4'),
          _RankingRow(rank: 3, name: 'Alex', label: '평균 편차 4.1'),
        ],
      ),
    );
  }
}

class _RankingRow extends StatelessWidget {
  const _RankingRow({
    required this.rank,
    required this.name,
    required this.label,
  });

  final int rank;
  final String name;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: rank == 1 ? AppColors.accent : AppColors.surfaceAlt,
        child: Text('$rank'),
      ),
      title: Text(name),
      subtitle: Text(label),
    );
  }
}
