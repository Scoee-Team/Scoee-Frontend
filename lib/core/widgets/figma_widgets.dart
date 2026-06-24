import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

import '../constants/app_colors.dart';

class FigmaColors {
  const FigmaColors._();

  static const page = Color(0xFF000000);
  static const appBar = Color(0xB8000000);
  static const card = Color(0xFF161616);
  static const cardAlt = Color(0xFF1C1C1E);
  static const border = Color(0xFF2C2C2E);
  static const text = Color(0xFFF5F5F7);
  static const muted = Color(0xFFAEAEB2);
  static const dim = Color(0xFF6E6E73);
  static const blue = Color(0xFF0A84FF);
  static const blueSoft = Color(0xFF64A8FF);
  static const green = Color(0xFF0A84FF);
  static const red = Color(0xFFFF453A);
  static const pink = Color(0xFFFF9F0A);
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
    final content = SafeArea(
      top: false,
      bottom: bottomNavIndex == null,
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final shouldConstrain = constraints.maxWidth > 430;
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: shouldConstrain ? 390 : double.infinity,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(color: backgroundColor),
                child: child,
              ),
            );
          },
        ),
      ),
    );

    if (bottomNavIndex != null) {
      return content;
    }

    return Scaffold(backgroundColor: backgroundColor, body: content);
  }
}

class FigmaShellScaffold extends StatelessWidget {
  const FigmaShellScaffold({
    required this.child,
    this.activeIndex,
    this.onDestinationSelected,
    super.key,
  });

  final Widget child;
  final int? activeIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final resolvedIndex = activeIndex ?? _indexForLocation(location);

    return Scaffold(
      backgroundColor: FigmaColors.page,
      body: child,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: FigmaColors.appBar,
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 0.5,
                ),
              ),
            ),
            child: FigmaBottomNav(
              activeIndex: resolvedIndex,
              onDestinationSelected:
                  onDestinationSelected ??
                  (index) {
                    final route = switch (index) {
                      0 => '/',
                      1 => '/matches',
                      2 => '/rooms',
                      3 => '/ranking',
                      _ => '/profile',
                    };
                    if (route != location) {
                      context.go(route);
                    }
                  },
            ),
          ),
        ),
      ),
    );
  }

  int _indexForLocation(String location) {
    if (location.startsWith('/matches')) return 1;
    if (location.startsWith('/rooms')) return 2;
    if (location.startsWith('/ranking')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }
}

class FigmaScreenScope extends StatelessWidget {
  const FigmaScreenScope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final shouldConstrain = constraints.maxWidth > 430;
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: shouldConstrain ? 390 : double.infinity,
            ),
            child: child,
          );
        },
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
    final topInset = MediaQuery.paddingOf(context).top;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          height: topInset + 60,
          padding: EdgeInsets.fromLTRB(20, topInset, 16, 0),
          decoration: BoxDecoration(
            color: FigmaColors.appBar,
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: showBack
                    ? 40
                    : centerTitle
                    ? 48
                    : 0,
                child: showBack
                    ? IconButton(
                        onPressed: () => _goBack(context),
                        icon: const Icon(Icons.chevron_left_rounded),
                        color: FigmaColors.blue,
                        iconSize: 30,
                        padding: EdgeInsets.zero,
                      )
                    : centerTitle
                    ? const Icon(Icons.menu_rounded, color: FigmaColors.blue)
                    : const SizedBox.shrink(),
              ),
              if (showBack && !centerTitle) const SizedBox(width: 8),
              Expanded(
                child: centerTitle
                    ? Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: FigmaColors.text,
                          fontSize: 22,
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: FigmaColors.dim,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: FigmaColors.text,
                              fontSize: 21,
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
                          color: FigmaColors.blue,
                        ),
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }

    final path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/matches/')) {
      context.go('/matches');
      return;
    }
    if (path == '/rooms/create') {
      context.go('/rooms');
      return;
    }
    if (path.startsWith('/rooms/') &&
        (path.endsWith('/predict') || path.endsWith('/result'))) {
      context.go(path.substring(0, path.lastIndexOf('/')));
      return;
    }
    if (path.startsWith('/rooms/')) {
      context.go('/rooms');
      return;
    }
    if (path.startsWith('/profile/')) {
      context.go('/profile');
      return;
    }
    context.go('/');
  }
}

class FigmaBottomNav extends StatelessWidget {
  const FigmaBottomNav({
    required this.activeIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int activeIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final items = const [
      _NavItem('홈', Icons.home_outlined, Icons.home_rounded),
      _NavItem('경기', Icons.sports_soccer_outlined, Icons.sports_soccer_rounded),
      _NavItem('예측방', Icons.groups_outlined, Icons.groups_rounded),
      _NavItem('랭킹', Icons.bar_chart_rounded, Icons.bar_chart_rounded),
      _NavItem('내 정보', Icons.person_outline_rounded, Icons.person_rounded),
    ];

    return SafeArea(
      top: false,
      child: _MaterialBottomNav(
        activeIndex: activeIndex,
        items: items,
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}

class _MaterialBottomNav extends StatelessWidget {
  const _MaterialBottomNav({
    required this.activeIndex,
    required this.items,
    required this.onDestinationSelected,
  });

  final int activeIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              color: selected ? FigmaColors.blue : FigmaColors.dim,
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              height: 1.1,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              color: selected ? FigmaColors.blue : FigmaColors.dim,
              size: 23,
            );
          }),
        ),
      ),
      child: NavigationBar(
        selectedIndex: activeIndex,
        height: 76,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          for (var i = 0; i < items.length; i++)
            NavigationDestination(
              icon: Icon(items[i].icon),
              selectedIcon: Icon(items[i].activeIcon),
              label: items[i].label,
            ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.icon, this.activeIcon);

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

class FigmaCard extends StatelessWidget {
  const FigmaCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = FigmaColors.card,
    this.borderColor = FigmaColors.border,
    this.radius = 20,
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
        border: Border.all(color: borderColor, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
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
              fontSize: 20,
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
              style: const TextStyle(
                color: FigmaColors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
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
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(size * 0.16),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: TextStyle(
              color: FigmaColors.text,
              fontSize: size < 44 ? 11 : 14,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: filled
            ? Colors.white.withValues(alpha: 0.10)
            : color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.30), width: 0.5),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: filled ? FigmaColors.text : color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
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
    final foreground = FigmaColors.text;
    final style = FilledButton.styleFrom(
      backgroundColor: color,
      disabledBackgroundColor: const Color(0xFF242426),
      foregroundColor: foreground,
      disabledForegroundColor: FigmaColors.dim,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      minimumSize: const Size(0, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 1.15,
      ),
    );
    final text = FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: icon == null
          ? FilledButton(onPressed: onPressed, style: style, child: text)
          : FilledButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 19),
              label: text,
              style: style,
            ),
    );
  }
}

class AppScrollView extends StatelessWidget {
  const AppScrollView({
    required this.children,
    this.topPadding = 80,
    this.bottomPadding = 24,
    super.key,
  });

  final List<Widget> children;
  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.paddingOf(context).top;

    return ListView(
      padding: EdgeInsets.fromLTRB(20, safeTop + topPadding, 20, bottomPadding),
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
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: FigmaColors.muted,
        fontSize: 11.5,
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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: FigmaColors.text,
          fontSize: size,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}

const appTextStyle = TextStyle(color: AppColors.primaryText);
