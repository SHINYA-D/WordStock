import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordstock/app.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../repository/dummy_not_repository.dart';
import '../repository/dummy_repository.dart';

void main() => sam();
void sam(){}

void folderPageTest() {
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

  group('フォルダ一覧画面', () {
    testWidgets('フォルダ一覧画面の表示（1つ以上ある場合)', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      // 1フレーム目
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('testFolderName'), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('testFolderName'), findsOneWidget);
    });

    testWidgets('フォルダ一覧画面の表示（何もない時)', (WidgetTester tester) async {
      await tester.pumpWidget(notApp);

      // 1フレーム目
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('testFolderName'), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('testFolderName'), findsNothing);
    });

    testWidgets('フォルダの登録画面（1つ以上ある場合）', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      // 再描画
      await tester.pump();

      // 1フレーム目
      await tester.tap(find.byIcon(Icons.create_new_folder));
      expect(find.text('フォルダ名入力'), findsNothing);
      expect(find.text('フォルダ名'), findsNothing);
      expect(find.text('OK'), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.text('フォルダ名入力'), findsOneWidget);
      expect(find.text('フォルダ名'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('フォルダの登録画面（何もない時）', (WidgetTester tester) async {
      await tester.pumpWidget(notApp);

      // 再描画
      await tester.pump();

      // 1フレーム目
      await tester.tap(find.byIcon(Icons.create_new_folder));
      expect(find.text('フォルダ名入力'), findsNothing);
      expect(find.text('フォルダ名'), findsNothing);
      expect(find.text('OK'), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.text('フォルダ名入力'), findsOneWidget);
      expect(find.text('フォルダ名'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('フォルダの編集画面', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      // 再描画
      await tester.pump();

      // 1フレーム目
      await tester.drag(find.byIcon(Icons.folder), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);
      await tester.tap(find.byIcon(Icons.settings));
      expect(find.text('フォルダ名入力'), findsNothing);
      expect(find.text('新フォルダネームを入力してください'), findsNothing);
      expect(find.text('OK'), findsNothing);

      // 再描画
      await tester.pump();
      await tester.pump();

      // 2フレーム目
      expect(find.text('フォルダ名入力'), findsOneWidget);
      expect(find.text('新フォルダネームを入力してください'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('フォルダの削除画面', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      // 再描画
      await tester.pump();

      // 1フレーム目
      await tester.drag(find.byIcon(Icons.folder), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);
      await tester.tap(find.byIcon(Icons.delete));
      expect(find.byIcon(Icons.folder), findsOneWidget);

      // 再描画
      await tester.pumpAndSettle();

      // 2フレーム目
      expect(find.byIcon(Icons.folder), findsNothing);
    });
  });
}
