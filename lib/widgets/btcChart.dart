import 'dart:convert';

import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class BtcChart extends StatefulWidget {
  final BtcBloc btcBloc;
  BtcChart({required this.btcBloc, super.key});

  @override
  State<BtcChart> createState() => _BtcChartState();
}

class _BtcChartState extends State<BtcChart> {
  late TrackballBehavior trackballBehavior;
  // List<_SalesData> data = [
  //   _SalesData('Jan', 35),
  //   _SalesData('Feb', 28),
  //   _SalesData('Mar', 34),
  //   _SalesData('Apr', 32),
  //   _SalesData('May', 40)
  // ];

  @override
  void initState() {
    // getChart();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Initialize the chart widget
        SfCartesianChart(
          trackballBehavior: trackballBehavior,
          zoomPanBehavior:
              ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x),
          // primaryXAxis: CategoryAxis(),
          // Chart title
          // title: ChartTitle(text: 'Half yearly sales analysis'),
          // Enable legend
          // legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CandleSeries>[
            CandleSeries<ChartModel, int>(
                enableSolidCandles: true,
                enableTooltip: true,
                bullColor: Colors.green,
                bearColor: Colors.red,
                dataSource: itemChart!,
                xValueMapper: (ChartModel sales, _) => sales.time,
                lowValueMapper: (ChartModel sales, _) => sales.low,
                highValueMapper: (ChartModel sales, _) => sales.high,
                openValueMapper: (ChartModel sales, _) => sales.open,
                closeValueMapper: (ChartModel sales, _) => sales.close,
                animationDuration: 55)
          ],
        ),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     //Initialize the spark charts widget
        //     child: SfSparkLineChart.custom(
        //       //Enable the trackball
        //       trackball: SparkChartTrackball(
        //           activationMode: SparkChartActivationMode.tap),
        //       //Enable marker
        //       marker: SparkChartMarker(
        //           displayMode: SparkChartMarkerDisplayMode.all),
        //       //Enable data label
        //       labelDisplayMode: SparkChartLabelDisplayMode.all,
        //       xValueMapper: (int index) => data[index].year,
        //       yValueMapper: (int index) => data[index].sales,
        //       dataCount: 5,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  int days = 30;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;

  bool isRefresh = true;

  Future<void> getChart() async {
    String url = 'https://api.coingecko.com/api/v3/coins/' +
        'itcoin' +
        '/ohlc?vs_currency=usd&days=' +
        days.toString();

    setState(() {
      isRefresh = true;
    });
    Dio dio = Dio();
    Response response = await dio.get(
      url,
      // headers: {
      //   "Content-Type": "application/json",
      //   "Accept": "application/json",
      // },
    );

    setState(() {
      isRefresh = false;
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.data);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}

// class _SalesData {
//   _SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
// }
