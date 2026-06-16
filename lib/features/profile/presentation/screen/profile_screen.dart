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
              const _ProfileHeader(),
              const SizedBox(height: 24),
              const _SettingsSection(
                title: '계정',
                items: [
                  _SettingsItem(
                    icon: Icons.person_outline_rounded,
                    title: '프로필 설정',
                    subtitle: '닉네임과 대표 이미지를 관리합니다',
                  ),
                  _SettingsItem(
                    icon: Icons.favorite_border_rounded,
                    title: '관심 리그와 팀',
                    subtitle: '홈 화면 추천 기준을 변경합니다',
                  ),
                  _SettingsItem(
                    icon: Icons.notifications_none_rounded,
                    title: '알림 설정',
                    subtitle: '예측 마감과 결과 알림을 관리합니다',
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const _SettingsSection(
                title: '서비스',
                items: [
                  _SettingsItem(
                    icon: Icons.help_outline_rounded,
                    title: '도움말',
                    subtitle: '예측방과 편차 계산 안내',
                  ),
                  _SettingsItem(
                    icon: Icons.policy_outlined,
                    title: '약관 및 개인정보',
                    subtitle: '서비스 이용 정책을 확인합니다',
                  ),
                  _SettingsItem(
                    icon: Icons.info_outline_rounded,
                    title: '앱 정보',
                    subtitle: 'Scoee 1.0.0',
                  ),
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
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      child: Row(
        children: const [
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
          Icon(Icons.chevron_right_rounded, color: FigmaColors.muted),
        ],
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
                    indent: 64,
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
  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 32,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: FigmaColors.blue.withValues(alpha: 0.16),
        child: Icon(icon, color: FigmaColors.blueSoft, size: 20),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: FigmaColors.text,
          fontSize: 15.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: FigmaColors.muted,
          fontSize: 11.5,
          height: 1.25,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: FigmaColors.muted,
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
        foregroundColor: FigmaColors.pink,
        side: BorderSide(color: FigmaColors.pink.withValues(alpha: 0.45)),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
