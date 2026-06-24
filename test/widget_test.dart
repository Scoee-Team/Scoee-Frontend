import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scoee/main.dart';

void main() {
  testWidgets('Scoee 홈 화면을 렌더링한다', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ScoeeApp()));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('홈'), findsOneWidget);
    expect(find.text('경기'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
