import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordstock/app.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../repository/dummy_not_repository.dart';
import '../repository/dummy_repository.dart';

void main() => sam();
void sam(){}

void wordPageTest() {
  final testApp = ProviderScope(
    overrides: [
      sqliteRepositoryProvider
          .overrideWithValue(DummyRepository(playResultScreen: false))
    ],
    child: const App(),
  );

  final notApp = ProviderScope(
    overrides: [
      sqliteRepositoryProvider.overrideWithValue(DummyNotRepository())
    ],
    child: const App(),
  );

  group('単語一覧画面', () {
    testWidgets('単語一覧画面の表示（１つ以上ある場合)', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      // フォルダ作成
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsNothing);
      await tester.tap(find.byIcon(Icons.create_new_folder));
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsOneWidget);

      // word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();

      // 1フレーム目
      expect(find.text('frontName'), findsNothing);
      expect(find.text('TEST開始'), findsNothing);
      expect(find.byIcon(Icons.arrow_back), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.text('frontName'), findsOneWidget);
      expect(find.text('TEST開始'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('単語一覧画面の表示（何もない場合)', (WidgetTester tester) async {
      await tester.pumpWidget(notApp);

      // フォルダ作成
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsNothing);
      await tester.tap(find.byIcon(Icons.create_new_folder));
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsOneWidget);

      // word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();

      // 1フレーム目
      expect(find.text('frontName'), findsNothing);
      expect(find.text('TEST開始'), findsNothing);
      expect(find.byIcon(Icons.arrow_back), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.text('frontName'), findsNothing);
      expect(find.text('TEST開始'), findsNothing);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('単語登録画面（1つ以上ある場合)', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      // フォルダ作成
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsNothing);
      await tester.tap(find.byIcon(Icons.create_new_folder));
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsOneWidget);

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
      expect(find.text('2枚目のカード'), findsOneWidget);
      expect(find.text('3枚目のカード'), findsOneWidget);
      expect(find.text('4枚目のカード'), findsNothing);
      expect(find.text('5枚目のカード'), findsNothing);

      // スクロール
      await tester.dragUntilVisible(
        find.text('3枚目のカード'),
        find.byKey(const ValueKey('4枚目のカード')),
        const Offset(-250, 0),
      );

      // 2フレーム目
      await tester.pump();
      expect(find.text('1枚目のカード'), findsNothing);
      expect(find.text('2枚目のカード'), findsNothing);
      expect(find.text('3枚目のカード'), findsOneWidget);
      expect(find.text('4枚目のカード'), findsOneWidget);
      expect(find.text('5枚目のカード'), findsOneWidget);
    });

    testWidgets('単語登録画面（何もない場合)', (WidgetTester tester) async {
      await tester.pumpWidget(notApp);

      // フォルダ作成
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsNothing);
      await tester.tap(find.byIcon(Icons.create_new_folder));
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsOneWidget);

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
      expect(find.text('2枚目のカード'), findsOneWidget);
      expect(find.text('3枚目のカード'), findsOneWidget);
      expect(find.text('4枚目のカード'), findsNothing);
      expect(find.text('5枚目のカード'), findsNothing);

      // スクロール
      await tester.dragUntilVisible(
        find.text('3枚目のカード'),
        find.byKey(const ValueKey('4枚目のカード')),
        const Offset(-250, 0),
      );

      // 2フレーム目
      await tester.pump();
      expect(find.text('1枚目のカード'), findsNothing);
      expect(find.text('2枚目のカード'), findsNothing);
      expect(find.text('3枚目のカード'), findsOneWidget);
      expect(find.text('4枚目のカード'), findsOneWidget);
      expect(find.text('5枚目のカード'), findsOneWidget);
    });

    testWidgets('単語編集画面', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      // フォルダ作成
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsNothing);
      await tester.tap(find.byIcon(Icons.create_new_folder));
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsOneWidget);

      // word画面遷移
      await tester.tap(find.byIcon(Icons.folder));

      // 再描画
      await tester.pump();
      await tester.pump();

      // 編集画面遷移
      await tester.tap(find.byIcon(Icons.description));

      // 再描画
      await tester.pump();
      await tester.pumpAndSettle();

      // 1フレーム目
      expect(find.text('frontName'), findsOneWidget);
      expect(find.text('backName'), findsOneWidget);
      expect(find.byIcon(Icons.mode_edit), findsOneWidget);

      // 編集画面遷移
      await tester.tap(find.byIcon(Icons.mode_edit));
      await tester.pumpAndSettle();

      // 2フレーム目
      expect(find.text('カード編集'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('CANCEL'), findsOneWidget);
    });

    testWidgets('単語編集画面（スライド）', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      // フォルダ作成
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsNothing);
      await tester.tap(find.byIcon(Icons.create_new_folder));
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(Icons.folder), findsOneWidget);

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
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);

      // 再描画
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // 2フレーム目
      expect(find.text('frontName'), findsOneWidget);
      expect(find.text('backName'), findsOneWidget);
      expect(find.byIcon(Icons.mode_edit), findsOneWidget);
    });
  });
}
