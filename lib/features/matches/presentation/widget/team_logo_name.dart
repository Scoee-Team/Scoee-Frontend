import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/model/team_summary.dart';

class TeamLogoName extends StatelessWidget {
  const TeamLogoName({required this.team, this.alignEnd = false, super.key});

  final TeamSummary team;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.surfaceAlt,
      child: Text(
        team.name.characters.first,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
    );
    final name = Flexible(
      child: Text(
        team.name,
        overflow: TextOverflow.ellipsis,
        textAlign: alignEnd ? TextAlign.end : TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );

    return Row(
      mainAxisAlignment: alignEnd
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: alignEnd
          ? [name, const SizedBox(width: 10), avatar]
          : [avatar, const SizedBox(width: 10), name],
    );
  }
}
