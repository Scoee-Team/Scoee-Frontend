import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.paddingOf(context).top;

    return FigmaPage(
      bottomNavIndex: 0,
      backgroundColor: _AppleHomeColors.background,
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(20, safeTop + 82, 20, 28),
            children: [
              const _HomeHeader(),
              const SizedBox(height: 28),
              _SectionHeader(
                title: '오늘의 주요 경기',
                action: '전체 보기',
                onAction: () => context.go('/matches'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: [
                    _FeaturedMatchCard(
                      league: '프리미어리그',
                      time: '오늘 21:30',
                      home: '맨시티',
                      away: '아스널',
                      homeMark: 'MCI',
                      awayMark: 'ARS',
                      status: '예측 가능',
                      onTap: () => context.go('/matches/1001'),
                    ),
                    const SizedBox(width: 12),
                    _FeaturedMatchCard(
                      league: '라리가',
                      time: '내일 04:00',
                      home: '레알',
                      away: '바르사',
                      homeMark: 'RMA',
                      awayMark: 'BAR',
                      status: '마감됨',
                      isLocked: true,
                      onTap: () => context.go('/matches/1002'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const _SectionHeader(title: '참여 중인 예측방'),
              const SizedBox(height: 12),
              _RoomTile(
                icon: Icons.person_2_rounded,
                title: '프리미어리그 28R 정복자',
                meta: '예측 완료 · 현재 12위 / 50명',
                badge: '진행중',
                onTap: () => context.go('/rooms/10'),
              ),
              const SizedBox(height: 10),
              _RoomTile(
                icon: Icons.emoji_events_rounded,
                title: '챔스 토너먼트 마스터',
                meta: '2경기 미입력 · 마감 4시간 전',
                badge: '미입력',
                emphasized: true,
                onTap: () => context.go('/rooms/11'),
              ),
              const SizedBox(height: 30),
              const _SectionHeader(title: '추천 경기'),
              const SizedBox(height: 12),
              const _RecommendedMatchTile(
                title: '인터 밀란 VS AC 밀란',
                meta: '세리에 A · 05:45',
                first: 'INT',
                second: 'MIL',
              ),
              SizedBox(height: 10),
              const _RecommendedMatchTile(
                title: '바이에른 VS 도르트문트',
                meta: '분데스리가 · 내일 02:30',
                first: 'BAY',
                second: 'BVB',
                saved: true,
              ),
            ],
          ),
          const _TranslucentTopBar(),
        ],
      ),
    );
  }
}

class _AppleHomeColors {
  const _AppleHomeColors._();

  static const background = Color(0xFF000000);
  static const surface = Color(0xFF161616);
  static const text = Color(0xFFF5F5F7);
  static const secondary = Color(0xFFAEAEB2);
  static const tertiary = Color(0xFF6E6E73);
  static const accent = Color(0xFF0A84FF);
}

class _TranslucentTopBar extends StatelessWidget {
  const _TranslucentTopBar();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          height: topInset + 60,
          padding: EdgeInsets.fromLTRB(20, topInset, 16, 0),
          decoration: BoxDecoration(
            color: _AppleHomeColors.background.withValues(alpha: 0.72),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Scoee',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _AppleHomeColors.text,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
              ),
              _IconCircle(icon: Icons.notifications_none_rounded, onTap: () {}),
              const SizedBox(width: 8),
              _IconCircle(icon: Icons.person_outline_rounded, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '6월 16일 화요일',
          style: TextStyle(
            color: _AppleHomeColors.tertiary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '오늘의 스코어를\n가볍게 예측해보세요.',
          style: TextStyle(
            color: _AppleHomeColors.text,
            fontSize: 31,
            fontWeight: FontWeight.w800,
            height: 1.12,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _AppleHomeColors.text,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: _AppleHomeColors.accent,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              action!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ),
      ],
    );
  }
}

class _FeaturedMatchCard extends StatelessWidget {
  const _FeaturedMatchCard({
    required this.league,
    required this.time,
    required this.home,
    required this.away,
    required this.homeMark,
    required this.awayMark,
    required this.status,
    required this.onTap,
    this.isLocked = false,
  });

