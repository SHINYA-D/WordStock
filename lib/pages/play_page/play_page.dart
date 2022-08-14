import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flip_card/flip_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/model/word/word.dart';

//good,badボタンカウント
int good = 0;
int bad = 0;

//Goodボタンストック変数
List<String>? okList = [];
//Badボタンストック変数
List<String>? ngList = [];

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final List<Word> wordExtract = args as List<Word>;

    //swipe_cardsデータ設定
    List<SwipeItem> swipeItems = <SwipeItem>[];
    final MatchEngine matchEngine;

    for (int i = 0; i < wordExtract.length; i++) {
      swipeItems.add(
        SwipeItem(content: wordExtract[i].wId),
      );
    }

    matchEngine = MatchEngine(swipeItems: swipeItems);

/*==============================================================================
【プレイ画面】
==============================================================================*/
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 134, 134),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'PLAY',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 350.h,
            child: SwipeCards(
                matchEngine: matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 15.w,
                      top: 10.h,
                    ),
                    child: _flipCard(context, wordExtract, index),
                  );
                },
                //全カードスワイプ後の処理
                onStackFinished: () {
                  List<dynamic> boxList = [
                    good,
                    bad,
                    wordExtract[0].wFolderNameId,
                    okList,
                    ngList
                  ];

                  //初期化
                  good = 0;
                  bad = 0;
                  okList = [];
                  ngList = [];

                  //【EndPage遷移】
                  Navigator.pushNamed(context, "/endpage", arguments: boxList);
                }),
          ),
          //【GOOD/BAD ボタン処理処理】
          _button(matchEngine),
        ],
      ),
    );
  }
}

/*==============================================================================
【FlipCard処理】
==============================================================================*/
Widget _flipCard(BuildContext context, List<Word> wordExtract, int index) {
  return FlipCard(
    direction: FlipDirection.VERTICAL,
    speed: 500,
    front: Card(
      margin: EdgeInsets.only(top: 10.h, right: 0.w, bottom: 0.h, left: 15.w),
      color: const Color.fromARGB(255, 236, 239, 239),
      child: SizedBox(
        width: 380.w,
        child: Center(
          child: Text(wordExtract[index].wFrontName.toString()),
        ),
      ),
    ),
    back: Card(
      margin: EdgeInsets.only(top: 10.h, right: 0.w, bottom: 0.h, left: 15.w),
      color: const Color.fromARGB(255, 232, 246, 248),
      child: SizedBox(
        width: 380.w,
        child: Center(
          child: Text(wordExtract[index].wBackName.toString()),
        ),
      ),
    ),
  );
}

/*==============================================================================
【GOOD/BAD ボタン処理】
==============================================================================*/
Widget _button(MatchEngine matchEngine) {
  return Padding(
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
              final String upId = matchEngine.currentItem?.content;
              //OK wordデータをストック
              okList!.add(upId);
              //Good処理：左にCardが遷移する
              matchEngine.currentItem?.nope();
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
            onPressed: () {
              //現在の選択されているデータのID
              final String upId = matchEngine.currentItem?.content;
              //NG wordデータをストック
              ngList!.add(upId);
              //Bad処理：右にCardが遷移する
              matchEngine.currentItem?.like();
              bad = bad + 1;
            },
            child: const Icon(Icons.thumb_down_alt,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ],
    ),
  );
}
