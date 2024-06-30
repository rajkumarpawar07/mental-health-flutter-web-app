import 'package:ai_chatbot/services/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State {
  int touchedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Replace 'UserEmotions' with your actual collection name
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('UserEmotions')
            .where('UserId',
                isEqualTo: AuthenticationRepository.instance.authUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          }

          Map<int, double> emotionData = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
          dynamic totalCount = 0;

          for (var doc in snapshot.data!.docs) {
            Map<String, dynamic> data = doc['Emotions'];
            data.forEach((key, value) {
              int emotionKey = int.parse(key);
              emotionData[emotionKey] =
                  (emotionData[emotionKey] ?? 0) + value.toDouble();
              totalCount = (totalCount! + value);
            });
          }

          return AspectRatio(
            aspectRatio: 1.3,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  // pieTouchData: PieTouchData(
                  //   touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  //     setState(() {
                  //       if (!event.isInterestedForInteractions ||
                  //           pieTouchResponse == null ||
                  //           pieTouchResponse.touchedSection == null) {
                  //         touchedIndex = -1;
                  //         return;
                  //       }
                  //       touchedIndex = pieTouchResponse
                  //           .touchedSection!.touchedSectionIndex;
                  //     });
                  //   },
                  // ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections(emotionData, totalCount!),
                ),
              ),
            ),
          );
        });
  }

  List<PieChartSectionData> showingSections(
      Map<int, double> emotionData, int totalCount) {
    return List.generate(5, (i) {
      // final isTouched = i == touchedIndex;
      final fontSize = 16.0;
      final radius = 100.0;
      final widgetSize = 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final int emotionKey = i + 1;
      final double value = emotionData[emotionKey]!;
      final double percentage =
          totalCount == 0 ? 0 : (value / totalCount) * 100;
      final String title = '${percentage.toStringAsFixed(1)}%';

      switch (emotionKey) {
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorRed,
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/angry.png',
              size: widgetSize,
              borderColor: AppColors.contentColorBlack,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorOrange,
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/unhappy.png',
              size: widgetSize,
              borderColor: AppColors.contentColorBlack,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.contentColorYellow,
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/neutral.png',
              size: widgetSize,
              borderColor: AppColors.contentColorBlack,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/happy.png',
              size: widgetSize,
              borderColor: AppColors.contentColorBlack,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 5:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/very_happy.png',
              size: widgetSize,
              borderColor: AppColors.contentColorBlack,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Invalid emotion key');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image(
          image: AssetImage(svgAsset),
        ),
      ),
    );
  }
}
