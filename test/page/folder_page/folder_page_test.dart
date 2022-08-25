import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordstock/app.dart';

void main() {
  // testWidgets('ListView', (WidgetTester tester) async {
  //
  //   await tester.pumpWidget(
  //     ProviderScope(
  //       child:MaterialApp(
  //         home:Scaffold(
  //           body: ListView.builder(
  //               itemCount: 1,
  //               itemBuilder: (context, index) {
  //                 return const Text('ok');
  //               }
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //
  //   expect(find.text('ok'), findsOneWidget);
  //   expect(find.text('ng'), findsNothing);
  //
  //
  // });

  testWidgets('test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: const App(),
    ));
  });
}
