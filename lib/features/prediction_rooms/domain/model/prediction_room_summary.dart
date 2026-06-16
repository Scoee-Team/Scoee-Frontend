enum PredictionRoomStatus {
  open,
  partiallyLocked,
  locked,
  completed;

  String get label => switch (this) {
    PredictionRoomStatus.open => '진행중',
    PredictionRoomStatus.partiallyLocked => '일부 마감',
    PredictionRoomStatus.locked => '마감',
    PredictionRoomStatus.completed => '완료',
  };
}

class PredictionRoomSummary {
  const PredictionRoomSummary({
    required this.id,
    required this.title,
    required this.hostNickname,
    required this.matchCount,
    required this.participantCount,
    required this.status,
    required this.myPredictionLabel,
  });

  final int id;
  final String title;
  final String hostNickname;
  final int matchCount;
  final int participantCount;
  final PredictionRoomStatus status;
  final String myPredictionLabel;
}
