import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/presentation/pages/folder_page/folder_controller.dart';
import 'package:wordstock/presentation/pages/folder_page/folder_registration_page.dart';

class AnalysisPage extends ConsumerWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final foldersState = ref.watch(folderProvider);
    // final foldersCtl = ref.read(folderProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('分析画面'),
        automaticallyImplyLeading: true,
      ),
      body: SlidableAutoCloseBehavior(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: Column(children: [
            Container(color: Colors.red,),
          ]),
        ),
      ),
    );
  }
}
