import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scoee_front/main.dart';

void main() {
  testWidgets('renders Scoee home screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ScoeeApp()));

    expect(find.text('The Loser'), findsOneWidget);
    expect(find.text('오늘의 주요 경기'), findsOneWidget);

    await tester.drag(find.text('오늘의 주요 경기'), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('참여 중인 예측방'), findsOneWidget);
  });
}
