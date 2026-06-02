import 'package:flutter/material.dart';

import '../../../../core/widgets/figma_widgets.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RankingAndMyScreen(activeMy: false);
  }
}

class RankingAndMyScreen extends StatelessWidget {
  const RankingAndMyScreen({required this.activeMy, super.key});

  final bool activeMy;

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: activeMy ? 4 : 3,
      child: Stack(
        children: [
          const FigmaTopBar(title: 'The Loser'),
          AppScrollView(
            topPadding: 80,
            children: [
              _SegmentedHeader(activeMy: activeMy),
              const SizedBox(height: 28),
              if (activeMy) const _MyPanel() else const _RankingPanel(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SegmentedHeader extends StatelessWidget {
  const _SegmentedHeader({required this.activeMy});

  final bool activeMy;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: FigmaColors.cardAlt,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Segment(label: 'Ranking', active: !activeMy),
          ),
          Expanded(
            child: _Segment(label: 'My', active: activeMy),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF12C95A) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? const Color(0xFF02260F) : FigmaColors.muted,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _RankingPanel extends StatelessWidget {
  const _RankingPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ProfileSummary(),
        SizedBox(height: 28),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '주요 랭킹',
            style: TextStyle(
              color: FigmaColors.text,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 18),
        _RankingRow(
          rank: '1',
          name: 'KanelsAble',
          points: '+2,450 pts',
          meta: '이달의 수익',
        ),
        SizedBox(height: 16),
        _RankingRow(
          rank: 'L',
          name: 'Worst Pick',
          points: '-1,120\npts',
          meta: '역대 최대 꼴찌',
          danger: true,
        ),
        SizedBox(height: 16),
        _RankingRow(
          rank: '3',
          name: 'GoalGetter',
          points: '+1,890 pts',
          meta: '누적 랭킹',
        ),
      ],
    );
  }
}

class _MyPanel extends StatelessWidget {
  const _MyPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ProfileSummary(),
        SizedBox(height: 18),
        FigmaCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallMeta('내 활동'),
              SizedBox(height: 16),
              _MyRow(label: '참여 중인 예측방', value: '2'),
              _MyRow(label: '평균 편차', value: '2.4'),
              _MyRow(label: '이번 달 꼴찌', value: '1회'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary();

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      child: Row(
        children: const [
          TeamMark(label: 'P', size: 64, color: FigmaColors.green),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prediction Pro',
                  style: TextStyle(
                    color: FigmaColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                SmallMeta('정확도 94.2% · 12회 예측 적중'),
              ],
            ),
          ),
          Icon(Icons.emoji_events_rounded, color: FigmaColors.dim, size: 62),
        ],
      ),
    );
  }
}

class _RankingRow extends StatelessWidget {
  const _RankingRow({
    required this.rank,
    required this.name,
    required this.points,
    required this.meta,
    this.danger = false,
  });

  final String rank;
  final String name;
  final String points;
  final String meta;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? FigmaColors.red : FigmaColors.green;
    return FigmaCard(
      color: FigmaColors.cardAlt,
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              rank,
              style: TextStyle(
                color: color,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 14),
          TeamMark(
            label: name.substring(0, 1),
            size: 36,
            color: danger ? FigmaColors.red : FigmaColors.blueSoft,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: FigmaColors.text, fontSize: 18),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                points,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SmallMeta(meta),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyRow extends StatelessWidget {
  const _MyRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: FigmaColors.muted),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: FigmaColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
