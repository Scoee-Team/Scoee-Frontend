import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 2,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            children: [
              const SectionTitle(title: '참여 중인 예측방'),
              const SizedBox(height: 16),
              _RoomListTile(
                title: '주말 프리미어리그 예측방',
                status: '미입력',
                meta: '5경기 중 2경기 입력 · 마감 4시간 전',
                color: FigmaColors.pink,
                onTap: () => context.go('/rooms/10'),
              ),
              const SizedBox(height: 14),
              _RoomListTile(
                title: '챔스 토너먼트 마스터',
                status: '완료',
                meta: '예측 완료 · 현재 12위 / 50명',
                color: FigmaColors.green,
                onTap: () => context.go('/rooms/11'),
              ),
              const SizedBox(height: 30),
              PrimaryCta(
                label: '예측방 만들기',
                icon: Icons.add_circle_outline_rounded,
                onPressed: () => context.go('/rooms/create'),
              ),
            ],
          ),
          FigmaTopBar(
            title: '예측방',
            subtitle: '참여 중인 방',
            centerTitle: false,
            trailing: IconButton(
              onPressed: () => context.go('/rooms/create'),
              icon: const Icon(Icons.add_rounded, color: FigmaColors.green),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomListTile extends StatelessWidget {
  const _RoomListTile({
    required this.title,
    required this.status,
    required this.meta,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String status;
  final String meta;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: FigmaCard(
        color: FigmaColors.cardAlt,
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(Icons.groups_rounded, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: FigmaColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SmallMeta(meta),
                ],
              ),
            ),
            StatusPill(label: status, color: color),
            const Icon(Icons.chevron_right_rounded, color: FigmaColors.muted),
          ],
        ),
      ),
    );
  }
}
