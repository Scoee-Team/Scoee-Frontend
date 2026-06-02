import 'team_summary.dart';

enum MatchStatus {
  scheduled,
  live,
  finished,
  predictionClosed;

  String get label => switch (this) {
    MatchStatus.scheduled => '예정',
    MatchStatus.live => '진행 중',
    MatchStatus.finished => '종료',
    MatchStatus.predictionClosed => '예측 마감',
  };
}

class MatchSummary {
  const MatchSummary({
    required this.id,
    required this.leagueName,
    required this.homeTeam,
    required this.awayTeam,
    required this.kickoffTime,
    required this.status,
    this.homeScore,
    this.awayScore,
  });

  final int id;
  final String leagueName;
  final TeamSummary homeTeam;
  final TeamSummary awayTeam;
  final DateTime kickoffTime;
  final MatchStatus status;
  final int? homeScore;
  final int? awayScore;
}
