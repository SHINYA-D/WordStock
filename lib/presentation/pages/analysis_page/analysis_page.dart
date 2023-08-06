import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wordstock/presentation/pages/analysis_page/analysis_controller.dart';

class AnalysisPage extends ConsumerWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(analysisProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('分析画面'),
        automaticallyImplyLeading: true,
      ),
      body: SlidableAutoCloseBehavior(
        child: folders.isEmpty
            ? const Center(child: Text('現在分析ができない情報量です'))
            : Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: CarouselSlider(
                  options: CarouselOptions(height: 500.0.h),
                  items: folders.map((folder) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(children: [
                          Container(
                            height: 150.h,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Align(
                              alignment: Alignment.center, // テキストを中央に配置
                              child: Text(
                                folder.name ?? '表示中にエラーが発生しました',
                                style: const TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Gap(100),
                          CircularPercentIndicator(
                            animation: true,
                            animationDuration: 2000,
                            radius: 100.0,
                            lineWidth: 50.0,
                            percent: folder.folderPercent * 0.01,
                            center: Text(
                              '${folder.folderPercent}%',
                              style: const TextStyle(
                                fontSize: 32.0,
                                color: Colors.white,
                              ),
                            ),
                            progressColor: Colors.blue,
                          ),
                        ]);
                      },
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }
}
