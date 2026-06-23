import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  var _selectedDayIndex = 0;
  String? _selectedLeague;
  var _favoritesOnly = false;

  static const _days = [
    _MatchDay(month: '6월', day: '23', weekday: '화', key: '2026-06-23'),
    _MatchDay(month: '6월', day: '24', weekday: '수', key: '2026-06-24'),
    _MatchDay(month: '6월', day: '25', weekday: '목', key: '2026-06-25'),
    _MatchDay(month: '6월', day: '26', weekday: '금', key: '2026-06-26'),
    _MatchDay(month: '6월', day: '27', weekday: '토', key: '2026-06-27'),
    _MatchDay(month: '6월', day: '28', weekday: '일', key: '2026-06-28'),
  ];

  static const _matches = [
    _MatchItem(
      id: 1001,
      dateKey: '2026-06-23',
      league: '프리미어리그',
      time: '22:00',
      home: '아스널',
      away: '리버풀',
      homeMark: 'ARS',
      awayMark: 'LIV',
      score: '2 - 1',
      status: '진행중',
      statusTone: _StatusTone.warning,
      footer: '예측 가능',
      favorite: true,
    ),
    _MatchItem(
      id: 1002,
      dateKey: '2026-06-23',
      league: '프리미어리그',
      time: '00:30',
      home: '맨시티',
      away: '토트넘',
      homeMark: 'MCI',
      awayMark: 'TOT',
      score: 'VS',
      status: '예정',
      statusTone: _StatusTone.primary,
      footer: '2시간 뒤 열림',
      favorite: true,
    ),
    _MatchItem(
      id: 1003,
      dateKey: '2026-06-23',
      league: '라리가',
      time: '04:00',
      home: '레알 마드리드',
      away: '바르셀로나',
      homeMark: 'RMA',
      awayMark: 'BAR',
      score: '3 - 0',
      status: '종료',
      statusTone: _StatusTone.muted,
    ),
    _MatchItem(
      id: 1004,
      dateKey: '2026-06-24',
      league: '세리에 A',
      time: '03:45',
      home: '인터 밀란',
      away: 'AC 밀란',
      homeMark: 'INT',
      awayMark: 'MIL',
      score: 'VS',
      status: '예정',
      statusTone: _StatusTone.primary,
      footer: '방 만들기 가능',
      favorite: true,
    ),
    _MatchItem(
      id: 1005,
      dateKey: '2026-06-25',
      league: '분데스리가',
      time: '02:30',
      home: '바이에른',
      away: '도르트문트',
      homeMark: 'BAY',
      awayMark: 'BVB',
      score: 'VS',
      status: '예정',
      statusTone: _StatusTone.primary,
      footer: '예측 가능',
    ),
    _MatchItem(
      id: 1006,
      dateKey: '2026-06-27',
      league: '프리미어리그',
      time: '21:30',
      home: '첼시',
      away: '맨유',
      homeMark: 'CHE',
      awayMark: 'MUN',
      score: 'VS',
      status: '예정',
      statusTone: _StatusTone.primary,
      footer: '예측 가능',
      favorite: true,
    ),
  ];

  List<String> get _leagues {
    final leagues = _matches.map((match) => match.league).toSet().toList();
    leagues.sort();
    return leagues;
  }

  List<_MatchItem> get _filteredMatches {
    final selectedDateKey = _days[_selectedDayIndex].key;

    return _matches.where((match) {
      if (match.dateKey != selectedDateKey) return false;
      if (_selectedLeague != null && match.league != _selectedLeague) {
        return false;
      }
      if (_favoritesOnly && !match.favorite) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final matchesByLeague = <String, List<_MatchItem>>{};
    for (final match in _filteredMatches) {
      matchesByLeague.putIfAbsent(match.league, () => []).add(match);
    }

    return FigmaPage(
      bottomNavIndex: 1,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            children: [
              _DateScroller(
                days: _days,
                selectedIndex: _selectedDayIndex,
                onSelected: (index) =>
                    setState(() => _selectedDayIndex = index),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: _showLeagueSelector,
                    icon: const Icon(Icons.line_style_rounded, size: 18),
                    label: Text(_selectedLeague ?? '전체 리그'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: FigmaColors.text,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const SmallMeta('관심 팀만'),
                  const SizedBox(width: 8),
                  Switch.adaptive(
                    value: _favoritesOnly,
                    onChanged: (value) => setState(() {
                      _favoritesOnly = value;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (matchesByLeague.isEmpty)
                _EmptyMatchesView(
                  onReset: () => setState(() {
                    _selectedLeague = null;
                    _favoritesOnly = false;
                  }),
                )
              else
                for (final entry in matchesByLeague.entries) ...[
                  _LeagueGroup(
                    title: entry.key,
                    children: [
                      for (var i = 0; i < entry.value.length; i++) ...[
                        _MatchCard(
                          match: entry.value[i],
                          onTap: () =>
                              context.go('/matches/${entry.value[i].id}'),
                        ),
                        if (i != entry.value.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
            ],
          ),
          const FigmaTopBar(
            title: '경기',
            subtitle: '날짜와 리그로 경기 찾기',
            centerTitle: false,
            trailing: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Future<void> _showLeagueSelector() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: FigmaColors.card,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  '리그 선택',
                  style: TextStyle(
                    color: FigmaColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                _LeagueOption(
                  title: '전체 리그',
                  selected: _selectedLeague == null,
                  onTap: () => Navigator.of(context).pop(_allLeaguesKey),
                ),
                for (final league in _leagues)
                  _LeagueOption(
                    title: league,
                    selected: _selectedLeague == league,
                    onTap: () => Navigator.of(context).pop(league),
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (!mounted) return;
    if (selected == null) return;
    setState(() {
      _selectedLeague = selected == _allLeaguesKey ? null : selected;
    });
  }
}

const _allLeaguesKey = '__all__';

class _DateScroller extends StatelessWidget {
  const _DateScroller({
    required this.days,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<_MatchDay> days;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final day = days[index];
          final selected = index == selectedIndex;

          return InkWell(
            onTap: () => onSelected(index),
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 58,
              decoration: BoxDecoration(
                color: selected ? Colors.white : FigmaColors.cardAlt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.08),
                  width: 0.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selected ? day.month : day.weekday,
                    style: TextStyle(
                      color: selected ? Colors.black : FigmaColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    day.day,
                    style: TextStyle(
                      color: selected ? Colors.black : FigmaColors.text,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LeagueOption extends StatelessWidget {
  const _LeagueOption({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          color: FigmaColors.text,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check_rounded, color: FigmaColors.blue)
          : null,
    );
  }
}

class _LeagueGroup extends StatelessWidget {
  const _LeagueGroup({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TeamMark(label: title.substring(0, 2).toUpperCase(), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: FigmaColors.text,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...children,
      ],
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({required this.match, required this.onTap});

  final _MatchItem match;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: FigmaCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SmallMeta(match.time),
                const Spacer(),
                StatusPill(
                  label: match.status,
                  color: _statusColor(match.statusTone),
                  filled: match.status == '예정',
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: _TeamSide(
                    mark: match.homeMark,
                    name: match.home,
                    color: FigmaColors.blueSoft,
                  ),
                ),
                SizedBox(
                  width: 96,
                  child: ScoreText(
                    match.score,
                    size: match.score == 'VS' ? 32 : 46,
                  ),
                ),
                Expanded(
                  child: _TeamSide(
                    mark: match.awayMark,
                    name: match.away,
                    color: FigmaColors.blue,
                  ),
                ),
              ],
            ),
            if (match.footer != null) ...[
              const SizedBox(height: 18),
              const Divider(color: FigmaColors.border),
              const SizedBox(height: 8),
              StatusPill(label: match.footer!, color: FigmaColors.blue),
            ],
          ],
        ),
      ),
    );
  }

  Color _statusColor(_StatusTone tone) {
    return switch (tone) {
      _StatusTone.primary => FigmaColors.blue,
      _StatusTone.warning => FigmaColors.pink,
      _StatusTone.muted => FigmaColors.muted,
    };
  }
}

class _TeamSide extends StatelessWidget {
  const _TeamSide({
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
        TeamMark(label: mark, size: 40, color: color),
        const SizedBox(height: 10),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: FigmaColors.text, fontSize: 14),
        ),
      ],
    );
  }
}

class _EmptyMatchesView extends StatelessWidget {
  const _EmptyMatchesView({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 24),
      child: Column(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: Colors.white.withValues(alpha: 0.35),
            size: 42,
          ),
          const SizedBox(height: 14),
          const Text(
            '조건에 맞는 경기가 없어요',
            style: TextStyle(
              color: FigmaColors.text,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const SmallMeta('다른 날짜를 선택하거나 필터를 초기화해보세요.'),
          const SizedBox(height: 18),
          TextButton(onPressed: onReset, child: const Text('필터 초기화')),
        ],
      ),
    );
  }
}

class _MatchDay {
  const _MatchDay({
    required this.month,
    required this.day,
    required this.weekday,
    required this.key,
  });

  final String month;
  final String day;
  final String weekday;
  final String key;
}

class _MatchItem {
  const _MatchItem({
    required this.id,
    required this.dateKey,
    required this.league,
    required this.time,
    required this.home,
    required this.away,
    required this.homeMark,
    required this.awayMark,
    required this.score,
    required this.status,
    required this.statusTone,
    this.footer,
    this.favorite = false,
  });

  final int id;
  final String dateKey;
  final String league;
  final String time;
  final String home;
  final String away;
  final String homeMark;
  final String awayMark;
  final String score;
  final String status;
  final _StatusTone statusTone;
  final String? footer;
  final bool favorite;
}

enum _StatusTone { primary, warning, muted }
