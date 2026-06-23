import 'package:flutter/material.dart';

import '../../../../core/widgets/figma_widgets.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  var _tab = _RankingTab.ranking;

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 3,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            children: [
              _SegmentedHeader(
                selected: _tab,
                onChanged: (tab) => setState(() => _tab = tab),
              ),
              const SizedBox(height: 28),
              if (_tab == _RankingTab.ranking)
                const _RankingPanel()
              else
                const _MyRankingPanel(),
            ],
          ),
          const FigmaTopBar(
            title: '랭킹',
            subtitle: '전체 랭킹과 내 기록',
            centerTitle: false,
          ),
        ],
      ),
    );
  }
}

enum _RankingTab { ranking, my }

class _SegmentedHeader extends StatelessWidget {
  const _SegmentedHeader({required this.selected, required this.onChanged});

  final _RankingTab selected;
  final ValueChanged<_RankingTab> onChanged;

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
            child: _Segment(
              label: '랭킹',
              active: selected == _RankingTab.ranking,
              onTap: () => onChanged(_RankingTab.ranking),
            ),
          ),
          Expanded(
            child: _Segment(
              label: '내 랭킹',
              active: selected == _RankingTab.my,
              onTap: () => onChanged(_RankingTab.my),
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.black : FigmaColors.muted,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.25,
          ),
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
        _ProfileSummary(
          eyebrow: '이달의 예측왕',
          title: '예측 고수',
          meta: '정확도 94.2% · 12회 예측 적중',
        ),
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
          name: '카넬',
          points: '+2,450점',
          meta: '이달의 정확도 96.1%',
        ),
        SizedBox(height: 16),
        _RankingRow(
          rank: '꼴',
          name: '최대 편차',
          points: '편차 15.4',
          meta: '역대 최대 꼴찌',
          danger: true,
        ),
        SizedBox(height: 16),
        _RankingRow(rank: '3', name: '골잡이', points: '+1,890점', meta: '누적 랭킹'),
      ],
    );
  }
}

class _MyRankingPanel extends StatelessWidget {
  const _MyRankingPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ProfileSummary(
          eyebrow: '내 랭킹',
          title: '민우',
          meta: '전체 12위 · 이번 달 4위',
          trophy: Icons.person_pin_rounded,
        ),
        SizedBox(height: 18),
        FigmaCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallMeta('내 예측 지표'),
              SizedBox(height: 16),
              _MetricRow(label: '참여 중인 예측방', value: '2'),
              _MetricRow(label: '평균 편차', value: '2.4'),
              _MetricRow(label: '정확도', value: '84.8%'),
              _MetricRow(label: '이번 달 꼴찌', value: '1회'),
            ],
          ),
        ),
        SizedBox(height: 18),
        _RankingRow(rank: '12', name: '민우', points: '+980점', meta: '상위 18%'),
      ],
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({
    required this.eyebrow,
    required this.title,
    required this.meta,
    this.trophy = Icons.emoji_events_rounded,
  });

  final String eyebrow;
  final String title;
  final String meta;
  final IconData trophy;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      child: Row(
        children: [
          const TeamMark(label: '예', size: 64, color: FigmaColors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow,
                  style: const TextStyle(
                    color: FigmaColors.blue,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: FigmaColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                SmallMeta(meta),
              ],
            ),
          ),
          Icon(trophy, color: FigmaColors.dim, size: 54),
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
    final color = danger ? FigmaColors.pink : FigmaColors.blue;
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
                fontSize: rank.length > 1 ? 28 : 40,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 14),
          TeamMark(
            label: name.substring(0, 1),
            size: 36,
            color: danger ? FigmaColors.pink : FigmaColors.blueSoft,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: FigmaColors.text, fontSize: 16),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                points,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
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

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

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
