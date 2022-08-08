// ignore_for_file: slash_for_doc_comments, camel_case_types, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';
import 'package:wordstock/model/word_model/word_model.dart';
import 'word_page_controll.dart';

class WordPage extends ConsumerWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final forderId = ModalRoute.of(context)!.settings.arguments;
    String? forderIdNum = forderId as String?;

    //共通プロバイダ
    final wordsProvider = ref.watch(wordProvider);

    //更新プロバイダ
    final controlWordsProvider = ref.read(wordProvider.notifier);

    //FolderID抽出処理
    controlWordsProvider.controllerPointGet(forderIdNum!);


/*******************************************************************************
【ワード画面】
*******************************************************************************/
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
          child: ListView.builder(
            itemCount: wordsProvider.value?.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (value) async {
                        //削除処理
                        final selectWord = wordsProvider.value?[index];
                        controlWordsProvider.controllerDelete(selectWord!);
                      },
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      icon: Icons.delete,
                      label: '削除',
                    ),
                  ],
                ),
                child: ListTile(
                  //【ListWidget処理】
                  title: listWidgetMethod(index, wordsProvider,context),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        children:[
          Container(
            margin: EdgeInsets.only(left:290.w,bottom: 530.h),
            child: FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: const Icon(Icons.add,
                  color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      //【登録画面】
                      return  WordRegistration(forderIdNum);
                    }
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:15.w,bottom: 530.h),
            child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                child: const Icon(Icons.play_circle_filled,
                    color: Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  //play_page.dart
                  List<word_model>  wordExtract =  wordsProvider.value!;
                  Navigator.pushReplacementNamed(
                      context, "/playpage", arguments: wordExtract);
                }
            ),
          ),
        ],
      ),
    );
  }
}
/*******************************************************************************
【ListWidget処理】
*******************************************************************************/
Widget listWidgetMethod(int i,
    AsyncValue<List<word_model>> wordsProvider,BuildContext context) =>

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //【編集画面】
                    builder: (context) => WordEdit(i),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.description, size: 60.sp,
                    color: const Color.fromARGB(255, 0, 0, 0),),
                  wordsProvider.when(
                    error: (err, _) => Text(err.toString()),
                    loading: () => const CircularProgressIndicator(),
                    data: (wordsProvider) =>
                        Text( wordsProvider[i].wFrontName!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
/*******************************************************************************
【登録画面】
*******************************************************************************/
class WordRegistration extends ConsumerWidget {
  WordRegistration(this.forderIdNum, {Key? key}) : super(key: key);

  String? forderIdNum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //登録カウント管理
    int cardItemCount = 5;

    //Word登録　表
    List<TextEditingController> frontTextController =
    List.generate(5, (i) => TextEditingController(text: ''));

    //Word登録　裏
    List<TextEditingController> backTextController =
    List.generate(5, (i) => TextEditingController(text: ''));

    //更新プロバイダ
    final controlWordsProvider = ref.read(wordProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        centerTitle: true,
        title: const Text('カード作成',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body:GestureDetector(
       child:ListView.builder(
         itemCount: cardItemCount,
         itemBuilder: (context, index) {
          int x = index + 1;
          return  ListTile(
           title:Column(
            children:[
             Padding(
              padding: EdgeInsets.only(top:20.h,left: 0.w,),
             child:Card(
              color: Colors.white70,
              shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),),
              child:SizedBox(
               width:400.w, height: 220.h,
               child:Center(
                child:Column(
                 children:[
                  Text('$x枚目のカード'),
                  //表カード入力フォーム
                  TextField(
                   maxLength: 20,
                   controller: frontTextController[index],
                   decoration: const InputDecoration(
                    hintText:'表面の値を入力してください',
                    enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                      color: Color.fromARGB(15, 16, 15, 15)),
                   ),),
                   autofocus: true,
                  ),
                  //裏カード入力フォーム
                  TextField(
                   maxLength: 20,
                   controller: backTextController[index],
                   decoration: const InputDecoration(
                    hintText:'裏面の値を入力してください',
                    enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                      color: Color.fromARGB(15, 16, 15, 15)),
                   ),),
                   autofocus: true,
                  ),
                  //完了・取り消しボタン
                 Row( children:[
                  Padding(
                  padding:EdgeInsets.only(left: 80.w,top:0, right:40.w),
                   child:SizedBox(height: 30.h, width: 90.w,
                    child: ElevatedButton(
                     child: const Text("取消"),
                     onPressed: () {
                      frontTextController[index].text = '';
                      backTextController[index].text = '';
                     },
                   ),),
                  ),
                  SizedBox(
                   height: 30.h, width: 90.w,
                   child: ElevatedButton(
                    child: const Text("完了"),
                    onPressed: () {
                    if( frontTextController[index].text == ''  ||
                       backTextController[index].text == '')
                    {
                    showBottomSheet(
                     context: context,
                     builder: (BuildContext context) {
                       return Container(
                        height: 200,
                         alignment: Alignment.center,
                         width: double.infinity,
                         decoration: const BoxDecoration(
                          color: Colors.red,
                          boxShadow: [
                           BoxShadow(color: Colors.black, blurRadius: 20,)
                          ],
                         ),
                        child: const Text('未入力の箇所があります'),
                       );
                     },
                    );
                    Future.delayed(const Duration(seconds: 1), () {
                     Navigator.of(context).pop();
                    });
                   }else{
                    FocusScope.of(context).unfocus();
                   }
                  },//onPressed
                 ),),
                 ],),],
                ),
               ),
              ),
             ),
             ),
            ],
           ),
          );
         },
       ),),

    //登録実行処理
    floatingActionButton: Container(
     margin: EdgeInsets.only(bottom: 0.h), //●
     child: FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 238, 91, 117),
      child: const Icon( Icons.add_box, color: Color.fromARGB(255, 0, 0, 0)),
      onPressed: () {
       for ( var i = 0; i < cardItemCount; i++ ) {
        if( (frontTextController[i].text != null ) &&
            (frontTextController[i].text != "" )   &&
            (backTextController[i].text != null )  &&
            (backTextController[i].text != "" )
          ) {
                String uid =  const Uuid().v4();
                word_model register =
                word_model(
                    wId:uid,
                    wFrontName: frontTextController[i].text,
                    wBackName: backTextController[i].text,
                    wTableName: 'words',
                    wFolderNameId: forderIdNum,
                    wYes:0,
                    wNo:0,
                    wPlay:0,
                    wTime:0,
                    wPercent:0,
                    wAverage:0,
                    wOk:'FLAT'
                );
                //登録処理
                controlWordsProvider.controllerRegister(register);
        }//IF文
       }//for文
       Navigator.of(context).pop();
      },
     ),
    ),
    );
  }
}
/*******************************************************************************
【編集画面】
 ******************************************************************************/
