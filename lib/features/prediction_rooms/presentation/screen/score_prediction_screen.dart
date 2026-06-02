import 'package:flutter/material.dart';

import '../../../../core/widgets/figma_widgets.dart';

class ScorePredictionScreen extends StatelessWidget {
  const ScorePredictionScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 1,
      child: Stack(
        children: [
          const FigmaTopBar(
            title: '스코어 예측하기',
            showBack: true,
            trailing: Icon(
              Icons.help_outline_rounded,
              color: FigmaColors.muted,
            ),
          ),
          AppScrollView(
            topPadding: 82,
            bottomPadding: 176,
            children: const [
              SmallMeta('MATCHWEEK 24'),
              SizedBox(height: 12),
              Text(
                '이번 주의 주요 경기 예측',
                style: TextStyle(
                  color: FigmaColors.text,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 28),
              _MainScoreInputCard(),
              SizedBox(height: 18),
              _CompactPredictionRow(
                time: '11:00',
                home: '토트넘',
                away: '아스널',
                scoreA: 2,
                scoreB: 1,
                complete: true,
              ),
              SizedBox(height: 18),
              _CompactPredictionRow(
                time: '01:30',
                home: '맨유',
                away: '첼시',
                scoreA: 0,
                scoreB: 0,
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 96,
            child: PrimaryCta(
              label: '예측 제출하기',
              icon: Icons.send_rounded,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _MainScoreInputCard extends StatelessWidget {
  const _MainScoreInputCard();

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      radius: 20,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: StatusPill(label: '● PRE-MATCH', color: FigmaColors.pink),
          ),
          Row(
            children: const [
              Expanded(
                child: _InputTeam(
                  mark: 'MC',
                  name: '맨체스터 시티',
                  color: FigmaColors.blue,
                ),
              ),
              _LargeStepper(score: '0'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  ':',
                  style: TextStyle(color: FigmaColors.dim, fontSize: 28),
                ),
              ),
              _LargeStepper(score: '0'),
              Expanded(
                child: _InputTeam(
                  mark: 'LIV',
                  name: '리버풀',
                  color: FigmaColors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          StatusPill(label: '↗  48%가 홈 승리 예측', color: FigmaColors.green),
        ],
      ),
    );
  }
}

class _InputTeam extends StatelessWidget {
  const _InputTeam({
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
        TeamMark(label: mark, color: color, size: 64),
        const SizedBox(height: 12),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(
            color: FigmaColors.text,
            fontSize: 16,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _LargeStepper extends StatelessWidget {
  const _LargeStepper({required this.score});

  final String score;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RoundControl(icon: Icons.add_rounded),
        const SizedBox(height: 8),
        ScoreText(score, size: 46),
        const SizedBox(height: 8),
        _RoundControl(icon: Icons.remove_rounded),
      ],
    );
  }
}

class _RoundControl extends StatelessWidget {
  const _RoundControl({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFF34363E),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: FigmaColors.muted),
    );
  }
}

class _CompactPredictionRow extends StatelessWidget {
  const _CompactPredictionRow({
    required this.time,
    required this.home,
    required this.away,
    required this.scoreA,
    required this.scoreB,
    this.complete = false,
  });

  final String time;
  final String home;
  final String away;
  final int scoreA;
  final int scoreB;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      radius: 20,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              SmallMeta('▮▮▮  $time'),
              const Spacer(),
              Text(
                complete ? '예측 완료' : '미작성',
                style: TextStyle(
                  color: complete ? FigmaColors.green : FigmaColors.muted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: _CompactTeam(name: home)),
              Expanded(
                flex: 3,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF23242A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const _MiniButton(Icons.remove_rounded),
                      Text('$scoreA', style: _scoreStyle),
                      const _MiniButton(Icons.add_rounded),
                      const Text('-', style: TextStyle(color: FigmaColors.dim)),
                      const _MiniButton(Icons.remove_rounded),
                      Text('$scoreB', style: _scoreStyle),
                      const _MiniButton(Icons.add_rounded),
                    ],
                  ),
                ),
              ),
              Expanded(child: _CompactTeam(name: away)),
            ],
          ),
        ],
      ),
    );
  }
}

const _scoreStyle = TextStyle(
  color: FigmaColors.text,
  fontSize: 20,
  fontWeight: FontWeight.w800,
);

class _MiniButton extends StatelessWidget {
  const _MiniButton(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFF393B43),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: FigmaColors.muted, size: 18),
    );
  }
}

class _CompactTeam extends StatelessWidget {
  const _CompactTeam({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: TextAlign.center,
      maxLines: 2,
      style: const TextStyle(color: FigmaColors.text, fontSize: 14),
    );
  }
}
