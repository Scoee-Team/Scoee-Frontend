import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  var _filter = _RoomFilter.all;

  static const _rooms = [
    _RoomItem(
      id: 10,
      title: '주말 프리미어리그 예측방',
      type: '여러 경기',
      status: '미입력',
      statusTone: _RoomStatusTone.warning,
      meta: '5경기 중 2경기 입력 · 마감 4시간 전',
      progress: '2/5',
      participants: '12명',
      host: '민우',
      avatars: ['민', '김', '+10'],
      needsInput: true,
    ),
    _RoomItem(
      id: 11,
      title: '챔스 토너먼트 마스터',
      type: '여러 경기',
      status: '완료',
      statusTone: _RoomStatusTone.primary,
      meta: '예측 완료 · 현재 12위 / 50명',
      progress: '5/5',
      participants: '50명',
      host: '지훈',
      avatars: ['지', '박', '+48'],
      completed: true,
    ),
    _RoomItem(
      id: 12,
      title: '오늘 한 경기만',
      type: '단일 경기',
      status: '진행중',
      statusTone: _RoomStatusTone.primary,
      meta: '맨시티 VS 토트넘 · 마감 2시간 전',
      progress: '1/1',
      participants: '6명',
      host: '수민',
      avatars: ['수', '현', '+4'],
    ),
  ];

  List<_RoomItem> get _filteredRooms {
    return _rooms.where((room) {
      return switch (_filter) {
        _RoomFilter.all => true,
        _RoomFilter.needsInput => room.needsInput,
        _RoomFilter.completed => room.completed,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = _filteredRooms;

    return FigmaPage(
      bottomNavIndex: 2,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            children: [
              _RoomFilterBar(
                selected: _filter,
                onChanged: (filter) => setState(() => _filter = filter),
              ),
              const SizedBox(height: 18),
              if (rooms.isEmpty)
                _EmptyRoomsView(
                  onReset: () => setState(() => _filter = _RoomFilter.all),
                )
              else
                for (final room in rooms) ...[
                  _RoomListTile(
                    room: room,
                    onTap: () => context.go('/rooms/${room.id}'),
                  ),
                  const SizedBox(height: 12),
                ],
              const SizedBox(height: 18),
              PrimaryCta(
                label: '예측방 만들기',
                icon: Icons.add_circle_outline_rounded,
                onPressed: () => context.go('/rooms/create'),
              ),
            ],
          ),
          FigmaTopBar(
            title: '예측방',
            subtitle: '참여 중인 방',
            centerTitle: false,
            trailing: IconButton(
              onPressed: () => context.go('/rooms/create'),
              icon: const Icon(Icons.add_rounded, color: FigmaColors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomFilterBar extends StatelessWidget {
  const _RoomFilterBar({required this.selected, required this.onChanged});

  final _RoomFilter selected;
  final ValueChanged<_RoomFilter> onChanged;

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
              label: '전체',
              active: selected == _RoomFilter.all,
              onTap: () => onChanged(_RoomFilter.all),
            ),
          ),
          Expanded(
            child: _FilterSegment(
              label: '미입력',
              active: selected == _RoomFilter.needsInput,
              onTap: () => onChanged(_RoomFilter.needsInput),
            ),
          ),
          Expanded(
            child: _FilterSegment(
              label: '완료',
              active: selected == _RoomFilter.completed,
              onTap: () => onChanged(_RoomFilter.completed),
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

class _RoomListTile extends StatelessWidget {
  const _RoomListTile({required this.room, required this.onTap});

  final _RoomItem room;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                      SmallMeta('${room.host} 주최 · ${room.type}'),
                    ],
                  ),
                ),
                StatusPill(
                  label: room.status,
                  color: _statusColor(room.statusTone),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              room.meta,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: FigmaColors.muted,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                for (final avatar in room.avatars)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: TeamMark(label: avatar, size: 24),
                  ),
                const Spacer(),
                _RoomMetric(label: '예측', value: room.progress),
                const SizedBox(width: 14),
                _RoomMetric(label: '참여', value: room.participants),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: FigmaColors.dim,
                  size: 22,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(_RoomStatusTone tone) {
    return switch (tone) {
      _RoomStatusTone.primary => FigmaColors.blue,
      _RoomStatusTone.warning => FigmaColors.pink,
      _RoomStatusTone.muted => FigmaColors.muted,
    };
  }
}

class _RoomMetric extends StatelessWidget {
  const _RoomMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: FigmaColors.text,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: FigmaColors.dim,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _EmptyRoomsView extends StatelessWidget {
  const _EmptyRoomsView({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 24),
      child: Column(
        children: [
          Icon(
            Icons.groups_outlined,
            color: Colors.white.withValues(alpha: 0.35),
            size: 42,
          ),
          const SizedBox(height: 14),
          const Text(
            '조건에 맞는 예측방이 없어요',
            style: TextStyle(
              color: FigmaColors.text,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const SmallMeta('다른 상태를 선택하거나 새 예측방을 만들어보세요.'),
          const SizedBox(height: 18),
          TextButton(onPressed: onReset, child: const Text('필터 초기화')),
        ],
      ),
    );
  }
}

class _RoomItem {
  const _RoomItem({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.statusTone,
    required this.meta,
    required this.progress,
    required this.participants,
    required this.host,
    required this.avatars,
    this.needsInput = false,
    this.completed = false,
  });

  final int id;
  final String title;
  final String type;
  final String status;
  final _RoomStatusTone statusTone;
  final String meta;
  final String progress;
  final String participants;
  final String host;
  final List<String> avatars;
  final bool needsInput;
  final bool completed;
}

enum _RoomFilter { all, needsInput, completed }

enum _RoomStatusTone { primary, warning, muted }
