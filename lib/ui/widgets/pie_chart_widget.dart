import 'package:country_picker/country_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nationyme/ui/widgets/indicator_chart_widget.dart';

class PieChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> nationalizeData;
  const PieChartWidget({super.key, required this.nationalizeData});

  @override
  PieChartState createState() => PieChartState();
}

class PieChartState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.nationalizeData.length, (index) {
                final details = Country.tryParse(
                        widget.nationalizeData[index]['country_id'])
                    ?.name;
                return Indicator(
                  color: widget.nationalizeData[index]['color'],
                  text: details ?? "",
                  isSquare: true,
                );
              })),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    var bunchOfCountry = widget.nationalizeData;
    List<PieChartSectionData> result = [];
    double totalValue = 0.0;
    for (var i = 0; i < bunchOfCountry.length; i++) {
      var country = bunchOfCountry[i];
      double value = country['probability'];
      var valueDegree = (value / 1) * 360;
      var valuePercent = (value / 1) * 100;
      totalValue += value;
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      result.add(PieChartSectionData(
          color: widget.nationalizeData[i]['color'],
          value: valueDegree,
          title: "$valuePercent%",
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          )));
    }

    if (totalValue > 0) {
      var value = 1.0 - totalValue;
      var valueDegree = (value / 1) * 360;
      var valuePercent = (value / 1) * 100;
      result.add(PieChartSectionData(
          color: Colors.grey,
          value: valueDegree,
          title: "$valuePercent%",
          radius: 50.0,
          titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )));
    }

    return result;
  }
}
