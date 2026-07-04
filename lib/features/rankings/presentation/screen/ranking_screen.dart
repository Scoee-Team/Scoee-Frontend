import 'package:flutter/material.dart';

import '../../../../core/widgets/figma_widgets.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  var _tab = _RankingTab.overall;

  static const _overallRows = [
    _RankingItem(
      rank: 1,
      name: '지훈',
      headline: '184점',
      meta: '28경기 참여 · 적중 보너스 9회',
      marker: '지',
    ),
    _RankingItem(
      rank: 2,
      name: '현아',
      headline: '171점',
      meta: '24경기 참여 · 참여 가중치 반영',
      marker: '현',
    ),
    _RankingItem(
      rank: 3,
      name: '상혁',
      headline: '166점',
      meta: '31경기 참여 · 꾸준한 예측',
      marker: '상',
    ),
    _RankingItem(
      rank: 4,
      name: '민우',
      headline: '149점',
      meta: '22경기 참여 · 최근 5경기 +18점',
      marker: '민',
    ),
  ];

  static const _myRows = [
    _MetricItem(label: '집계된 경기', value: '22경기'),
    _MetricItem(label: '보정 점수', value: '149점'),
    _MetricItem(label: '정확히 맞힌 경기', value: '7회'),
    _MetricItem(label: '이번 달 획득 점수', value: '+42점'),
  ];

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 3,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            children: [
              _RankingFilterBar(
                selected: _tab,
                onChanged: (tab) => setState(() => _tab = tab),
              ),
              const SizedBox(height: 18),
              if (_tab == _RankingTab.overall)
                const _OverallRankingPanel(rows: _overallRows)
              else
                const _MyRankingPanel(metrics: _myRows),
            ],
          ),
          const FigmaTopBar(
            title: '랭킹',
            subtitle: '점수와 예측 기록',
            centerTitle: false,
          ),
        ],
      ),
    );
  }
}

class _RankingFilterBar extends StatelessWidget {
  const _RankingFilterBar({required this.selected, required this.onChanged});

  final _RankingTab selected;
  final ValueChanged<_RankingTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: FigmaColors.cardAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _FilterSegment(
              label: '전체 랭킹',
              active: selected == _RankingTab.overall,
              onTap: () => onChanged(_RankingTab.overall),
            ),
          ),
          Expanded(
            child: _FilterSegment(
              label: '내 기록',
              active: selected == _RankingTab.mine,
              onTap: () => onChanged(_RankingTab.mine),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSegment extends StatelessWidget {
  const _FilterSegment({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.black : FigmaColors.muted,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _OverallRankingPanel extends StatelessWidget {
  const _OverallRankingPanel({required this.rows});

  final List<_RankingItem> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SummaryCard(
          title: '전체 사용자 랭킹',
          meta: '100점 시작 · 적중 보너스와 참여 경기 수 보정 반영',
          value: '184점',
          valueLabel: '1위 점수',
          icon: Icons.leaderboard_rounded,
        ),
        const SizedBox(height: 18),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '참여자 순위',
            style: TextStyle(
              color: FigmaColors.text,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (final item in rows) ...[
          _RankingTile(item: item),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _MyRankingPanel extends StatelessWidget {
  const _MyRankingPanel({required this.metrics});

  final List<_MetricItem> metrics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SummaryCard(
          title: '민우',
          meta: '전체 12위 · 이번 달 4위',
          value: '149점',
          valueLabel: '보정 점수',
          icon: Icons.person_pin_rounded,
        ),
        const SizedBox(height: 18),
        FigmaCard(
          color: FigmaColors.cardAlt,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              for (var i = 0; i < metrics.length; i++) ...[
                _MetricRow(item: metrics[i]),
                if (i != metrics.length - 1)
                  const Divider(height: 22, color: FigmaColors.border),
              ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        const _RankingTile(
          item: _RankingItem(
            rank: 12,
            name: '민우',
            headline: '149점',
            meta: '22경기 참여 · 상위 18%',
            marker: '민',
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.meta,
    required this.value,
    required this.valueLabel,
    required this.icon,
  });

  final String title;
  final String meta;
  final String value;
  final String valueLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: FigmaColors.blue, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: FigmaColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                SmallMeta(meta),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: FigmaColors.text,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                valueLabel,
                style: const TextStyle(
                  color: FigmaColors.dim,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RankingTile extends StatelessWidget {
  const _RankingTile({required this.item});

  final _RankingItem item;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      borderColor: FigmaColors.border,
      child: Row(
        children: [
          _RankBadge(rank: item.rank),
          const SizedBox(width: 12),
          TeamMark(label: item.marker, size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: FigmaColors.text,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                SmallMeta(item.meta),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _ScoreBadge(text: item.headline),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Text(
        '$rank',
        style: const TextStyle(
          color: FigmaColors.text,
          fontSize: 24,
          fontWeight: FontWeight.w900,
          height: 1,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 86),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
          width: 0.5,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: FigmaColors.text,
            fontSize: 13,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.item});

  final _MetricItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            item.label,
            style: const TextStyle(
              color: FigmaColors.muted,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          item.value,
          style: const TextStyle(
            color: FigmaColors.text,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _RankingItem {
  const _RankingItem({
    required this.rank,
    required this.name,
    required this.headline,
    required this.meta,
    required this.marker,
  });

  final int rank;
  final String name;
  final String headline;
  final String meta;
  final String marker;
}

class _MetricItem {
  const _MetricItem({required this.label, required this.value});

  final String label;
  final String value;
}

enum _RankingTab { overall, mine }
