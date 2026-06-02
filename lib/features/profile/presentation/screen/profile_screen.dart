import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 정보')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.surfaceAlt,
                child: Icon(Icons.person_outline_rounded),
              ),
              title: Text('Minwoo'),
              subtitle: Text('관심 팀 2개 · 진행 중인 예측방 2개'),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => context.go('/onboarding'),
            icon: const Icon(Icons.tune_rounded),
            label: const Text('관심 리그와 팀 설정'),
          ),
        ],
      ),
    );
  }
}
