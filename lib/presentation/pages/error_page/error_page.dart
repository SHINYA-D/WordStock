import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorName;
  const ErrorPage(this.errorName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*==============================================================================
【エラー画面】
==============================================================================*/
    return Scaffold(
      body: AlertDialog(
        title: Text(errorName),
        actions: <Widget>[
          GestureDetector(
            child: const Text('ホーム画面に戻ります'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/folder_page", ModalRoute.withName("/folder_page"));
            },
          ),
        ],
      ),
    );
  }
}
