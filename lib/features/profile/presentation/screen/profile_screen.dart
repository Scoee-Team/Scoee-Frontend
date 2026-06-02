import 'package:flutter/material.dart';

import '../../../rankings/presentation/screen/ranking_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RankingAndMyScreen(activeMy: true);
  }
}
