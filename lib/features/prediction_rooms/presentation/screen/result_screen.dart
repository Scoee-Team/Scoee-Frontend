import 'package:flutter/material.dart';

import '../../../../core/widgets/figma_widgets.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 1,
      child: Stack(
        children: [
          const FigmaTopBar(title: 'The Loser'),
          AppScrollView(
            topPadding: 80,
            children: const [
              _FinalScoreCard(),
              SizedBox(height: 56),
              _LoserAnnouncement(),
              SizedBox(height: 42),
              SectionTitle(title: '전체 예측 결과', action: '참여자 5명'),
              SizedBox(height: 14),
              _ResultRow(
                rank: '1',
                name: '지훈',
                prediction: '3 - 1',
                deviation: '편차 1',
                best: true,
              ),
              SizedBox(height: 10),
              _ResultRow(
                rank: '2',
                name: '현아',
                prediction: '2 - 0',
                deviation: '편차 3',
              ),
              SizedBox(height: 10),
              _ResultRow(
                rank: '3',
                name: '상혁',
                prediction: '1 - 1',
                deviation: '편차 3',
              ),
              SizedBox(height: 10),
              _ResultRow(
                rank: '4',
                name: '민우',
                prediction: '0 - 4',
                deviation: '편차 8',
                loser: true,
              ),
              SizedBox(height: 24),
              PrimaryCta(
                label: '결과 공유하기',
                icon: Icons.share_outlined,
                onPressed: null,
                color: FigmaColors.blueSoft,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FinalScoreCard extends StatelessWidget {
  const _FinalScoreCard();

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      radius: 10,
      borderColor: FigmaColors.red.withValues(alpha: 0.35),
      child: Column(
        children: [
          Row(
            children: const [
              StatusPill(
                label: 'PREMIER LEAGUE',
                color: FigmaColors.dim,
                filled: true,
              ),
              Spacer(),
              StatusPill(label: '● FULL TIME', color: FigmaColors.pink),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: const [
              Expanded(
                child: _ResultTeam(
                  mark: 'LIV',
                  name: 'Liverpool',
                  color: FigmaColors.red,
                ),
              ),
              ScoreText('4:1', size: 48),
              Expanded(
                child: _ResultTeam(
                  mark: 'CHE',
                  name: 'Chelsea',
                  color: FigmaColors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultTeam extends StatelessWidget {
  const _ResultTeam({
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
        TeamMark(label: mark, color: color, size: 52),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            color: FigmaColors.text,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _LoserAnnouncement extends StatelessWidget {
  const _LoserAnnouncement();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: const [
            TeamMark(label: '민우', size: 112, color: FigmaColors.pink),
            CircleAvatar(
              radius: 22,
              backgroundColor: FigmaColors.pink,
              child: Icon(
                Icons.sentiment_very_dissatisfied_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '오늘의 '),
              TextSpan(
                text: '꼴찌',
                style: TextStyle(color: FigmaColors.pink),
              ),
              TextSpan(text: '는\n민우님입니다'),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: FigmaColors.text,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        const SmallMeta('총 편차 8점으로 가장 멀리 빗나갔어요'),
      ],
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.rank,
    required this.name,
    required this.prediction,
    required this.deviation,
    this.best = false,
    this.loser = false,
  });

  final String rank;
  final String name;
  final String prediction;
  final String deviation;
  final bool best;
  final bool loser;

  @override
  Widget build(BuildContext context) {
    final color = loser
        ? FigmaColors.pink
        : best
        ? FigmaColors.green
        : FigmaColors.muted;
    return FigmaCard(
      color: loser ? const Color(0xFF2C1719) : FigmaColors.card,
      borderColor: loser
          ? FigmaColors.pink.withValues(alpha: 0.5)
          : FigmaColors.border,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.22),
            child: Text(
              rank,
              style: TextStyle(color: color, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: FigmaColors.text, fontSize: 16),
                ),
                SmallMeta('예측 · $prediction'),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                deviation,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (best || loser)
                Text(
                  best ? 'Best Pick' : '오늘의 꼴찌',
                  style: TextStyle(color: color, fontSize: 12),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
