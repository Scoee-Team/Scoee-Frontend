import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../matches/domain/model/match_summary.dart';
import '../../../matches/domain/model/team_summary.dart';
import '../../../matches/presentation/widget/match_card.dart';
import '../../../prediction_rooms/domain/model/prediction_room_summary.dart';
import '../../../prediction_rooms/presentation/widget/room_card.dart';

final upcomingMatchesProvider = Provider<List<MatchSummary>>((ref) {
  final korea = TeamSummary(id: 1, name: 'Korea Republic');
  final japan = TeamSummary(id: 2, name: 'Japan');
  final qatar = TeamSummary(id: 3, name: 'Qatar');
  final ecuador = TeamSummary(id: 4, name: 'Ecuador');

  return [
    MatchSummary(
      id: 1001,
      leagueName: 'FIFA World Cup',
      homeTeam: korea,
      awayTeam: japan,
      kickoffTime: DateTime.now().add(const Duration(hours: 6)),
      status: MatchStatus.scheduled,
    ),
    MatchSummary(
      id: 1002,
      leagueName: 'FIFA World Cup Group A',
      homeTeam: qatar,
      awayTeam: ecuador,
      kickoffTime: DateTime.now().add(const Duration(days: 1, hours: 3)),
      status: MatchStatus.scheduled,
    ),
  ];
});

final activeRoomsProvider = Provider<List<PredictionRoomSummary>>((ref) {
  return const [
    PredictionRoomSummary(
      id: 10,
      title: '오늘 한일전 스코어 예측',
      hostNickname: 'Minwoo',
      matchCount: 1,
      participantCount: 4,
      status: PredictionRoomStatus.open,
      myPredictionLabel: '내 예측 미입력',
    ),
    PredictionRoomSummary(
      id: 11,
      title: '월드컵 조별리그 예측방',
      hostNickname: 'Alex',
      matchCount: 6,
      participantCount: 6,
      status: PredictionRoomStatus.partiallyLocked,
      myPredictionLabel: '4/6경기 입력 완료',
    ),
  ];
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matches = ref.watch(upcomingMatchesProvider);
    final rooms = ref.watch(activeRoomsProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('Scoee'),
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () => context.go('/profile'),
              icon: const Icon(Icons.person_outline_rounded),
              tooltip: '내 정보',
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              Text(
                '친구들과 함께 경기 스코어를 예측해보세요.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '가장 멀리 빗나간 친구가 오늘의 꼴찌입니다.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 28),
              _SectionHeader(
                title: '오늘의 경기',
                actionLabel: '전체 보기',
                onTap: () => context.go('/matches'),
              ),
              const SizedBox(height: 12),
              ...matches.map(
                (match) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MatchCard(
                    match: match,
                    primaryActionLabel: '방 만들기',
                    onTap: () => context.go('/matches/${match.id}'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SectionHeader(
                title: '진행 중인 예측방',
                actionLabel: '방 목록',
                onTap: () => context.go('/rooms'),
              ),
              const SizedBox(height: 12),
              ...rooms.map(
                (room) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RoomCard(
                    room: room,
                    onTap: () => context.go('/rooms/${room.id}'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.go('/rooms/create'),
                icon: const Icon(Icons.add_rounded),
                label: const Text('예측방 만들기'),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        TextButton(onPressed: onTap, child: Text(actionLabel)),
      ],
    );
  }
}
