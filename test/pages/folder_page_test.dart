import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordstock/app.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../repository/dummy_not_repository.dart';
import '../repository/dummy_repository.dart';

//共通化する　ProviderScope
final _testApp = ProviderScope(
  overrides: [sqliteRepositoryProvider.overrideWithValue(DummyRepository())],
  child: const App(),
);

final _notApp = ProviderScope(
  overrides: [sqliteRepositoryProvider.overrideWithValue(DummyNotRepository())],
  child: const App(),
);

void folderPageTest() {
  group('フォルダ一覧画面', () {
    testWidgets('フォルダ一覧画面の表示（1つ以上ある場合)', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 1フレーム目
      expect(find.byKey(const Key('Loading')), findsOneWidget);
      expect(find.text('testFolderName'), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.byKey(const Key('Loading')), findsNothing);
      expect(find.text('testFolderName'), findsOneWidget);
    });

    testWidgets('フォルダ一覧画面の表示（何もない時)', (WidgetTester tester) async {
      await tester.pumpWidget(_notApp);

      // 1フレーム目
      expect(find.byKey(const Key('Loading')), findsOneWidget);
      expect(find.text('testFolderName'), findsNothing);

      // 再描画
      await tester.pump();

      // 2フレーム目
      expect(find.byKey(const Key('Loading')), findsNothing);
      expect(find.text('testFolderName'), findsNothing);
    });

    testWidgets('フォルダの登録画面遷移（1つ以上ある場合）', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);

      // 再描画
      await tester.pump();

      await tester.tap(find.byIcon(Icons.create_new_folder));
      await tester.pump();
      expect(find.text('フォルダ名入力'), findsOneWidget);
    });

    testWidgets('フォルダの登録画面遷移（何もない時）', (WidgetTester tester) async {
      await tester.pumpWidget(_notApp);

      // 再描画
      await tester.pump();
      await tester.tap(find.byIcon(Icons.create_new_folder));
      await tester.pump();
      expect(find.text('フォルダ名入力'), findsOneWidget);
    });

    testWidgets('フォルダの編集画面遷移', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);
      // 再描画
      //expect(find.byKey(const Key('Slidable')), findsOneWidget);
      await tester.pump();

      find.byWidget(ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            icon: Icons.settings,
          ),
        ],
      ));

      expect(
          find.byWidget(SlidableAction(
            onPressed: (BuildContext context) {},
            icon: Icons.settings,
          )),
          findsOneWidget);
    });

    testWidgets('フォルダの削除画面遷移', (WidgetTester tester) async {
      await tester.pumpWidget(_testApp);
      // 再描画
      await tester.pump();
      find.byWidget(ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            icon: Icons.delete,
          ),
        ],
      ));
    });
  });
}
