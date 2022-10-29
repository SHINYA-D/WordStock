import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/presentation/pages/folder/user_controller.dart';

class DrawerPage extends ConsumerWidget {
  const DrawerPage(this.uid, {Key? key}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawersState = ref.watch(drawerProvider(uid));

    final drawersCtl = ref.read(drawerProvider(uid).notifier);

    final dateRegistrationTextCtr = TextEditingController(text: '');

    return Drawer(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: drawersState.when(
              data: (drawersState) => Stack(
                children: <Widget>[
                  GestureDetector(
                    child: SizedBox(
                      width: double.infinity,
                      height: 160,
                      child: drawersState.backImage != "" //foldersCtl.userImage
                          ? Image.network(
                              drawersState.backImage!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset('assets/images/gray.png',
                              fit: BoxFit.cover),
                    ),
                    onTap: () async {
                      drawersCtl.backImage(uid);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 120, right: 0, bottom: 0, left: 20),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        SizedBox(
                            width: 70,
                            height: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: drawersState.userImage != ""
                                  ? Image.asset('assets/images/white.png',
                                      fit: BoxFit.cover)
                                  : Image.asset('assets/images/white.png',
                                      fit: BoxFit.cover),
                            )),
                        GestureDetector(
                          child: SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: drawersState.userImage != ""
                                    ? Image.network(
                                        drawersState.userImage!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/user_icon.png',
                                        fit: BoxFit.cover),
                              )),
                          onTap: () async {
                            drawersCtl.userImage(uid);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
          drawersState.when(
            data: (drawersState) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 0, right: 0.w, bottom: 0, left: 20.w),
                  child: Container(
                    width: 300.w,
                    //color: Colors.red,
                    alignment: Alignment.centerLeft,
                    child: Row(children: [
                      SizedBox(
                        width: 150.w,
                        //  color: Colors.green,
                        child: Text(
                          drawersState.userName != ""
                              ? drawersState.userName!
                              : 'NO NAME',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0, right: 0, bottom: 0, left: 40.w),
                        child: Container(
                          width: 70.w,
                          //  color: Colors.blue,
                          child: ElevatedButton(
                            onPressed: () {
                              _buildEdit(context, dateRegistrationTextCtr,
                                  drawersCtl, uid);
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.white,
                                width: 3.w,
                              ),
                              primary: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              "編集",
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, right: 80.w, bottom: 0, left: 0),
                  child: Container(
                    width: 200.w,
                    //   color: Colors.green,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      drawersState.mail != "" ? drawersState.mail! : 'mail',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
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
        ],
      ),
    );
  }
}

/*==============================================================================
【フォルダ編集】
==============================================================================*/
_buildEdit(BuildContext context, TextEditingController dateEditTextCtr,
        UserController drawersCtl, String uid) =>
    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlertDialog(
                title: const Text('新しい名前を入力してください'),
                content: TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  controller: dateEditTextCtr,
                  decoration: const InputDecoration(
                    hintText: 'NEW NAME',
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
                        drawersCtl.updateUserName(uid, dateEditTextCtr.text);
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
