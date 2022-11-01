import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StatPage extends StatelessWidget {
  StatPage({Key? key}) : super(key: key);
  final List<_InputsData> data = [
    _InputsData(30, 20, 5, 2, 'Jan'),
    _InputsData(13, 40, 2, 2, 'Feb'),
    _InputsData(12, 45, 1, 1, 'Mar'),
    _InputsData(5, 60, 0.2, 0.5, 'Apr'),
    _InputsData(40, 10, 6, 3, 'May')
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 60,
        top: 120,
      ),
      child: Column(children: [
        SfCartesianChart(
            legend: Legend(isVisible: true, position: LegendPosition.bottom),
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries<_InputsData, String>>[
              SplineSeries<_InputsData, String>(
                dataSource: data,
                xValueMapper: (_InputsData inputsData, _) =>
                    inputsData.created_at,
                yValueMapper: (_InputsData inputsData, _) =>
                    inputsData.humidity,
                name: "Humidity",
              ),
              SplineSeries<_InputsData, String>(
                  dataSource: data,
                  xValueMapper: (_InputsData inputsData, _) =>
                      inputsData.created_at,
                  yValueMapper: (_InputsData inputsData, _) =>
                      inputsData.temperature,
                  name: "Temperature"),
              SplineSeries<_InputsData, String>(
                  dataSource: data,
                  xValueMapper: (_InputsData inputsData, _) =>
                      inputsData.created_at,
                  yValueMapper: (_InputsData inputsData, _) => inputsData.water,
                  name: "Water"),
            ]),
      ]),
    );
  }
}

class _InputsData {
  _InputsData(
    this.temperature,
    this.humidity,
    this.water,
    this.result,
    this.created_at,
  );

  final double temperature;
  final double humidity;
  final double water;
  final double result;
  final String created_at;
}
