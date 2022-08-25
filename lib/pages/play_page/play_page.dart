import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/pages/play_page/play_page_controller.dart';

class PlayPage extends ConsumerWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final Object? args = ModalRoute.of(context)?.settings.arguments;
    //final List<Word> wordExtract = args as List<Word>;

    final playsState = ref.watch(playsProvider);

    final playsCtl = ref.read(playsProvider.notifier);

    //swipe_cardsデータ設定
    // List<SwipeItem> swipeItems = <SwipeItem>[];
    // final MatchEngine matchEngine;
    //
    // for (int i = 0; i < wordExtract.length; i++) {
    //   swipeItems.add(
    //     SwipeItem(content: wordExtract[i].id),
    //   );
    // }
    //
    // matchEngine = MatchEngine(swipeItems: swipeItems);

/*==============================================================================
【プレイ画面】
==============================================================================*/
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 134, 134),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'PLAY',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: playsCtl.matchEngine == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                SizedBox(
                  height: 350.h,
                  child: SwipeCards(
                      matchEngine: playsCtl.matchEngine!,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 15.w,
                            top: 10.h,
                          ),
                          child:
                              _buildFlipCard(context, playsState.value, index),
                        );
                      },

                      //全カードスワイプ後の処理
                      onStackFinished: () {
                        Navigator.pushNamed(
                          context,
                          "/play_result_page",
                        );
                        //arguments: boxList
                      }),
                ),
                _buildButton(playsCtl.matchEngine!),
              ],
            ),
    );
  }
}

/*==============================================================================
【フリップカード処理】
==============================================================================*/
Widget _buildFlipCard(BuildContext context, List<Word>? words, int index) {
  return FlipCard(
    direction: FlipDirection.VERTICAL,
    speed: 500,
    front: Card(
      margin: EdgeInsets.only(top: 10.h, right: 0.w, bottom: 0.h, left: 15.w),
      color: const Color.fromARGB(255, 236, 239, 239),
      child: SizedBox(
        width: 380.w,
        child: Center(
          child: Text(words![index].frontName!),
        ),
      ),
    ),
    back: Card(
      margin: EdgeInsets.only(top: 10.h, right: 0.w, bottom: 0.h, left: 15.w),
      color: const Color.fromARGB(255, 232, 246, 248),
      child: SizedBox(
        width: 380.w,
        child: Center(
          child: Text(words[index].backName!),
        ),
      ),
    ),
  );
}

/*==============================================================================
【GOOD/BAD ボタン処理】
==============================================================================*/
Widget _buildButton(MatchEngine matchEngine) {
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
              final String upId = matchEngine.currentItem?.content;

              matchEngine.currentItem?.nope(); //nopeAction

              //Goodの処理を記述する
              //OKに変更させる
            },
            child: const Icon(
              Icons.thumb_down_alt, //,
              color: Colors.black,
            ),
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
              final String upId = matchEngine.currentItem?.content;
              matchEngine.currentItem?.like();

              //bodの処理を記述する
              //OKに変更させる
            },
            child: const Icon(
              Icons.thumb_up_alt,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
