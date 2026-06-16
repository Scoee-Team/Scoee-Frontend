import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({required this.matchId, super.key});

  final int matchId;

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 1,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 80,
            bottomPadding: 92,
            children: [
              const _HeroMatchDetail(),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      label: '리그 순위',
                      value: '1위',
                      meta: '2위 상대',
                      color: FigmaColors.green,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(child: _FormCard()),
                ],
              ),
              const SizedBox(height: 16),
              const _ProbabilityCard(),
              const SizedBox(height: 30),
              SectionTitle(
                title: '활성 예측방',
                action: '전체 보기',
                onAction: () => context.go('/rooms'),
              ),
              const SizedBox(height: 14),
              const _DetailRoomCard(
                icon: Icons.groups_rounded,
                title: '예측 고수 라운지',
                count: '18/20',
                avatars: ['민', '김', '+16'],
              ),
              SizedBox(height: 16),
              const _DetailRoomCard(
                icon: Icons.stars_rounded,
                title: '실력자 전용 예측방',
                count: '5/10',
                avatars: ['지', '+4'],
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 16,
            child: PrimaryCta(
              label: '예측방 만들기',
              icon: Icons.add_circle_outline_rounded,
              onPressed: () => context.go('/rooms/create'),
            ),
          ),
          FigmaTopBar(
            title: '맨시티 VS 아스널',
            subtitle: '경기 상세',
            centerTitle: false,
            showBack: true,
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share_outlined, color: FigmaColors.green),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMatchDetail extends StatelessWidget {
  const _HeroMatchDetail();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 324,
      margin: const EdgeInsets.symmetric(horizontal: -20),
      padding: const EdgeInsets.fromLTRB(20, 34, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF17222A), FigmaColors.page],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _BigTeam(mark: '맨시', name: '맨시티', color: FigmaColors.blue),
              Padding(
                padding: EdgeInsets.only(top: 42),
                child: Column(
                  children: [
                    Text(
                      '매치데이 32',
                      style: TextStyle(
                        color: FigmaColors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.6,
                      ),
                    ),
                    SizedBox(height: 8),
                    ScoreText('21:00', size: 46),
                    SizedBox(height: 8),
                    StatusPill(label: '경기 전', color: FigmaColors.pink),
                  ],
                ),
              ),
              _BigTeam(mark: '아스', name: '아스널', color: FigmaColors.red),
            ],
          ),
          const SizedBox(height: 28),
          const SmallMeta('에티하드 스타디움, 맨체스터'),
          const SizedBox(height: 10),
          const SmallMeta('2024년 4월 26일'),
        ],
      ),
    );
  }
}

class _BigTeam extends StatelessWidget {
  const _BigTeam({required this.mark, required this.name, required this.color});

  final String mark;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 106,
      child: Column(
        children: [
          TeamMark(label: mark, size: 88, color: color),
          const SizedBox(height: 12),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: FigmaColors.text,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.meta,
    required this.color,
  });

  final String label;
  final String value;
  final String meta;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallMeta(label),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          SmallMeta(meta),
        ],
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard();

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SmallMeta('최근 5경기'),
          const SizedBox(height: 16),
          Row(
            children: const [
              _FormDot('승', FigmaColors.green),
              _FormDot('승', FigmaColors.green),
              _FormDot('무', FigmaColors.muted),
              _FormDot('승', FigmaColors.green),
              _FormDot('승', FigmaColors.green),
            ],
          ),
        ],
      ),
    );
  }
}

class _FormDot extends StatelessWidget {
  const _FormDot(this.text, this.color);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.only(right: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _ProbabilityCard extends StatelessWidget {
  const _ProbabilityCard();

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallMeta('승리 확률'),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: const LinearProgressIndicator(
                    value: 0.45,
                    minHeight: 8,
                    backgroundColor: FigmaColors.dim,
                    valueColor: AlwaysStoppedAnimation(FigmaColors.blueSoft),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SmallMeta('평균 득점'),
              SizedBox(height: 6),
              Text(
                '2.8',
                style: TextStyle(
                  color: FigmaColors.text,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailRoomCard extends StatelessWidget {
  const _DetailRoomCard({
    required this.icon,
    required this.title,
    required this.count,
    required this.avatars,
  });

  final IconData icon;
  final String title;
  final String count;
  final List<String> avatars;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: FigmaColors.blue.withValues(alpha: 0.28),
                child: Icon(icon, color: FigmaColors.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: FigmaColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              StatusPill(label: count, color: FigmaColors.muted),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (final avatar in avatars)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: TeamMark(
                    label: avatar,
                    size: 24,
                    color: FigmaColors.pink,
                  ),
                ),
              const Spacer(),
              const Flexible(
                child: Text(
                  '방 참여하기',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: FigmaColors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
