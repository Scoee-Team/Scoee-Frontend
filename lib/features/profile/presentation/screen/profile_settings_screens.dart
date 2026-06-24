import 'package:flutter/material.dart';

import '../../../../core/widgets/figma_widgets.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSubPage(
      title: '프로필 설정',
      subtitle: '닉네임과 대표 이미지를 관리합니다',
      children: [
        _ProfilePreviewCard(),
        SizedBox(height: 18),
        _TextFieldCard(label: '닉네임', value: '민우'),
        SizedBox(height: 20),
        _TextFieldCard(label: '상태 메시지', value: '이번 주 평균 편차 줄이기'),
      ],
    );
  }
}

class FavoriteSettingsScreen extends StatelessWidget {
  const FavoriteSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSubPage(
      title: '관심 리그와 팀',
      subtitle: '홈 화면 추천 기준을 변경합니다',
      children: [
        _SectionLabel('관심 리그'),
        SizedBox(height: 10),
        _ChoiceWrap(
          selected: ['프리미어리그', '챔피언스리그'],
          unselected: ['라리가', '세리에 A', '분데스리가'],
        ),
        SizedBox(height: 24),
        _SectionLabel('관심 팀'),
        SizedBox(height: 10),
        _ChoiceWrap(
          selected: ['맨시티', '아스널', '리버풀'],
          unselected: ['토트넘', '레알 마드리드', '바르셀로나'],
        ),
      ],
    );
  }
}

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSubPage(
      title: '알림 설정',
      subtitle: '예측 마감과 결과 알림을 관리합니다',
      children: [
        _ToggleCard(
          title: '예측 마감 알림',
          subtitle: '마감 10분 전에 알려드려요.',
          value: true,
        ),
        SizedBox(height: 12),
        _ToggleCard(
          title: '경기 결과 알림',
          subtitle: '결과가 확정되면 편차를 확인할 수 있어요.',
          value: true,
        ),
        SizedBox(height: 12),
        _ToggleCard(
          title: '친구 참여 알림',
          subtitle: '초대한 친구가 예측방에 들어오면 알려드려요.',
          value: false,
        ),
      ],
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSubPage(
      title: '도움말',
      subtitle: '예측방과 편차 계산 안내',
      children: [
        _InfoCard(
          title: '스코어 예측은 어떻게 하나요?',
          body: '경기 시작 전까지 홈팀과 원정팀의 최종 스코어를 입력합니다. 마감 이후에는 수정할 수 없어요.',
        ),
        SizedBox(height: 12),
        _InfoCard(
          title: '편차는 어떻게 계산되나요?',
          body:
              '편차는 홈 스코어 차이와 원정 스코어 차이를 더해서 계산합니다. 최종 결과는 백엔드 결과를 기준으로 표시됩니다.',
        ),
        SizedBox(height: 12),
        _InfoCard(
          title: '꼴찌는 어떻게 정해지나요?',
          body: '방 안에서 총 편차가 가장 큰 참여자가 오늘의 꼴찌로 표시됩니다. 동률일 경우 방의 규칙을 따릅니다.',
        ),
      ],
    );
  }
}

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSubPage(
      title: '약관 및 개인정보',
      subtitle: '서비스 이용 정책을 확인합니다',
      children: [
        _PlainActionCard(
          title: '서비스 이용약관',
          subtitle: 'Scoee 이용에 필요한 기본 약관입니다.',
        ),
        SizedBox(height: 12),
        _PlainActionCard(
          title: '개인정보 처리방침',
          subtitle: '계정 정보와 알림 데이터 처리 기준을 확인합니다.',
        ),
        SizedBox(height: 12),
        _PlainActionCard(
          title: '오픈소스 라이선스',
          subtitle: '앱에서 사용하는 라이브러리 라이선스입니다.',
        ),
      ],
    );
  }
}

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSubPage(
      title: '앱 정보',
      subtitle: 'Scoee 1.0.0',
      children: [
        _AppInfoCard(),
        SizedBox(height: 18),
        _InfoCard(
          title: 'Scoee',
          body: '친구들과 경기 스코어를 예측하고, 결과 확정 후 편차를 확인하는 축구 예측 앱입니다.',
        ),
      ],
    );
  }
}

class _ProfileSubPage extends StatelessWidget {
  const _ProfileSubPage({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 4,
      child: Stack(
        children: [
          AppScrollView(topPadding: 96, children: children),
          FigmaTopBar(
            title: title,
            subtitle: subtitle,
            centerTitle: false,
            showBack: true,
          ),
        ],
      ),
    );
  }
}

class _ProfilePreviewCard extends StatelessWidget {
  const _ProfilePreviewCard();

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      child: Column(
        children: [
          Row(
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
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 6),
                    SmallMeta('참여 중인 예측방 2개 · 평균 편차 2.4'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: TextButton(
              onPressed: () => _showProfileImageSheet(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.10),
                    width: 0.5,
                  ),
                ),
                foregroundColor: FigmaColors.blue,
              ),
              child: const Text(
                '프로필 이미지 수정하기',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProfileImageSheet(BuildContext context) {
    showModalBottomSheet<void>(
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
                  '프로필 이미지 수정',
                  style: TextStyle(
                    color: FigmaColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                _UploadOption(
                  title: '사진에서 선택',
                  subtitle: '기기에 저장된 이미지를 사용합니다.',
                  onTap: () => Navigator.of(context).pop(),
                ),
                _UploadOption(
                  title: '카메라로 촬영',
                  subtitle: '새 프로필 이미지를 촬영합니다.',
                  onTap: () => Navigator.of(context).pop(),
                ),
                _UploadOption(
                  title: '기본 이미지로 변경',
                  subtitle: '현재 프로필 이미지를 기본 상태로 되돌립니다.',
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UploadOption extends StatelessWidget {
  const _UploadOption({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
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
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: FigmaColors.muted,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: FigmaColors.muted,
        size: 22,
      ),
    );
  }
}

class _TextFieldCard extends StatelessWidget {
  const _TextFieldCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      style: const TextStyle(color: FigmaColors.text),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}

class _ToggleCard extends StatelessWidget {
  const _ToggleCard({
    required this.title,
    required this.subtitle,
    required this.value,
  });

  final String title;
  final String subtitle;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _TextBlock(title: title, subtitle: subtitle),
          ),
          Switch.adaptive(value: value, onChanged: (_) {}),
        ],
      ),
    );
  }
}

class _PlainActionCard extends StatelessWidget {
  const _PlainActionCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _TextBlock(title: title, subtitle: subtitle),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: FigmaColors.muted,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(16),
      child: _TextBlock(title: title, subtitle: body),
    );
  }
}

class _AppInfoCard extends StatelessWidget {
  const _AppInfoCard();

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: const [
          Text(
            'Scoee',
            style: TextStyle(
              color: FigmaColors.text,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          SmallMeta('Version 1.0.0'),
        ],
      ),
    );
  }
}

class _ChoiceWrap extends StatelessWidget {
  const _ChoiceWrap({required this.selected, required this.unselected});

  final List<String> selected;
  final List<String> unselected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final label in selected) _ChoiceChip(label: label, selected: true),
        for (final label in unselected)
          _ChoiceChip(label: label, selected: false),
      ],
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? Colors.white : FigmaColors.cardAlt,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.10),
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
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: FigmaColors.text,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _TextBlock extends StatelessWidget {
  const _TextBlock({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: FigmaColors.text,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: FigmaColors.muted,
            fontSize: 12,
            height: 1.35,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
