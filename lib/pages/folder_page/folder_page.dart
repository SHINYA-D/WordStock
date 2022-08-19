import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wordstock/model/folder/folder.dart';
import 'package:wordstock/pages/folder_page/folder_controller.dart';
import 'package:wordstock/pages/folder_page/folder_registration_page.dart';

class FolderPage extends ConsumerWidget {
  const FolderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersState = ref.watch(folderProvider);

    final foldersCtl = ref.read(folderProvider.notifier);

/*==============================================================================
【フォルダ画面】
==============================================================================*/
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'WordStock',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SlidableAutoCloseBehavior(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: foldersState.when(
            data: (foldersProvider) => ListView.builder(
              itemCount: foldersProvider.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.pushNamed(context, "/folder_edit",
                              arguments: index);
                        },
                        backgroundColor: Colors.black,
                        icon: Icons.settings,
                        label: '編集',
                      ),
                      SlidableAction(
                        onPressed: (_) {
                          try {
                            final selectFolder = foldersProvider[index];
                            foldersCtl.deleteData(selectFolder, index);
                          } catch (e) {
                            AlertDialog(
                              title: const Text('フォルダ削除でエラーが発生しました'),
                              actions: <Widget>[
                                GestureDetector(
                                  child: const Text('閉じる'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          }
                        },
                        backgroundColor: Colors.black,
                        icon: Icons.delete,
                        label: '削除',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: _buildFolderList(index, foldersProvider, context),
                  ),
                );
              },
            ),
            error: (error, _) => AlertDialog(
              title: const Text('フォルダ名表示中に発生しました。'),
              actions: <Widget>[
                GestureDetector(
                  child: const Text('閉じる'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 530.h),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const FolderRegistrationPage();
                });
          },
          child: const Icon(
            Icons.create_new_folder,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

/*==============================================================================
【フォルダリストの生成】
==============================================================================*/
Widget _buildFolderList(
        int i, List<Folder> foldersProvider, BuildContext context) =>
    Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          color: Colors.white,
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final String? folderIdNum = foldersProvider[i].id;
                Navigator.pushNamed(context, "/word_page",
                    arguments: folderIdNum);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.folder,
                    size: 60.sp,
                    color: Colors.black,
                  ),
                  Text(
                    foldersProvider[i].name ?? '値が入っていません！',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
