import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordstock/app.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../repository/dummy_not_word_repository.dart';
import '../repository/dummy_repository.dart';

//共通化する　ProviderScope
final _testApp = ProviderScope(
  overrides: [sqliteRepositoryProvider.overrideWithValue(DummyRepository())],
  child: const App(),
);

final _notApp = ProviderScope(
  overrides: [
    sqliteRepositoryProvider.overrideWithValue(DummyNotWordRepository())
  ],
  child: const App(),
);

void WordPageTest() {
  group('単語一覧画面', () {
    testWidgets('単語一覧画面の表示（１つ以上ある場合)', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();
      await tester.tap(find.byIcon(Icons.folder));

      await tester.pump();
      // 1フレーム目
      expect(find.text('frontName'), findsNothing);

      await tester.pump();
      // 2フレーム目
      expect(find.text('frontName'), findsOneWidget);
    });

    testWidgets('単語一覧画面の表示（何もない場合)', (WidgetTester tester) async {
      await tester.pumpWidget(_notApp);

      // 再描画
      await tester.pump();
      await tester.tap(find.byIcon(Icons.folder));

      await tester.pump();
      // 1フレーム目
      expect(find.text('frontName'), findsNothing);

      await tester.pump();
      // 2フレーム目
      expect(find.text('frontName'), findsNothing);
    });

    testWidgets('単語登録画面遷移（1つ以上ある場合)', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();
      await tester.tap(find.byIcon(Icons.folder));

      await tester.pump();
      await tester.pump();

      await tester.tap(find.byIcon(Icons.post_add));
      await tester.pump();
      await tester.pump();
      expect(find.text('カード作成'), findsOneWidget);
    });
  });
}
