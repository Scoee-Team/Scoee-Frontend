import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 0,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            children: [
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '다시 오셨네요,\n'),
                    TextSpan(
                      text: '예측 고수님',
                      style: TextStyle(color: FigmaColors.blueSoft),
                    ),
                  ],
                ),
                style: TextStyle(
                  color: FigmaColors.text,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  height: 1.28,
                ),
              ),
              const SizedBox(height: 40),
              SectionTitle(
                title: '오늘의 주요 경기',
                action: '전체 보기',
                onAction: () => context.go('/matches'),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 252,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: [
                    _HeroMatchCard(
                      league: '프리미어리그',
                      time: '21:30',
                      home: '맨시티',
                      away: '아스널',
                      homeMark: '맨시',
                      awayMark: '아스',
                      onTap: () => context.go('/matches/1001'),
                    ),
                    const SizedBox(width: 16),
                    _HeroMatchCard(
                      league: '라리가',
                      time: '04:00',
                      home: '레알',
                      away: '바르사',
                      homeMark: '레알',
                      awayMark: '바르',
                      muted: true,
                      onTap: () => context.go('/matches/1002'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              const SectionTitle(title: '참여 중인 예측방'),
              const SizedBox(height: 14),
              _RoomRow(
                icon: Icons.groups_rounded,
                title: '프리미어리그 28R 정복자',
                meta: '예측 완료 · 현재 12위 / 50명',
                badge: '진행중',
                color: FigmaColors.green,
                onTap: () => context.go('/rooms/10'),
              ),
              const SizedBox(height: 16),
              _RoomRow(
                icon: Icons.stadium_rounded,
                title: '챔스 토너먼트 마스터',
                meta: '2경기 미입력 · 마감 4시간 전',
                badge: '미입력',
                color: FigmaColors.blueSoft,
                onTap: () => context.go('/rooms/11'),
              ),
              const SizedBox(height: 34),
              const SectionTitle(title: '추천 경기'),
              const SizedBox(height: 14),
              const _RecommendedMatch(
                title: '인터 밀란 VS AC 밀란',
                meta: '세리에 A · 05:45',
                first: '인터',
                second: '밀란',
              ),
              SizedBox(height: 16),
              const _RecommendedMatch(
                title: '바이에른 VS 도르트문트',
                meta: '분데스리가 · 내일 02:30',
                first: '뮌헨',
                second: '돌문',
                saved: true,
              ),
            ],
          ),
          const FigmaTopBar(
            title: 'Scoee',
            centerTitle: false,
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  color: FigmaColors.blueSoft,
                ),
                SizedBox(width: 14),
                Icon(Icons.menu_rounded, color: FigmaColors.muted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMatchCard extends StatelessWidget {
  const _HeroMatchCard({
    required this.league,
    required this.time,
    required this.home,
    required this.away,
    required this.homeMark,
    required this.awayMark,
    required this.onTap,
    this.muted = false,
  });

  final String league;
  final String time;
  final String home;
  final String away;
  final String homeMark;
  final String awayMark;
  final VoidCallback onTap;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: FigmaCard(
        padding: const EdgeInsets.all(18),
        radius: 22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallMeta('$league · $time'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _TeamColumn(
                  mark: homeMark,
                  name: home,
                  color: FigmaColors.blue,
                ),
                const Text(
                  'VS',
                  style: TextStyle(
                    color: FigmaColors.muted,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                _TeamColumn(mark: awayMark, name: away, color: FigmaColors.red),
              ],
            ),
            const Spacer(),
            PrimaryCta(
              label: muted ? '마감됨' : '예측하기',
              onPressed: muted ? null : onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamColumn extends StatelessWidget {
  const _TeamColumn({
    required this.mark,
    required this.name,
    required this.color,
  });

  final String mark;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      child: Column(
        children: [
          TeamMark(label: mark, color: color),
          const SizedBox(height: 12),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: FigmaColors.text,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomRow extends StatelessWidget {
  const _RoomRow({
    required this.icon,
    required this.title,
    required this.meta,
    required this.badge,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String meta;
  final String badge;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: FigmaCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 28),
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
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SmallMeta(meta),
                ],
              ),
            ),
            StatusPill(label: badge, color: color),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right_rounded, color: FigmaColors.muted),
          ],
        ),
      ),
    );
  }
}

class _RecommendedMatch extends StatelessWidget {
  const _RecommendedMatch({
    required this.title,
    required this.meta,
    required this.first,
    required this.second,
    this.saved = false,
  });

  final String title;
  final String meta;
  final String first;
  final String second;
  final bool saved;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      radius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Stack(
              children: [
                TeamMark(label: first, size: 40, color: FigmaColors.blue),
                Positioned(
                  left: 24,
                  child: TeamMark(
                    label: second,
                    size: 40,
                    color: FigmaColors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: FigmaColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                SmallMeta(meta),
              ],
            ),
          ),
          Icon(
            saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            color: FigmaColors.blueSoft,
          ),
        ],
      ),
    );
  }
}
