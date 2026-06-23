import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      bottomNavIndex: 2,
      child: Stack(
        children: [
          AppScrollView(
            topPadding: 96,
            bottomPadding: 100,
            children: [
              const SmallMeta('예측방 유형'),
              const SizedBox(height: 10),
              const Text(
                '친구들과 함께 예측할 경기를 선택하세요',
                style: TextStyle(
                  color: FigmaColors.text,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 24),
              const _RoomTextField(label: '방 제목', hint: '주말 프리미어리그 예측방'),
              const SizedBox(height: 16),
              const _TypeSelector(),
              const SizedBox(height: 24),
              const SectionTitle(title: '선택한 경기'),
              const SizedBox(height: 14),
              const _SelectedMatch(
                title: '맨시티 VS 아스널',
                meta: '프리미어리그 37R · 2024.05.19 00:30',
              ),
              SizedBox(height: 12),
              const _SelectedMatch(
                title: '리버풀 VS 울버햄튼',
                meta: '프리미어리그 37R · 2024.05.18 23:00',
              ),
              SizedBox(height: 24),
              const _DeadlinePanel(),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 16,
            child: PrimaryCta(
              label: '예측방 만들기',
              icon: Icons.add_circle_outline_rounded,
              onPressed: () => context.go('/rooms/10'),
            ),
          ),
          const FigmaTopBar(
            title: '예측방 만들기',
            subtitle: '경기와 마감 방식을 선택하세요',
            centerTitle: false,
            showBack: true,
          ),
        ],
      ),
    );
  }
}

class _RoomTextField extends StatelessWidget {
  const _RoomTextField({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        style: const TextStyle(color: FigmaColors.text),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _TypeSelector extends StatelessWidget {
  const _TypeSelector();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: FigmaColors.cardAlt,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _TypeChip(label: '단일 경기', selected: true)),
          Expanded(child: _TypeChip(label: '여러 경기', selected: false)),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.black : FigmaColors.muted,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SelectedMatch extends StatelessWidget {
  const _SelectedMatch({required this.title, required this.meta});

  final String title;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return FigmaCard(
      color: FigmaColors.cardAlt,
      child: Row(
        children: [
          const TeamMark(label: '프리', size: 44, color: FigmaColors.blue),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: FigmaColors.text, fontSize: 16),
                ),
                SmallMeta(meta),
              ],
            ),
          ),
          const Icon(Icons.close_rounded, color: FigmaColors.muted),
        ],
      ),
    );
  }
}

class _DeadlinePanel extends StatelessWidget {
  const _DeadlinePanel();

  @override
  Widget build(BuildContext context) {
    return const FigmaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '예측 마감 방식',
            style: TextStyle(
              color: FigmaColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 16),
          _DeadlineOption(label: '경기 시작 전 자동 마감', selected: true),
          _DeadlineOption(label: '모든 경기 같은 시간에 마감', selected: false),
        ],
      ),
    );
  }
}

class _DeadlineOption extends StatelessWidget {
  const _DeadlineOption({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_off_rounded,
            color: selected ? FigmaColors.blue : FigmaColors.muted,
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: FigmaColors.text)),
        ],
      ),
    );
  }
}
