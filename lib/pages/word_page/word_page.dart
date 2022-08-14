import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wordstock/model/word/word.dart';
import 'word_page_control.dart';

class WordPage extends ConsumerWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderId = ModalRoute.of(context)!.settings.arguments;
    final String? folderIdNum = folderId as String?;

    //共通プロバイダ
    final wordsProvider = ref.watch(wordProvider);

    //更新プロバイダ
    final controlWordsProvider = ref.read(wordProvider.notifier);

    // //FolderID抽出処理
    controlWordsProvider.getPointData(folderIdNum!);

/*==============================================================================
【ワード画面】
==============================================================================*/
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '単語一覧',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: SlidableAutoCloseBehavior(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: wordsProvider.when(
            data: (wordsProvider) => ListView.builder(
              itemCount: wordsProvider.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (value) async {
                          //【削除処理】
                          final selectWord = wordsProvider[index];
                          controlWordsProvider.deleteData(selectWord);
                        },
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        icon: Icons.delete,
                        label: '削除',
                      ),
                    ],
                  ),
                  child: ListTile(
                    //【ListWidget処理】
                    title: _folderList(index, wordsProvider, context),
                  ),
                );
              },
            ),
            error: (error, stackTrace) =>
                Text('エラーが発生しました。\n ${error.toString()}'),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 280.w, bottom: 530.h),
            child: FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                //【登録画面】
                Navigator.pushNamed(context, "/wordregistration",
                    arguments: folderIdNum);
              },
              child: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.w, bottom: 530.h),
            child: wordsProvider.when(
              data: (articles) => FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                onPressed: () {
                  final List<Word> wordExtract = wordsProvider.value!;

                  Navigator.pushReplacementNamed(context, "/playpage",
                      arguments: wordExtract);
                },
                child: const Icon(Icons.play_circle_filled,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              error: (error, stackTrace) =>
                  Text('エラーが発生しました。\n ${error.toString()}'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

/*==============================================================================
【ListWidget処理】
==============================================================================*/
Widget _folderList(int index,
    List<Word> wordsProvider,
    BuildContext context ) =>

    Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/wordedit",
                    arguments: EditBox(index, wordsProvider));
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 60.sp,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text(
                    wordsProvider[index].wFrontName!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

class EditBox {
  final int selectNum;
  final List<Word> words;

  EditBox(this.selectNum, this.words);
}
