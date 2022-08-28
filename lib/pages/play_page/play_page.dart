import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/pages/play_page/play_page_controller.dart';

class PlayPage extends ConsumerWidget {
  const PlayPage({Key? key}) : super(key: key);

  // final Object? args = ModalRoute.of(context)?.settings.arguments;
  // final List<Word> wordExtract = args as List<Word>;
  // final playState = ref.watch(playsProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(playsProvider);

    final playCtr = ref.read(playsProvider.notifier);

/*==============================================================================
【プレイ画面】
==============================================================================*/
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('PLAY'),
      ),
      body: playCtr.matchEngine == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                SizedBox(
                  height: 350.h,
                  child: SwipeCards(
                      matchEngine: playCtr.matchEngine,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 15.w,
                            top: 10.h,
                          ),
                          child: _buildFlipCard(index),
                        );
                      },

                      //全カードスワイプ後の処理
                      onStackFinished: () {
                        Navigator.pushNamed(
                          context,
                          "/play_result_page",
                        );
                      }),
                ),
                _buildButton(),
              ],
            ),
    );
  }
}

/*==============================================================================
【フリップカード処理】
==============================================================================*/
Widget _buildFlipCard(int index) {
  return Consumer(builder: (context, ref, _) {
    final playState = ref.watch(playsProvider);
    //final playCtr = ref.read(playsProvider.notifier);

    return playState.when(
      data: (playState) => FlipCard(
        direction: FlipDirection.VERTICAL,
        speed: 500,
        front: Card(
          margin:
              EdgeInsets.only(top: 10.h, right: 0.w, bottom: 0.h, left: 15.w),
          child: SizedBox(
            width: 380.w,
            child: Center(
              child: Text(playState[index].frontName!),
            ),
          ),
        ),
        back: Card(
          margin:
              EdgeInsets.only(top: 10.h, right: 0.w, bottom: 0.h, left: 15.w),
          child: SizedBox(
            width: 380.w,
            child: Center(
              child: Text(playState[index].backName!),
            ),
          ),
        ),
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
    );
  });
}

/*==============================================================================
【GOOD/BAD ボタン処理】
==============================================================================*/
Widget _buildButton() {
  return Consumer(builder: (context, ref, _) {
    //final playState = ref.watch(playsProvider);

    ref.watch(playsProvider);

    final playCtr = ref.read(playsProvider.notifier);

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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.blue),
              ),
              onPressed: () {
                playCtr.nope(); //nopeAction
                //Goodの処理を記述する
                //OKに変更させる
              },
              child: const Icon(
                Icons.thumb_down_alt,
              ),
            ),
          ),
          SizedBox(
            width: 120.w,
            height: 100.h,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.blue),
              ),
              onPressed: () {
                playCtr.like();
                //bodの処理を記述する
                //OKに変更させる
              },
              child: const Icon(
                Icons.thumb_up_alt,
              ),
            ),
          ),
        ],
      ),
    );
  });
}
