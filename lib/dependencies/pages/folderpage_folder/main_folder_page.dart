// ignore_for_file: slash_for_doc_comments, unused_import, sort_child_properties_last, non_constant_identifier_names, unused_local_variable, unused_element, camel_case_types, duplicate_ignore, must_be_immutable, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';
import 'package:wordstock/dependencies/pages/folderpage_folder/main_folder_page_controll.dart';
import 'package:wordstock/model/folder_model/folder_model.dart';
import 'dart:math' as math;

class MainFolderPage extends ConsumerWidget {
  const MainFolderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dateTextController = TextEditingController( text: '' );

    //共通プロバイダ
    final foldersProvider = ref.watch(folderProvider);
    //更新プロバイダ
    final controlFolderProvider = ref.read(folderProvider.notifier);

/*******************************************************************************
【フォルダー画面】
*******************************************************************************/
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'WordStock',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),

      body: SlidableAutoCloseBehavior(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: ListView.builder(
            itemCount: foldersProvider.value?.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context)  {
                        //編集処理
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('フォルダ名入力'),
                                content: TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20)
                                  ],
                                  controller: dateTextController,
                                  decoration: const InputDecoration(
                                    hintText: '新フォルダネームを入力してください',
                                  ),
                                  autofocus: true,
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text("CANCEL"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  ElevatedButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        //編集処理
                                        folder_model up =
                                                 foldersProvider.value![index];
                                 up = up.copyWith(name:dateTextController.text);
                                        controlFolderProvider.controllerUp(up);
                                        Navigator.pop(context);
                                      }
                                  ),
                                ],
                              );
                            });
                        },
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      icon: Icons.settings,
                      label: '編集',
                    ),
                    SlidableAction(
                      onPressed: (value) async {
                        //削除処理
                         final selectFolder = foldersProvider.value?[index];
                         controlFolderProvider.controllerDelete(selectFolder!);
                      },
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      icon: Icons.delete,
                      label: '削除',
                    ),
                  ],
                ),
                child: ListTile(
                  //【ListWidget処理】
                  title: listWidgetMethod(index, foldersProvider,context),
                ),
              );
            },
          ),
        ),
      ),

      floatingActionButton:
       Container(
            margin: EdgeInsets.only(bottom: 530.h),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: const Icon(Icons.create_new_folder,
                  color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      //【登録画面】
                      return const FolderRegistration();
                    }
                );
              },
            ),
       ),

    );
  }
}
/*******************************************************************************
【ListWidget処理】
*******************************************************************************/
Widget listWidgetMethod(int i,
    AsyncValue<List<folder_model>> foldersProvider,BuildContext context) =>

    Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child:
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                //word_page.dart
                String? forderIdNum = foldersProvider.value![i].id;
                Navigator.pushNamed(context, "/wordpage",
                        arguments: forderIdNum );
              },
              child: Row(
                children: [
                  Icon(Icons.folder, size: 60.sp,
                    color: const Color.fromARGB(255, 0, 0, 0),),
                  foldersProvider.when(
                    error: (err, _) => Text(err.toString()),
                    loading: () => const CircularProgressIndicator(),
                    data: (foldersProvider) =>
                        Text( foldersProvider[i].name!,
                          style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                //const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ),
      ),
    );
/*******************************************************************************
【登録画面】
 ******************************************************************************/
class FolderRegistration extends ConsumerWidget {
  const FolderRegistration({Key? key}) : super(key: key);
  @override
   Widget build(BuildContext context, WidgetRef ref,) {

    //入力値
    final dateTextController = TextEditingController( text: '' );

    //更新プロバイダ
    final controlFolderProvider = ref.read(folderProvider.notifier);

    return Scaffold(
        body:
        AlertDialog(
          title: const Text('フォルダ名入力'),
          content: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(20)
            ],
            controller: dateTextController,
            decoration: const InputDecoration(
              hintText: "フォルダ名",
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("CANCEL"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
                child: const Text("OK"),
                onPressed: () {
                  String uid =  const Uuid().v4();
                  folder_model register =
                      folder_model(
                       id:uid,
                       name:dateTextController.text,
                       tableName:'folders'
                  );
                  //登録処理
                  controlFolderProvider.controllerRegister(register);
                  Navigator.pop(context);
                }
            ),
          ],
        ),
    );
  }
}