  final String league;
  final String time;
  final String home;
  final String away;
  final String homeMark;
  final String awayMark;
  final String status;
  final VoidCallback onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 282,
      child: _AppleCard(
        onTap: isLocked ? null : onTap,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _MetaText('$league · $time')),
                _QuietPill(label: status, active: !isLocked),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _TeamBlock(mark: homeMark, name: home),
                ),
                const SizedBox(width: 12),
                const Text(
                  'VS',
                  style: TextStyle(
                    color: _AppleHomeColors.tertiary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TeamBlock(mark: awayMark, name: away, alignEnd: true),
                ),
              ],
            ),
            const Spacer(),
            _InlineAction(
              label: isLocked ? '결과 보기' : '예측하기',
              icon: isLocked
                  ? Icons.check_circle_outline_rounded
                  : Icons.chevron_right_rounded,
              onTap: isLocked ? onTap : onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamBlock extends StatelessWidget {
  const _TeamBlock({
    required this.mark,
    required this.name,
    this.alignEnd = false,
  });

  final String mark;
  final String name;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        _TeamBadge(label: mark),
        const SizedBox(height: 12),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: alignEnd ? TextAlign.end : TextAlign.start,
          style: const TextStyle(
            color: _AppleHomeColors.text,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
      ],
    );
  }
}

class _TeamBadge extends StatelessWidget {
  const _TeamBadge({required this.label, this.size = 54});

  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: _AppleHomeColors.text,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}

class _RoomTile extends StatelessWidget {
  const _RoomTile({
    required this.icon,
    required this.title,
    required this.meta,
    required this.badge,
    required this.onTap,
    this.emphasized = false,
  });

  final IconData icon;
  final String title;
  final String meta;
  final String badge;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return _AppleCard(
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: emphasized
                  ? _AppleHomeColors.accent.withValues(alpha: 0.18)
                  : Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: emphasized
                  ? _AppleHomeColors.accent
                  : _AppleHomeColors.secondary,
              size: 22,
            ),
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
                    color: _AppleHomeColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                _MetaText(meta),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _QuietPill(label: badge, active: emphasized),
          const SizedBox(width: 6),
          const Icon(
            Icons.chevron_right_rounded,
            color: _AppleHomeColors.tertiary,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _RecommendedMatchTile extends StatelessWidget {
  const _RecommendedMatchTile({
    required this.title,
    required this.meta,
    required this.first,
    required this.second,
    this.saved = false,
  });

  final String title;
  final String meta;
  final String first;
  final String second;
  final bool saved;

  @override
  Widget build(BuildContext context) {
    return _AppleCard(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      child: Row(
        children: [
          SizedBox(
            width: 58,
            height: 44,
            child: Stack(
              children: [
                _TeamBadge(label: first, size: 40),
                Positioned(
                  left: 20,
                  child: _TeamBadge(label: second, size: 40),
                ),
              ],
            ),
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
                    color: _AppleHomeColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                _MetaText(meta),
              ],
            ),
          ),
          Icon(
            saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            color: saved ? _AppleHomeColors.accent : _AppleHomeColors.tertiary,
            size: 23,
          ),
        ],
      ),
    );
  }
}

class _AppleCard extends StatelessWidget {
  const _AppleCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _AppleHomeColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.32),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: content,
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: IconButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.09),
          foregroundColor: _AppleHomeColors.text,
          shape: const CircleBorder(),
        ),
        icon: Icon(icon, size: 20),
      ),
    );
  }
}

class _InlineAction extends StatelessWidget {
  const _InlineAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: _AppleHomeColors.accent,
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 36),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        icon: Icon(icon, size: 19),
      ),
    );
  }
}

class _QuietPill extends StatelessWidget {
  const _QuietPill({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: active
            ? _AppleHomeColors.accent.withValues(alpha: 0.16)
            : Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: active ? _AppleHomeColors.accent : _AppleHomeColors.secondary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}

class _MetaText extends StatelessWidget {
  const _MetaText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: _AppleHomeColors.secondary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
    );
  }
}
