import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:wordstock/model/folder/folder.dart';
import 'package:wordstock/pages/folder_page/folder_controller.dart';

class FolderRegistrationPage extends ConsumerWidget {
  const FolderRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final dateTextController = TextEditingController(text: '');

    final controlFolderProvider = ref.read(folderProvider.notifier);

/*==============================================================================
【登録画面】
==============================================================================*/

    return Scaffold(
      body: AlertDialog(
        title: const Text('フォルダ名入力'),
        content: TextField(
          inputFormatters: [LengthLimitingTextInputFormatter(20)],
          controller: dateTextController,
          decoration: const InputDecoration(
            hintText: "フォルダ名",
          ),
          autofocus: true,
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () {
              final String uid = const Uuid().v4();
              final Folder register = Folder(
                  id: uid, name: dateTextController.text, tableName: 'folders');
              controlFolderProvider.registerData(register);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
