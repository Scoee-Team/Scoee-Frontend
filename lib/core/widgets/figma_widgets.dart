import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';

class FigmaColors {
  const FigmaColors._();

  static const page = Color(0xFF050505);
  static const appBar = Color(0xFF101115);
  static const card = Color(0xFF121212);
  static const cardAlt = Color(0xFF1B1C21);
  static const border = Color(0xFF27282D);
  static const text = Color(0xFFE7E7EC);
  static const muted = Color(0xFF969BA8);
  static const dim = Color(0xFF646A78);
  static const blue = Color(0xFF3E90FF);
  static const blueSoft = Color(0xFFA9C6FF);
  static const green = Color(0xFF47E266);
  static const red = Color(0xFFFF6B65);
  static const pink = Color(0xFFFFB4AB);
}

class FigmaPage extends StatelessWidget {
  const FigmaPage({
    required this.child,
    this.bottomNavIndex,
    this.backgroundColor = FigmaColors.page,
    super.key,
  });

  final Widget child;
  final int? bottomNavIndex;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: DecoratedBox(
            decoration: BoxDecoration(color: backgroundColor),
            child: Stack(
              children: [
                Positioned.fill(child: child),
                if (bottomNavIndex != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: FigmaBottomNav(activeIndex: bottomNavIndex!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FigmaTopBar extends StatelessWidget {
  const FigmaTopBar({
    required this.title,
    this.subtitle,
    this.centerTitle = true,
    this.showBack = false,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool centerTitle;
  final bool showBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: FigmaColors.appBar,
        border: Border(bottom: BorderSide(color: FigmaColors.border)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: centerTitle ? 48 : 0,
            child: showBack
                ? IconButton(
                    onPressed: () =>
                        context.canPop() ? context.pop() : context.go('/'),
                    icon: const Icon(Icons.chevron_left_rounded),
                    color: FigmaColors.blueSoft,
                    iconSize: 32,
                    padding: EdgeInsets.zero,
                  )
                : centerTitle
                ? const Icon(Icons.menu_rounded, color: FigmaColors.blueSoft)
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: centerTitle
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: FigmaColors.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            color: FigmaColors.muted,
                            fontSize: 13,
                            height: 1.2,
                          ),
                        ),
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: FigmaColors.text,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
          ),
          SizedBox(
            width: trailing == null ? 48 : 72,
            child:
                trailing ??
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      color: FigmaColors.blueSoft,
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}

class FigmaBottomNav extends StatelessWidget {
  const FigmaBottomNav({required this.activeIndex, super.key});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem('Home', Icons.home_outlined, Icons.home_rounded, '/'),
      _NavItem(
        'Matches',
        Icons.sports_soccer_outlined,
        Icons.sports_soccer_rounded,
        '/matches',
      ),
      _NavItem('Rooms', Icons.groups_outlined, Icons.groups_rounded, '/rooms'),
      _NavItem(
        'Ranking',
        Icons.bar_chart_rounded,
        Icons.bar_chart_rounded,
        '/ranking',
      ),
      _NavItem(
        'My',
        Icons.person_outline_rounded,
        Icons.person_rounded,
        '/profile',
      ),
    ];

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            color: FigmaColors.appBar,
            border: Border(top: BorderSide(color: FigmaColors.border)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < items.length; i++)
                _BottomNavButton(
                  item: items[i],
                  active: i == activeIndex,
                  onTap: () => context.go(items[i].route),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.icon, this.activeIcon, this.route);

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
}

class _BottomNavButton extends StatelessWidget {
  const _BottomNavButton({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final _NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? FigmaColors.green : FigmaColors.muted;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 68,
        height: 58,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(active ? item.activeIcon : item.icon, color: color, size: 23),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FigmaCard extends StatelessWidget {
  const FigmaCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = FigmaColors.card,
    this.borderColor = FigmaColors.border,
    this.radius = 12,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color borderColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    this.action,
    this.onAction,
    super.key,
  });

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
              color: FigmaColors.text,
              fontSize: 21,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              action!,
              style: const TextStyle(color: FigmaColors.blueSoft, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

class TeamMark extends StatelessWidget {
  const TeamMark({
    required this.label,
    this.size = 48,
    this.color = FigmaColors.blue,
    super.key,
  });

  final String label;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.34), FigmaColors.cardAlt],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.18), blurRadius: 18),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.computeLuminance() > 0.5
              ? Colors.black
              : FigmaColors.text,
          fontSize: size < 44 ? 11 : 13,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill({
    required this.label,
    required this.color,
    this.filled = false,
    super.key,
  });

  final String label;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: filled ? color : color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: filled ? Colors.black : color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}

class PrimaryCta extends StatelessWidget {
  const PrimaryCta({
    required this.label,
    required this.onPressed,
    this.icon,
    this.color = FigmaColors.blue,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 22),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: const Color(0xFF303137),
          foregroundColor: const Color(0xFF052A55),
          disabledForegroundColor: FigmaColors.muted,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

class AppScrollView extends StatelessWidget {
  const AppScrollView({
    required this.children,
    this.topPadding = 80,
    this.bottomPadding = 104,
    super.key,
  });

  final List<Widget> children;
  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20, topPadding, 20, bottomPadding),
      children: children,
    );
  }
}

class SmallMeta extends StatelessWidget {
  const SmallMeta(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: FigmaColors.muted,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
    );
  }
}

class ScoreText extends StatelessWidget {
  const ScoreText(this.text, {this.size = 44, super.key});

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: FigmaColors.text,
        fontSize: size,
        fontWeight: FontWeight.w900,
        height: 1,
      ),
    );
  }
}

const appTextStyle = TextStyle(color: AppColors.primaryText);
