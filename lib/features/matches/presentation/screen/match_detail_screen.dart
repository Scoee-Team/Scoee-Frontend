import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({required this.matchId, super.key});

  final int matchId;

  @override
  Widget build(BuildContext context) {
    final match = _MatchDetailData.resolve(matchId);

    return FigmaPage(
      bottomNavIndex: 1,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 84,
            bottomPadding: 104,
            children: [
              _MatchHero(match: match),
              const SizedBox(height: 18),
              _DeadlineCard(match: match),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      label: '리그',
                      value: match.league,
                      icon: Icons.emoji_events_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _InfoTile(
                      label: '상태',
                      value: match.status,
                      icon: Icons.timer_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _VenueCard(match: match),
              const SizedBox(height: 28),
              SectionTitle(
                title: '활성 예측방',
                action: '전체 보기',
                onAction: () => context.go('/rooms'),
              ),
              const SizedBox(height: 12),
              if (match.rooms.isEmpty)
                const _EmptyRoomsCard()
              else
                for (final room in match.rooms) ...[
                  _DetailRoomCard(
                    room: room,
                    onTap: () => context.go('/rooms/${room.id}'),
                  ),
                  const SizedBox(height: 10),
                ],
              const SizedBox(height: 20),
              _GuideCard(match: match),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 16,
            child: PrimaryCta(
              label: '예측방 만들기',
              icon: Icons.add_circle_outline_rounded,
              onPressed: match.locked
                  ? null
                  : () => context.go('/rooms/create'),
            ),
          ),
          FigmaTopBar(
            title: '${match.homeName} VS ${match.awayName}',
            subtitle: '경기 상세',
            centerTitle: false,
            showBack: true,
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share_outlined, color: FigmaColors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchHero extends StatelessWidget {
  const _MatchHero({required this.match});

  final _MatchDetailData match;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      child: Column(
        children: [
          Row(
            children: [
              SmallMeta(match.kickoffLabel),
              const Spacer(),
              StatusPill(
                label: match.status,
                color: match.locked ? FigmaColors.muted : FigmaColors.blue,
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: _TeamBlock(
                  mark: match.homeMark,
                  name: match.homeName,
                  subtitle: match.homeSubtitle,
                ),
              ),
              SizedBox(
                width: 92,
                child: Column(
                  children: [
                    ScoreText(match.scoreLabel, size: match.locked ? 42 : 34),
                    const SizedBox(height: 8),
                    Text(
                      match.matchRound,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: FigmaColors.dim,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _TeamBlock(
                  mark: match.awayMark,
                  name: match.awayName,
                  subtitle: match.awaySubtitle,
                  alignEnd: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamBlock extends StatelessWidget {
  const _TeamBlock({
    required this.mark,
    required this.name,
    required this.subtitle,
    this.alignEnd = false,
  });

  final String mark;
  final String name;
  final String subtitle;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        TeamMark(label: mark, size: 62),
        const SizedBox(height: 14),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: alignEnd ? TextAlign.end : TextAlign.start,
          style: const TextStyle(
            color: FigmaColors.text,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: alignEnd ? TextAlign.end : TextAlign.start,
          style: const TextStyle(
            color: FigmaColors.dim,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _DeadlineCard extends StatelessWidget {
  const _DeadlineCard({required this.match});

  final _MatchDetailData match;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: match.locked
                  ? Colors.white.withValues(alpha: 0.08)
                  : FigmaColors.blue.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(
              match.locked ? Icons.lock_outline_rounded : Icons.alarm_rounded,
              color: match.locked ? FigmaColors.muted : FigmaColors.blue,
              size: 21,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallMeta(match.locked ? '예측 상태' : '예측 마감'),
                const SizedBox(height: 5),
                Text(
                  match.deadlineLabel,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: FigmaColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
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

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: FigmaColors.blue, size: 20),
          const SizedBox(height: 12),
          SmallMeta(label),
          const SizedBox(height: 5),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: FigmaColors.text,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _VenueCard extends StatelessWidget {
  const _VenueCard({required this.match});

  final _MatchDetailData match;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: FigmaColors.muted),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.venue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: FigmaColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                SmallMeta(match.location),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRoomCard extends StatelessWidget {
  const _DetailRoomCard({required this.room, required this.onTap});

  final _RoomPreview room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: FigmaCard(
        color: FigmaColors.cardAlt,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.groups_rounded,
                    color: FigmaColors.blue,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: FigmaColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SmallMeta('${room.host} 주최 · ${room.progressLabel}'),
                    ],
                  ),
                ),
                StatusPill(label: room.capacityLabel, color: FigmaColors.muted),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                for (final avatar in room.avatars)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: TeamMark(label: avatar, size: 24),
                  ),
                const Spacer(),
                const Text(
                  '방 보기',
                  style: TextStyle(
                    color: FigmaColors.blue,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyRoomsCard extends StatelessWidget {
  const _EmptyRoomsCard();

  @override
  Widget build(BuildContext context) {
    return const FigmaCard(
      color: FigmaColors.cardAlt,
      padding: EdgeInsets.fromLTRB(18, 22, 18, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '아직 열린 예측방이 없어요',
            style: TextStyle(
              color: FigmaColors.text,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          SmallMeta('첫 예측방을 만들고 친구를 초대해보세요.'),
        ],
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  const _GuideCard({required this.match});

  final _MatchDetailData match;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, color: FigmaColors.muted),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              match.locked
                  ? '경기가 시작된 뒤에는 예측을 수정할 수 없어요. 결과가 확정되면 편차와 꼴찌가 표시됩니다.'
                  : '예측은 마감 전까지 수정할 수 있어요. 실제 결과와의 편차는 경기 종료 후 백엔드 결과를 기준으로 표시됩니다.',
              style: const TextStyle(
                color: FigmaColors.muted,
                fontSize: 13,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchDetailData {
  const _MatchDetailData({
    required this.id,
    required this.league,
    required this.matchRound,
    required this.homeName,
    required this.awayName,
    required this.homeMark,
    required this.awayMark,
    required this.homeSubtitle,
    required this.awaySubtitle,
    required this.kickoffLabel,
    required this.deadlineLabel,
    required this.status,
    required this.scoreLabel,
    required this.venue,
    required this.location,
    required this.rooms,
    this.locked = false,
  });

  final int id;
  final String league;
  final String matchRound;
  final String homeName;
  final String awayName;
  final String homeMark;
  final String awayMark;
  final String homeSubtitle;
  final String awaySubtitle;
  final String kickoffLabel;
  final String deadlineLabel;
  final String status;
  final String scoreLabel;
  final String venue;
  final String location;
  final List<_RoomPreview> rooms;
  final bool locked;

  static _MatchDetailData resolve(int id) {
    return _matches.firstWhere(
      (match) => match.id == id,
      orElse: () => _matches.first,
    );
  }

  static const _matches = [
    _MatchDetailData(
      id: 1001,
      league: '프리미어리그',
      matchRound: '리그 32R',
      homeName: '아스널',
      awayName: '리버풀',
      homeMark: 'ARS',
      awayMark: 'LIV',
      homeSubtitle: '홈',
      awaySubtitle: '원정',
      kickoffLabel: '오늘 22:00',
      deadlineLabel: '오늘 21:50까지 예측 가능',
      status: '진행중',
      scoreLabel: '2:1',
      venue: 'Emirates Stadium',
      location: 'London, England',
      locked: true,
      rooms: [
        _RoomPreview(
          id: 10,
          title: '프리미어리그 32R 예측방',
          host: '민우',
          progressLabel: '12명 예측 완료',
          capacityLabel: '18/20',
          avatars: ['민', '김', '+16'],
        ),
      ],
    ),
    _MatchDetailData(
      id: 1002,
      league: '프리미어리그',
      matchRound: '리그 32R',
      homeName: '맨시티',
      awayName: '토트넘',
      homeMark: 'MCI',
      awayMark: 'TOT',
      homeSubtitle: '홈',
      awaySubtitle: '원정',
      kickoffLabel: '오늘 00:30',
      deadlineLabel: '경기 시작 10분 전 자동 마감',
      status: '예정',
      scoreLabel: 'VS',
      venue: 'Etihad Stadium',
      location: 'Manchester, England',
      rooms: [
        _RoomPreview(
          id: 11,
          title: '주말 프리미어리그 예측방',
          host: '지훈',
          progressLabel: '5명 미입력',
          capacityLabel: '9/12',
          avatars: ['지', '박', '+7'],
        ),
        _RoomPreview(
          id: 12,
          title: '회사 축구 모임',
          host: '수민',
          progressLabel: '초대 전용',
          capacityLabel: '4/8',
          avatars: ['수', '+3'],
        ),
      ],
    ),
    _MatchDetailData(
      id: 1003,
      league: '라리가',
      matchRound: '리그 29R',
      homeName: '레알 마드리드',
      awayName: '바르셀로나',
      homeMark: 'RMA',
      awayMark: 'BAR',
      homeSubtitle: '홈',
      awaySubtitle: '원정',
      kickoffLabel: '오늘 04:00',
      deadlineLabel: '예측 마감 시간이 지났어요',
      status: '종료',
      scoreLabel: '3:0',
      venue: 'Santiago Bernabeu',
      location: 'Madrid, Spain',
      locked: true,
      rooms: [],
    ),
    _MatchDetailData(
      id: 1004,
      league: '세리에 A',
      matchRound: '리그 31R',
      homeName: '인터 밀란',
      awayName: 'AC 밀란',
      homeMark: 'INT',
      awayMark: 'MIL',
      homeSubtitle: '홈',
      awaySubtitle: '원정',
      kickoffLabel: '내일 03:45',
      deadlineLabel: '내일 03:35까지 예측 가능',
      status: '예정',
      scoreLabel: 'VS',
      venue: 'San Siro',
      location: 'Milan, Italy',
      rooms: [],
    ),
    _MatchDetailData(
      id: 1005,
      league: '분데스리가',
      matchRound: '리그 30R',
      homeName: '바이에른',
      awayName: '도르트문트',
      homeMark: 'BAY',
      awayMark: 'BVB',
      homeSubtitle: '홈',
      awaySubtitle: '원정',
      kickoffLabel: '6월 25일 02:30',
      deadlineLabel: '경기 시작 10분 전 자동 마감',
      status: '예정',
      scoreLabel: 'VS',
      venue: 'Allianz Arena',
      location: 'Munich, Germany',
      rooms: [],
    ),
    _MatchDetailData(
      id: 1006,
      league: '프리미어리그',
      matchRound: '리그 33R',
      homeName: '첼시',
      awayName: '맨유',
      homeMark: 'CHE',
      awayMark: 'MUN',
      homeSubtitle: '홈',
      awaySubtitle: '원정',
      kickoffLabel: '6월 27일 21:30',
      deadlineLabel: '6월 27일 21:20까지 예측 가능',
      status: '예정',
      scoreLabel: 'VS',
      venue: 'Stamford Bridge',
      location: 'London, England',
      rooms: [
        _RoomPreview(
          id: 13,
          title: '빅매치 스코어 예측',
          host: '현아',
          progressLabel: '3명 참여',
          capacityLabel: '3/10',
          avatars: ['현', '+2'],
        ),
      ],
    ),
  ];
}

class _RoomPreview {
  const _RoomPreview({
    required this.id,
    required this.title,
    required this.host,
    required this.progressLabel,
    required this.capacityLabel,
    required this.avatars,
  });

  final int id;
  final String title;
  final String host;
  final String progressLabel;
  final String capacityLabel;
  final List<String> avatars;
}