class WordEdit extends ConsumerWidget {
  WordEdit(this.selectNum, {Key? key}) : super(key: key);
  int selectNum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //共通プロバイダ
    final wordsProvider = ref.watch(wordProvider);

    //更新プロバイダ
    final controlWordsProvider = ref.read(wordProvider.notifier);

    //入力コントローラ　表
    final frontTextController = TextEditingController(
        text:wordsProvider.value![selectNum].wFrontName );

    //入力コントローラ　裏
    final backTextController = TextEditingController(
        text: wordsProvider.value![selectNum].wBackName );

    String? flont = wordsProvider.value![selectNum].wFrontName;
    String? back =  wordsProvider.value![selectNum].wBackName;


  return Scaffold(
   backgroundColor: const Color.fromARGB(255, 0, 0, 0),
   appBar: AppBar(
    centerTitle: true,
    title: const Text(
     'WordStock', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
   ),

   body:
    ListView(
     children:[
      //単語 表　表示
      SizedBox( height: 250.h, width:  400.w,
       child:Card(
        margin:EdgeInsets.only(top: 10.h, right: 0.w, bottom: 0.h, left: 5.w),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: SizedBox( width: 380.w,
         child:Center(
          child:Text('$flont'),
         ),
        ),
      ),),
       //単語 裏　表示
      SizedBox( height: 250.h, width:  400.w,
       child:Card(
        margin:EdgeInsets.only(top: 10.h, right: 0.w, bottom: 0.h, left: 5.w),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: SizedBox(width: 380.w,
         child:Center(
          child:Text('$back'),
         ),
        ),
      ),),
     ],),

  //編集画面
  floatingActionButton:FloatingActionButton(
   onPressed: () {
    showDialog(
     context: context,
     barrierDismissible: false,
     builder: (context) {
      return AlertDialog(
       title: const Text('カード編集'),
       content: SingleChildScrollView(
        child: SizedBox( height: 100.h, width: 100.w,
         child:Column(
          children:[
           //表カード入力フォーム
           TextField(
            inputFormatters: [LengthLimitingTextInputFormatter(20)],
            controller: frontTextController,
            decoration: const InputDecoration(),
            autofocus: true,
           ),
           //裏カード入力フォーム
           TextField(
            inputFormatters: [LengthLimitingTextInputFormatter(20)],
            controller: backTextController,
            decoration: const InputDecoration(),
            autofocus: true,
          ),
          ],
         ),
        ),
       ),
      actions: <Widget>[
       ElevatedButton(
        child: const Text("CANCEL"),
        onPressed: () => Navigator.pop(context),
       ),
       ElevatedButton(
        child: const Text("OK"),
        onPressed: () {
         word_model up =
         wordsProvider.value![selectNum];
         up = up.copyWith(wFrontName:frontTextController.text,
         wBackName:backTextController.text);
         //編集処理
         controlWordsProvider.controllerUp(up);
         Navigator.pop(context);
       }),

      ],);
     });
   },
  backgroundColor: Colors.pink,
  child: const Icon(Icons.mode_edit),
  ),); }
}


