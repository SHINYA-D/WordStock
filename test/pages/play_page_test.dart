import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordstock/app.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../repository/play/dummy_play_repository.dart';

//共通化する　ProviderScope
final _testApp = ProviderScope(
  overrides: [
    sqliteRepositoryProvider.overrideWithValue(DummyPlayRepository())
  ],
  child: const App(),
);

void playPageTest() {
  group('PLAY画面', () {
    testWidgets('PLAY画面の表示（BADボタン押下）', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      //word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // Play画面遷移
      await tester.tap(find.text('TEST開始'));

      // 再描画
      await tester.pumpAndSettle();

      // Play画面　1フレーム目
      expect(find.text('frontPlayName'), findsOneWidget);
      expect(find.text('backPlayName'), findsOneWidget);
      expect(find.byIcon(Icons.thumb_down_alt), findsOneWidget);
      expect(find.byIcon(Icons.thumb_up_alt), findsOneWidget);

      // BADボタン押下
      await tester.tap(find.byIcon(Icons.thumb_down_alt));
      await tester.pumpAndSettle();

      // 成績表画面遷移の為非表示になる 2フレーム目
      expect(find.text('frontPlayName'), findsNothing);
      expect(find.text('backPlayName'), findsNothing);
      expect(find.byIcon(Icons.thumb_down_alt), findsNothing);
      expect(find.byIcon(Icons.thumb_up_alt), findsNothing);
    });

    testWidgets('PLAY画面の表示（GOODボタン押下）', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      //word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // Play画面遷移
      await tester.tap(find.text('TEST開始'));

      // 再描画
      await tester.pumpAndSettle();

      // Play画面　1フレーム目
      expect(find.text('frontPlayName'), findsOneWidget);
      expect(find.text('backPlayName'), findsOneWidget);
      expect(find.byIcon(Icons.thumb_down_alt), findsOneWidget);
      expect(find.byIcon(Icons.thumb_up_alt), findsOneWidget);

      // GOODボタン押下
      await tester.tap(find.byIcon(Icons.thumb_up_alt));
      await tester.pumpAndSettle();

      // 成績表画面遷移の為非表示になる 2フレーム目
      expect(find.text('frontPlayName'), findsNothing);
      expect(find.text('backPlayName'), findsNothing);
      expect(find.byIcon(Icons.thumb_down_alt), findsNothing);
      expect(find.byIcon(Icons.thumb_up_alt), findsNothing);
    });

    testWidgets('PLAY画面の表示（成績表表示 BAD押下）', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      //word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // Play画面遷移
      await tester.tap(find.text('TEST開始'));

      // 再描画
      await tester.pumpAndSettle();

      //1フレーム目
      expect(find.text('終了'), findsNothing);
      expect(find.text('間違えた箇所をもう一度'), findsNothing);
      expect(find.text('正解率：0%'), findsNothing);
      expect(find.text('問題数：1'), findsNothing);
      expect(find.text('正：0'), findsNothing);
      expect(find.text('誤：1'), findsNothing);

      // BADボタン押下
      await tester.tap(find.byIcon(Icons.thumb_down_alt));
      await tester.pumpAndSettle();

      //成績表表示画面 2フレーム目
      expect(find.text('終了'), findsOneWidget);
      expect(find.text('間違えた箇所をもう一度'), findsOneWidget);
      expect(find.text('正解率：0%'), findsOneWidget);
      expect(find.text('問題数：1'), findsOneWidget);
      expect(find.text('正：0'), findsOneWidget);
      expect(find.text('誤：1'), findsOneWidget);
    });

    testWidgets('PLAY画面の表示（成績表表示 GOOD押下）', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      //word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // Play画面遷移
      await tester.tap(find.text('TEST開始'));

      // 再描画
      await tester.pumpAndSettle();

      //1フレーム目
      expect(find.text('終了'), findsNothing);
      expect(find.text('間違えた箇所をもう一度'), findsNothing);
      expect(find.text('正解率：0%'), findsNothing);
      expect(find.text('問題数：1'), findsNothing);
      expect(find.text('正：0'), findsNothing);
      expect(find.text('誤：1'), findsNothing);

      // GOODボタン押下
      await tester.tap(find.byIcon(Icons.thumb_up_alt));
      await tester.pumpAndSettle();

      //成績表表示画面 2フレーム目
      expect(find.text('終了'), findsOneWidget);
      expect(find.text('間違えた箇所をもう一度'), findsNothing);
      expect(find.text('正解率：100%'), findsOneWidget);
      expect(find.text('問題数：1'), findsOneWidget);
      expect(find.text('正：1'), findsOneWidget);
      expect(find.text('誤：0'), findsOneWidget);
    });
  });
}
