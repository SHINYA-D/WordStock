// ignore_for_file: use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/dependencies/pages/playpage_folder/play_page_controll.dart';
import 'package:wordstock/model/word_model/word_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:swipe_cards/swipe_cards.dart';


class PlayPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //画面遷移時値受け取り
    Object? args = ModalRoute.of(context)!.settings.arguments;
    List<word_model> wordExtract = args as List<word_model>;

    //swipe_cardsデータ設定
    List<SwipeItem> _swipeItems = <SwipeItem>[];
    MatchEngine _matchEngine;

    //good,badボタンカウント
    int good = 0;
    int bad  = 0;

    for (int i = 0; i < wordExtract.length; i++) {
      _swipeItems.add(
        SwipeItem(
            content: wordExtract[i].wId
        ),);
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);


/*******************************************************************************
【プレイ画面】
*******************************************************************************/
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 134, 134),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('PLAY',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),

      body: Container(
        child: Column(children: <Widget>[
          Container( height: 350.h,
            child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 15.w, top: 10.h,),
                    child: FlipCard(
                      direction: FlipDirection.VERTICAL,
                      speed: 500,

                      front: Card(
                        margin: EdgeInsets.only(
                            top: 10.h, right: 0.w, bottom: 0.h, left: 15.w),
                        color: const Color.fromARGB(255, 236, 239, 239),
                        child: Container(
                          width: 380.w,
                          child: Center(
                            child: Text(
                                wordExtract[index].wFrontName!),
                          ),
                        ),
                      ),

                      back: Card(
                        margin: EdgeInsets.only(
                            top: 10.h, right: 0.w, bottom: 0.h, left: 15.w),
                        color: const Color.fromARGB(255, 232, 246, 248),
                        child: Container(
                          width: 380.w,
                          child: Center(
                            child: Text(
                                wordExtract[index].wBackName!),
                          ),
                        ),
                      ),
                    ),);
                },

                //全カードスワイプ後の処理
                onStackFinished: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('成績'),
                          content: SingleChildScrollView(
                            child: SizedBox( height: 100.h, width: 100.w,
                              child:Column(
                                children:[
                                  Text('正解数：$good'),
                                  Text('不正解数：$bad'),
                                ],
                              ),
                            ),
                          ),

                          actions: <Widget>[
                            Column( children:[

                             //プレイ終了処理
                             Consumer(
                              builder: (BuildContext context,
                                                  WidgetRef ref, _){

                               ref.watch(playProvider);

                               final controlPlaysProvider =
                                                ref.read(playProvider.notifier);

                              return SizedBox(
                               width: double.infinity, height: 20.h,
                               child:ElevatedButton(
                                onPressed: () {
                                 //wOkの初期化処理
                                 controlPlaysProvider.badReset(
                                                 wordExtract[0].wFolderNameId!);
                                 //初期化終了後ホームへ戻る
                                 Navigator.pushReplacementNamed(
                                    context, "/",
                                 );
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 3,
                                  ),
                                  primary: Colors.white,
                                ),
                                child: const Text("終了",
                                  style: TextStyle(color: Colors.black,),
                                ),
                              ),
                             );
                             },),

                             //不正解のみ再プレイ処理
                             Consumer(
                              builder: (BuildContext context,
                                                  WidgetRef ref, _){

                               final playsProvider = ref.watch(playProvider);

                               final controlPlaysProvider =
                                                ref.read(playProvider.notifier);

                               //選択したFolderのWordのみを抽出
                               controlPlaysProvider.controllerPointGet(
                                                 wordExtract[0].wFolderNameId!);

                               return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child:SizedBox(
                                 width: double.infinity, height: 20.h,
                                 child: ElevatedButton(
                                  //【プレイ画面】
                                  onPressed: () {
                                   Navigator.pushReplacementNamed(
                                    context,
                                    "/playpage",
                                    arguments: playsProvider.value!
                                   );
                                  },
                                  style:ElevatedButton.styleFrom(
                                   side: const BorderSide(color: Colors.black,
                                                           width: 3,),
                                   primary: Colors.white,
                                  ),
                                  child: const Text("間違えた箇所をもう一度",
                                   style: TextStyle( color: Colors.black,),
                                  ),
                                ),),
                               );
                              },),
                            ],),
                          ],
                        );
                      });
                }
            ),
          ),


          Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {

              ref.watch(playProvider);

              final controlPlaysProvider = ref.read(playProvider.notifier);

              return Container(
                padding: EdgeInsets.only(top: 40.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SizedBox(
                        width: 120.w,
                        height: 100.h,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(),
                          ),
                          onPressed: () {
                            //現在の選択されているデータのID
                            String upId = _matchEngine.currentItem!.content;
                            //wordデータを更新
                            controlPlaysProvider.controllerGoodUp(upId);
                            //Good処理：左にページが遷移する
                            _matchEngine.currentItem!.nope();
                            good = good + 1;
                          },
                          child: const Icon(Icons.thumb_up_alt,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),

                      SizedBox(
                        width: 120.w,
                        height: 100.h,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(),
                          ),
                          onPressed: ()  {
                            //現在の選択されているデータのID
                            String upId = _matchEngine.currentItem!.content;
                            //wordデータを更新
                            controlPlaysProvider.controllerBadUp(upId);
                            //Bad処理：右にページが遷移する
                            _matchEngine.currentItem!.like();
                            bad = bad + 1;
                          },
                          child: const Icon(Icons.thumb_down_alt,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),

                    ],),);
            },
          ),
        ],),),
    );
  }
}

