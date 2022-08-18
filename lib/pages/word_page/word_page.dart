import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wordstock/model/word/word.dart';
import 'word_controller.dart';

class WordPage extends ConsumerWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderId = ModalRoute.of(context)?.settings.arguments;
    final String folderIdNum = folderId as String;

    final wordsProvider = ref.watch(wordProvider);

    final controlWordsProvider = ref.read(wordProvider.notifier);

    controlWordsProvider.getPointData(folderIdNum);

/*==============================================================================
【ワード画面】
==============================================================================*/
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '単語一覧',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
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
                        onPressed: (_) {
                          final selectWord = wordsProvider[index];
                          controlWordsProvider.deleteData(selectWord);
                        },
                        backgroundColor: Colors.black,
                        icon: Icons.delete,
                        label: '削除',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: _buildFolderList(index, wordsProvider, context),
                  ),
                );
              },
            ),
            error: (error, _) => Text('エラーが発生しました。\n ${error.toString()}'),
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
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, "/wordregistration",
                    arguments: folderIdNum);
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.w, bottom: 530.h),
            child: wordsProvider.when(
              data: (wordsProvider) => FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.white,
                onPressed: () {
                  final List<Word> wordExtract = wordsProvider;

                  Navigator.pushReplacementNamed(context, "/playpage",
                      arguments: wordExtract);
                },
                child: const Icon(
                  Icons.play_circle_filled,
                  color: Colors.black,
                ),
              ),
              error: (error, _) => Text('エラーが発生しました。\n ${error.toString()}'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

/*==============================================================================
【フォルダリストの生成】
==============================================================================*/
Widget _buildFolderList(
        int index, List<Word> wordsProvider, BuildContext context) =>
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
                Navigator.pushNamed(context, "/wordedit",
                    arguments: EditBox(index, wordsProvider));
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
                    Icons.description,
                    size: 60.sp,
                    color: Colors.black,
                  ),
                  Text(
                    wordsProvider[index].wFrontName ?? 'NULL',
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

class EditBox {
  final int selectNum;
  final List<Word> words;

  EditBox(this.selectNum, this.words);
}
