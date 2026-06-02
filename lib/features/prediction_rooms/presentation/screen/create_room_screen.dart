import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('예측방 만들기')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: '방 제목',
              hintText: '오늘 한일전 스코어 예측',
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'single', label: Text('단일 경기')),
              ButtonSegment(value: 'multi', label: Text('여러 경기')),
            ],
            selected: const {'single'},
            onSelectionChanged: (_) {},
          ),
          const SizedBox(height: 24),
          const _SelectedMatchCard(title: 'Korea Republic vs Japan'),
          const SizedBox(height: 12),
          const _SelectedMatchCard(title: 'Qatar vs Ecuador'),
          const SizedBox(height: 24),
          const _DeadlineCard(),
          const SizedBox(height: 28),
          FilledButton(onPressed: () {}, child: const Text('만들기')),
        ],
      ),
    );
  }
}

class _SelectedMatchCard extends StatelessWidget {
  const _SelectedMatchCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: const Text('예측 마감: 경기 시작 전'),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close_rounded),
          tooltip: '선택 해제',
        ),
      ),
    );
  }
}

class _DeadlineCard extends StatelessWidget {
  const _DeadlineCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '예측 마감 방식',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            const _DeadlineOption(selected: true, title: '경기 시작 전 자동 마감'),
            const _DeadlineOption(selected: false, title: '모든 경기 같은 시간에 마감'),
          ],
        ),
      ),
    );
  }
}

class _DeadlineOption extends StatelessWidget {
  const _DeadlineOption({required this.selected, required this.title});

  final bool selected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected
            ? Icons.radio_button_checked_rounded
            : Icons.radio_button_off_rounded,
        color: selected ? AppColors.accent : AppColors.secondaryText,
      ),
      title: Text(title),
      onTap: () {},
    );
  }
}
