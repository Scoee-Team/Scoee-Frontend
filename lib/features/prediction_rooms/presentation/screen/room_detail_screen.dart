import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('예측방 상세')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            '오늘 한일전 스코어 예측',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            '호스트 Minwoo · OPEN',
            style: TextStyle(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              title: const Text('초대 코드'),
              subtitle: const Text('SCOEE-2026'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.ios_share_rounded),
                tooltip: '친구 초대',
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => context.go('/rooms/$roomId/predict'),
            icon: const Icon(Icons.edit_note_rounded),
            label: const Text('내 스코어 예측 입력'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.go('/rooms/$roomId/result'),
            icon: const Icon(Icons.insights_rounded),
            label: const Text('결과 확인'),
          ),
          const SizedBox(height: 28),
          _ProgressTile(label: 'Minwoo', status: '입력 완료'),
          _ProgressTile(label: 'Alex', status: '미입력'),
          _ProgressTile(label: 'Jamie', status: '입력 완료'),
        ],
      ),
    );
  }
}

class _ProgressTile extends StatelessWidget {
  const _ProgressTile({required this.label, required this.status});

  final String label;
  final String status;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundColor: AppColors.surfaceAlt,
        child: Icon(Icons.person_outline_rounded),
      ),
      title: Text(label),
      trailing: Text(
        status,
        style: const TextStyle(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
