import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/model/folder/folder.dart';
import 'package:wordstock/pages/folder_page/folder_controller.dart';

class FolderEditPage extends ConsumerWidget {
  const FolderEditPage({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final int index = args as int;

    final dateTextController = TextEditingController(text: '');

    final foldersState = ref.watch(folderProvider);

    final foldersCtl = ref.read(folderProvider.notifier);
/*==============================================================================
【編集画面】
==============================================================================*/

    return Scaffold(
      body: AlertDialog(
        title: const Text('フォルダ名入力'),
        content: TextField(
          inputFormatters: [LengthLimitingTextInputFormatter(20)],
          controller: dateTextController,
          decoration: const InputDecoration(
            hintText: '新フォルダネームを入力してください',
          ),
          autofocus: true,
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
          foldersState.when(
            data: (foldersProvider) => ElevatedButton(
              onPressed: () {
                Folder up = foldersProvider[index];
                up = up.copyWith(name: dateTextController.text);
                foldersCtl.upData(up);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
            error: (error, _) => Text('エラーが発生しました。\n ${error.toString()}'),
            loading: () => const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
