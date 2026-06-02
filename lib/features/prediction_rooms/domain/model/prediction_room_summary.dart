enum PredictionRoomStatus {
  open,
  partiallyLocked,
  locked,
  completed;

  String get label => switch (this) {
    PredictionRoomStatus.open => 'OPEN',
    PredictionRoomStatus.partiallyLocked => 'PARTIALLY_LOCKED',
    PredictionRoomStatus.locked => 'LOCKED',
    PredictionRoomStatus.completed => 'COMPLETED',
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
