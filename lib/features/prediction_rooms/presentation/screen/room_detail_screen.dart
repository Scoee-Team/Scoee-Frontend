import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 2,
      child: Stack(
        children: [
          FigmaTopBar(
            title: '주말 프리미어리그 예측방',
            showBack: true,
            trailing: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.info_outline_rounded, color: FigmaColors.blueSoft),
                SizedBox(width: 8),
                Icon(Icons.settings_outlined, color: FigmaColors.blueSoft),
              ],
            ),
          ),
          AppScrollView(
            topPadding: 84,
            children: [
              Row(
                children: const [
                  Expanded(
                    child: _MiniStat(label: '참여 인원', value: '12', meta: '/ 20'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _MiniStat(
                      label: '내 예측 상태',
                      value: '▮▮▮ (2/5)',
                      meta: '',
                      color: FigmaColors.pink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FigmaCard(
                color: FigmaColors.cardAlt,
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallMeta('예측 마감까지'),
                          SizedBox(height: 6),
                          Text(
                            '04:12:35',
                            style: TextStyle(
                              color: FigmaColors.text,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 128,
                      child: PrimaryCta(
                        label: '예측 제출하기',
                        onPressed: () => context.go('/rooms/$roomId/predict'),
                        color: FigmaColors.blueSoft,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FigmaCard(
                color: const Color(0xFF2D3038),
                child: Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Color(0xFF164B2A),
                      child: Icon(
                        Icons.share_rounded,
                        color: FigmaColors.green,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        '친구 초대 링크 복사',
                        style: TextStyle(color: FigmaColors.text, fontSize: 16),
                      ),
                    ),
                    Icon(Icons.copy_rounded, color: FigmaColors.muted),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SectionTitle(title: '참여자 현황', action: '전체 보기', onAction: () {}),
              const SizedBox(height: 16),
              const _ParticipantStrip(),
              const SizedBox(height: 28),
              const SectionTitle(title: '예측 대상 경기'),
              const SizedBox(height: 16),
              _PredictionTargetCard(
                date: '2024.05.18 23:00',
                league: 'EPL 37R',
                home: '리버풀',
                away: '울버햄튼',
                score: '? : ?',
                note: '예측 입력 필요',
                button: '스코어 입력하기',
                onTap: () => context.go('/rooms/$roomId/predict'),
              ),
              const SizedBox(height: 16),
              _PredictionTargetCard(
                date: '2024.05.19 00:30',
                league: 'EPL 37R',
                home: '맨시티',
                away: '아스널',
                score: '3 : 1',
                note: '예측 완료',
                button: '예측 수정하기',
                complete: true,
                onTap: () => context.go('/rooms/$roomId/predict'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.value,
    required this.meta,
    this.color = FigmaColors.green,
  });

  final String label;
  final String value;
  final String meta;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallMeta(label),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              text: value,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              children: [
                TextSpan(
                  text: ' $meta',
                  style: const TextStyle(
                    color: FigmaColors.muted,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ParticipantStrip extends StatelessWidget {
  const _ParticipantStrip();

  @override
  Widget build(BuildContext context) {
    const people = [
      ('나', 'M', true),
      ('김지훈', 'K', false),
      ('박수민', 'P', true),
      ('Lee J.', 'L', false),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final person in people)
          Column(
            children: [
              Stack(
                children: [
                  TeamMark(
                    label: person.$2,
                    size: 56,
                    color: person.$3 ? FigmaColors.green : FigmaColors.blueSoft,
                  ),
                  if (person.$3)
                    const Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: FigmaColors.green,
                        child: Icon(Icons.check, size: 11, color: Colors.black),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                person.$1,
                style: const TextStyle(color: FigmaColors.text, fontSize: 12),
              ),
            ],
          ),
      ],
    );
  }
}

class _PredictionTargetCard extends StatelessWidget {
  const _PredictionTargetCard({
    required this.date,
    required this.league,
    required this.home,
    required this.away,
    required this.score,
    required this.note,
    required this.button,
    required this.onTap,
    this.complete = false,
  });

  final String date;
  final String league;
  final String home;
  final String away;
  final String score;
  final String note;
  final String button;
  final VoidCallback onTap;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      radius: 20,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              StatusPill(label: date, color: FigmaColors.muted),
              const Spacer(),
              SmallMeta(league),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Expanded(
                child: _TeamName(mark: home.substring(0, 1), name: home),
              ),
              SizedBox(width: 88, child: ScoreText(score, size: 34)),
              Expanded(
                child: _TeamName(mark: away.substring(0, 1), name: away),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: TextStyle(
              color: complete ? FigmaColors.green : FigmaColors.pink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 22),
          PrimaryCta(
            label: button,
            icon: complete ? Icons.refresh_rounded : Icons.edit_note_rounded,
            onPressed: onTap,
            color: complete ? const Color(0xFF303137) : FigmaColors.blueSoft,
          ),
        ],
      ),
    );
  }
}

class _TeamName extends StatelessWidget {
  const _TeamName({required this.mark, required this.name});

  final String mark;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeamMark(label: mark, size: 48, color: FigmaColors.blue),
        const SizedBox(height: 10),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: FigmaColors.text, fontSize: 16),
        ),
      ],
    );
  }
}
