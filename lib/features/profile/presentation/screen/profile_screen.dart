import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 4,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            children: [
              _ProfileHeader(onTap: () => context.go('/profile/edit')),
              const SizedBox(height: 14),
              const _FavoritePreferencePanel(),
              const SizedBox(height: 22),
              const _SettingsSection(
                title: '계정',
                items: [
                  _SettingsItem(
                    title: '알림 설정',
                    route: '/profile/notifications',
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const _SettingsSection(
                title: '서비스',
                items: [
                  _SettingsItem(title: '도움말', route: '/profile/help'),
                  _SettingsItem(title: '약관 및 개인정보', route: '/profile/policies'),
                  _SettingsItem(title: '앱 정보', route: '/profile/about'),
                ],
              ),
              const SizedBox(height: 22),
              _LogoutButton(onTap: () => context.go('/onboarding')),
            ],
          ),
          const FigmaTopBar(
            title: '내 정보',
            subtitle: '계정과 설정',
            centerTitle: false,
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: const FigmaCard(
          child: Row(
            children: [
              TeamMark(label: '민', size: 64, color: FigmaColors.blueSoft),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '민우',
                      style: TextStyle(
                        color: FigmaColors.text,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 6),
                    SmallMeta('참여 중인 예측방 2개 · 평균 편차 2.4'),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: FigmaColors.muted,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoritePreferencePanel extends StatelessWidget {
  const _FavoritePreferencePanel();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showFavoriteSheet(context),
        borderRadius: BorderRadius.circular(18),
        child: FigmaCard(
          color: FigmaColors.cardAlt,
          radius: 18,
          padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '관심 리그와 팀',
                      style: TextStyle(
                        color: FigmaColors.text,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _FavoriteTag('프리미어리그'),
                        _FavoriteTag('챔피언스리그'),
                        _FavoriteTag('맨시티'),
                        _FavoriteTag('아스널'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '수정',
                style: TextStyle(
                  color: FigmaColors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFavoriteSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _FavoriteSelectionSheet(),
    );
  }
}

class _FavoriteTag extends StatelessWidget {
  const _FavoriteTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: FigmaColors.text,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _FavoriteSelectionSheet extends StatefulWidget {
  const _FavoriteSelectionSheet();

  @override
  State<_FavoriteSelectionSheet> createState() =>
      _FavoriteSelectionSheetState();
}

class _FavoriteSelectionSheetState extends State<_FavoriteSelectionSheet> {
  final Set<String> _selectedLeagues = {'프리미어리그', '챔피언스리그'};
  final Set<String> _selectedTeams = {'맨시티', '아스널'};

  static const _leagues = ['프리미어리그', '챔피언스리그', '라리가', '세리에 A', '분데스리가'];
  static const _teams = ['맨시티', '아스널', '리버풀', '토트넘', '레알 마드리드', '바르셀로나'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: const BoxDecoration(
          color: FigmaColors.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '관심 리그와 팀',
              style: TextStyle(
                color: FigmaColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 22),
            const _SheetSectionLabel('리그'),
            const SizedBox(height: 10),
            _SelectableWrap(
              items: _leagues,
              selected: _selectedLeagues,
              onToggle: (value) => _toggle(_selectedLeagues, value),
            ),
            const SizedBox(height: 24),
            const _SheetSectionLabel('팀'),
            const SizedBox(height: 10),
            _SelectableWrap(
              items: _teams,
              selected: _selectedTeams,
              onToggle: (value) => _toggle(_selectedTeams, value),
            ),
            const SizedBox(height: 26),
            PrimaryCta(
              label: '저장하기',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _toggle(Set<String> target, String value) {
    setState(() {
      if (!target.add(value)) {
        target.remove(value);
      }
    });
  }
}

class _SheetSectionLabel extends StatelessWidget {
  const _SheetSectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: FigmaColors.muted,
        fontSize: 13,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _SelectableWrap extends StatelessWidget {
  const _SelectableWrap({
    required this.items,
    required this.selected,
    required this.onToggle,
  });

  final List<String> items;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final item in items)
          _SelectableChip(
            label: item,
            selected: selected.contains(item),
            onTap: () => onToggle(item),
          ),
      ],
    );
  }
}

class _SelectableChip extends StatelessWidget {
  const _SelectableChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.10),
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : FigmaColors.text,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.items});

  final String title;
  final List<_SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: FigmaColors.text,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        FigmaCard(
          color: FigmaColors.cardAlt,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                items[i],
                if (i != items.length - 1)
                  const Divider(
                    height: 1,
                    color: FigmaColors.border,
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({required this.title, required this.route});

  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(route),
      child: SizedBox(
        height: 44,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: FigmaColors.text,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: FigmaColors.muted,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.logout_rounded),
      label: const Text('로그아웃'),
      style: OutlinedButton.styleFrom(
        foregroundColor: FigmaColors.muted,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
