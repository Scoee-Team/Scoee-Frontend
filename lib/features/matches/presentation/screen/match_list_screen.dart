import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 1,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            children: [
              const _DateScroller(),
              const SizedBox(height: 18),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list_rounded, size: 18),
                    label: const Text('리그 선택'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: FigmaColors.text,
                      side: BorderSide(
                        color: FigmaColors.green.withValues(alpha: 0.32),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const SmallMeta('관심 팀만 보기'),
                  const SizedBox(width: 8),
                  Switch(value: false, onChanged: (_) {}),
                ],
              ),
              const SizedBox(height: 18),
              _LeagueGroup(
                title: '프리미어리그',
                accent: FigmaColors.green,
                children: [
                  _MatchCard(
                    time: '22:00',
                    home: '아스널',
                    away: '리버풀',
                    homeMark: '아스',
                    awayMark: '리버',
                    score: '2 - 1',
                    status: '진행중',
                    statusColor: FigmaColors.red,
                    footer: '예측 가능',
                    footerColor: FigmaColors.green,
                    onTap: () => context.go('/matches/1001'),
                  ),
                  const SizedBox(height: 12),
                  _MatchCard(
                    time: '00:30',
                    home: '맨시티',
                    away: '토트넘',
                    homeMark: '맨시',
                    awayMark: '토트',
                    score: 'VS',
                    status: '예정',
                    statusColor: FigmaColors.green,
                    footer: '2시간 뒤 열림',
                    footerColor: FigmaColors.muted,
                    onTap: () => context.go('/matches/1002'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _LeagueGroup(
                title: '라리가',
                accent: FigmaColors.dim,
                children: [
                  _MatchCard(
                    time: '04:00',
                    home: '레알 마드리드',
                    away: '바르셀로나',
                    homeMark: '레알',
                    awayMark: '바르',
                    score: '3 - 0',
                    status: '종료',
                    statusColor: FigmaColors.muted,
                    footer: null,
                    onTap: () => context.go('/matches/1003'),
                  ),
                ],
              ),
            ],
          ),
          const FigmaTopBar(
            title: '경기',
            subtitle: '오늘의 경기 일정',
            centerTitle: false,
          ),
        ],
      ),
    );
  }
}

class _DateScroller extends StatelessWidget {
  const _DateScroller();

  @override
  Widget build(BuildContext context) {
    final days = [
      ('10월', '24', true),
      ('금', '25', false),
      ('토', '26', false),
      ('일', '27', false),
      ('월', '28', false),
      ('화', '29', false),
    ];

    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final day = days[index];
          return Container(
            width: 56,
            decoration: BoxDecoration(
              color: day.$3 ? FigmaColors.blue : FigmaColors.cardAlt,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.$1,
                  style: TextStyle(
                    color: day.$3 ? const Color(0xFF052A55) : FigmaColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  day.$2,
                  style: TextStyle(
                    color: day.$3 ? const Color(0xFF052A55) : FigmaColors.text,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LeagueGroup extends StatelessWidget {
  const _LeagueGroup({
    required this.title,
    required this.accent,
    required this.children,
  });

  final String title;
  final Color accent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: accent, width: 4)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TeamMark(
                  label: title.substring(0, 2).toUpperCase(),
                  size: 24,
                  color: accent,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: FigmaColors.text,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: FigmaColors.muted,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({
    required this.time,
    required this.home,
    required this.away,
    required this.homeMark,
    required this.awayMark,
    required this.score,
    required this.status,
    required this.statusColor,
    required this.onTap,
    this.footer,
    this.footerColor,
  });

  final String time;
  final String home;
  final String away;
  final String homeMark;
  final String awayMark;
  final String score;
  final String status;
  final Color statusColor;
  final String? footer;
  final Color? footerColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: FigmaCard(
        padding: const EdgeInsets.all(16),
        radius: 10,
        child: Column(
          children: [
            Row(
              children: [
                SmallMeta(time),
                const Spacer(),
                StatusPill(
                  label: status,
                  color: statusColor,
                  filled: status == '예정',
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: _TeamSide(
                    mark: homeMark,
                    name: home,
                    color: FigmaColors.red,
                  ),
                ),
                SizedBox(
                  width: 96,
                  child: ScoreText(score, size: score == 'VS' ? 32 : 46),
                ),
                Expanded(
                  child: _TeamSide(
                    mark: awayMark,
                    name: away,
                    color: FigmaColors.blue,
                  ),
                ),
              ],
            ),
            if (footer != null) ...[
              const SizedBox(height: 18),
              const Divider(color: FigmaColors.border),
              const SizedBox(height: 8),
              StatusPill(
                label: footer!,
                color: footerColor ?? FigmaColors.green,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TeamSide extends StatelessWidget {
  const _TeamSide({
    required this.mark,
    required this.name,
    required this.color,
  });

  final String mark;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeamMark(label: mark, size: 40, color: color),
        const SizedBox(height: 10),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: FigmaColors.text, fontSize: 14),
        ),
      ],
    );
  }
}
