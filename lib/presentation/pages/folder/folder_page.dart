import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';
import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/presentation/pages/folder/folder_controller.dart';
import 'package:wordstock/presentation/pages/folder/user_page.dart';

class FolderPage extends ConsumerWidget {
  const FolderPage(this.uid, {Key? key}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersState = ref.watch(folderProvider);

    final foldersCtl = ref.read(folderProvider.notifier);

    //登録処理テキスト
    final dateRegistrationTextCtr = TextEditingController(text: '');
    //編集処理テキスト
    final dateEditTextCtr = TextEditingController(text: '');

    final animationListKey = GlobalKey<AnimatedListState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    const animationDuration = Duration(milliseconds: 500);

/*==============================================================================
【フォルダ画面】
==============================================================================*/
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () async {
              //アカウント情報
              scaffoldKey.currentState!.openDrawer();
            }),
        title: const Text('フォルダ一覧'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                //ログアウト
                await FirebaseAuth.instance.signOut();
              }),
        ],
      ),
      body: SlidableAutoCloseBehavior(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: foldersState.when(
            data: (foldersState) => AnimatedList(
              key: animationListKey,
              initialItemCount: foldersState.length,
              itemBuilder: (context, index, animation) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // Navigator.pushNamed(context, "/folder_edit_page",
                          //     arguments: index);
                          _buildEdit(context, dateEditTextCtr, foldersCtl,
                              foldersState, index);
                        },
                        icon: Icons.settings,
                        label: '編集',
                      ),
                      SlidableAction(
                        onPressed: (_) {
                          try {
                            animationListKey.currentState?.removeItem(
                              index, //データ住所（番号指定検索）
                              (context, animation) {
                                //削除する処理の内容↓
                                // Widget一覧から削除された後にStateから削除
                                animation.addStatusListener((listener) {
                                  if (listener == AnimationStatus.dismissed) {
                                    final selectFolder = foldersState[index];
                                    foldersCtl.deleteData(selectFolder, index);
                                  }
                                });
                                return _buildFolder(
                                  foldersState[index],
                                  context,
                                  animation,
                                );
                              },
                              duration: animationDuration, //移動感間隔
                            );
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
                        icon: Icons.delete,
                        label: '削除',
                      ),
                    ],
                  ),
                  child: _buildFolder(
                    foldersState[index],
                    context,
                    animation,
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
      drawer: DrawerPage(uid),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _buildRegistration(context, dateRegistrationTextCtr, foldersCtl);
        },
        child: const Icon(
          Icons.create_new_folder,
        ),
      ),
    );
  }
}

/*==============================================================================
【フォルダの生成】
==============================================================================*/
Widget _buildFolder(
  Folder folder,
  BuildContext context,
  Animation<double> animation,
) =>
    SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
        child: Container(
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
          ),
          child: ElevatedButton(
            onPressed: () {
              final folderIdNum = folder.id;
              Navigator.pushNamed(context, "/word_page",
                  arguments: folderIdNum);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.folder,
                  size: 60.sp,
                ),
                Text(
                  folder.name ?? '値が入っていません！',
                  style: const TextStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );

/*==============================================================================
【フォルダ登録】
==============================================================================*/
_buildRegistration(
        BuildContext context,
        TextEditingController dateRegistrationTextCtr,
        FolderController foldersCtl) =>
    showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AlertDialog(
              title: const Text('フォルダ名入力'),
              content: TextField(
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
                controller: dateRegistrationTextCtr,
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
                    try {
                      final uid = const Uuid().v4();
                      final Folder register =
                          Folder(id: uid, name: dateRegistrationTextCtr.text);
                      foldersCtl.registerData(register);
                      Navigator.pop(context);
                    } catch (e) {
                      AlertDialog(
                        title: const Text('登録でエラーが発生しました。'),
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
                  child: const Text("OK"),
                ),
              ],
            ),
          ],
        );
      },
    );
/*==============================================================================
【フォルダ編集】
==============================================================================*/
_buildEdit(BuildContext context, TextEditingController dateEditTextCtr,
        FolderController foldersCtl, List<Folder> foldersState, int index) =>
    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlertDialog(
                title: const Text('フォルダ名入力'),
                content: TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  controller: dateEditTextCtr,
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
                  ElevatedButton(
                    onPressed: () {
                      try {
                        foldersCtl.upData(index, dateEditTextCtr.text);
                        Navigator.pop(context);
                      } catch (e) {
                        AlertDialog(
                          title: const Text('フォルダ編集でエラーが発生しました。'),
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
                    child: const Text("OK"),
                  ),
                ],
              ),
            ],
          );
        });
