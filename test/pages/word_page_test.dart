import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordstock/app.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../repository/word/dummy_not_word_repository.dart';
import '../repository/word/dummy_word_repository.dart';

//共通化する　ProviderScope
final _testApp = ProviderScope(
  overrides: [
    sqliteRepositoryProvider.overrideWithValue(DummyWordRepository())
  ],
  child: const App(),
);

final _notApp = ProviderScope(
  overrides: [
    sqliteRepositoryProvider.overrideWithValue(DummyNotWordRepository())
  ],
  child: const App(),
);

void wordPageTest() {
  group('単語一覧画面', () {
    testWidgets('単語一覧画面の表示（１つ以上ある場合)', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      //word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();

      // 1フレーム目
      expect(find.text('frontName'), findsNothing);
      expect(find.text('TEST開始'), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.text('frontName'), findsOneWidget);
      expect(find.text('TEST開始'), findsOneWidget);
    });

    testWidgets('単語一覧画面の表示（何もない場合)', (WidgetTester tester) async {
      await tester.pumpWidget(_notApp);

      // 再描画
      await tester.pump();

      //word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();

      // 1フレーム目
      expect(find.text('frontName'), findsNothing);
      expect(find.text('TEST開始'), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.text('frontName'), findsNothing);
      expect(find.text('TEST開始'), findsOneWidget);
    });

    testWidgets('単語登録画面遷移（1つ以上ある場合)', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      // word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // 登録画面
      await tester.tap(find.byIcon(Icons.post_add));

      // 再描画
      await tester.pump();
      await tester.pump();

      // 1フレーム目
      expect(find.text('カード作成'), findsOneWidget);
      expect(find.text('完了'), findsOneWidget);
      expect(find.text('1枚目のカード'), findsOneWidget);

      // 2フレーム目
      await tester.pump();
      expect(find.text('2枚目のカード'), findsOneWidget);

      // 3フレーム目
      await tester.pump();
      expect(find.text('3枚目のカード'), findsOneWidget);

      //TODO: 4枚目5枚目 解決できない
    });

    testWidgets('単語登録画面遷移（何もない場合)', (WidgetTester tester) async {
      await tester.pumpWidget(_notApp);

      // 再描画
      await tester.pump();

      // word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // 登録画面
      await tester.tap(find.byIcon(Icons.post_add));

      // 再描画
      await tester.pump();
      await tester.pump();

      // 1フレーム目
      expect(find.text('カード作成'), findsOneWidget);
      expect(find.text('完了'), findsOneWidget);
      expect(find.text('1枚目のカード'), findsOneWidget);

      // 2フレーム目
      await tester.pump();
      expect(find.text('2枚目のカード'), findsOneWidget);

      // 3フレーム目
      await tester.pump();
      expect(find.text('3枚目のカード'), findsOneWidget);
    });

    //TODO: 4枚目5枚目 解決できない

    testWidgets('単語編集画面遷移', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      // word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // 編集画面遷移
      await tester.tap(find.byIcon(Icons.description));

      // 再描画
      await tester.pump();

      // 1フレーム目
      expect(find.text('frontName'), findsOneWidget);
      expect(find.text('backName'), findsNothing);
      expect(find.byIcon(Icons.mode_edit), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      //TODO: await tester.pump(); findsNothing 解決できない
      //expect(find.text('v'), findsNothing);
      expect(find.text('backName'), findsOneWidget);
      expect(find.byIcon(Icons.mode_edit), findsOneWidget);
    });

    testWidgets('単語削除画面遷移', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      // word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // Listスライド
      await tester.drag(
          find.byIcon(Icons.description), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      // 1ケース目
      expect(find.byIcon(Icons.description), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);

      // 再描画
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      // 2ケース目
      expect(find.byIcon(Icons.description), findsNothing);
      expect(find.byIcon(Icons.delete), findsNothing);
    });
  });
}
