import 'package:buy_bitcoin/bloc/btc_event.dart';
import 'package:intl/intl.dart';
import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BtcChart extends StatefulWidget {
  final BtcBloc btcBloc;
  BtcChart({required this.btcBloc, super.key});

  @override
  State<BtcChart> createState() => _BtcChartState();
}

class _BtcChartState extends State<BtcChart> {
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    // set a default days value for this
    widget.btcBloc.actionController.add(GetChart(
      days: 30,
    ));
    _setTrackBall();
    super.initState();
  }

  void _setTrackBall() {
    _trackballBehavior = TrackballBehavior(
      shouldAlwaysShow: true,
      lineType: TrackballLineType.none,
      enable: true,
      activationMode: ActivationMode.singleTap,
      markerSettings: const TrackballMarkerSettings(
        markerVisibility: TrackballVisibilityMode.visible,
      ),
      tooltipSettings: const InteractiveTooltip(
        enable: false,
        canShowMarker: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double boxHeight = MediaQuery.of(context).size.height;
    double boxWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: widget.btcBloc.btcChartStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
            ),
          );
        } else if (snapshot.data == null) {
          return const Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }
        List<ChartModel> itemChart = snapshot.data!.chartValues;
        double minPrice = snapshot.data!.minPrice - 10;
        double maxPrice = snapshot.data!.maxPrice + 10;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: boxHeight * 0.45,
              child: Expanded(
                child: GestureDetector(
                  onTap: (() {}),
                  child: SfCartesianChart(
                    borderColor: Colors.transparent,
                    borderWidth: 0,
                    plotAreaBorderWidth: 0,
                    margin: const EdgeInsets.all(0),
                    trackballBehavior: _trackballBehavior,
                    onTrackballPositionChanging: (trackballArgs) {
                      _handleBtcData(trackballArgs);
                    },
                    onChartTouchInteractionUp: ((tapArgs) {
                      widget.btcBloc.actionController
                          .add(ShowChartValue(time: null, price: null));
                    }),
                    zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true, zoomMode: ZoomMode.x),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<ChartModel, DateTime>>[
                      SplineSeries(
                        splineType: SplineType.natural,
                        dataSource: itemChart,
                        color: Theme.of(context).primaryColorDark,
                        xValueMapper: (ChartModel sales, _) => sales.time,
                        yValueMapper: (ChartModel sales, _) => sales.price,
                        enableTooltip: false,
                        width: 2,
                      ),
                    ],
                    primaryXAxis: DateTimeAxis(
                      isVisible: false,
                      dateFormat: DateFormat.MMMMd(),
                      majorGridLines: const MajorGridLines(width: 0),
                      borderColor: Colors.transparent,
                      borderWidth: 0,
                    ),
                    primaryYAxis: NumericAxis(
                      borderColor: Colors.transparent,
                      borderWidth: 0,
                      isVisible: false,
                      minimum: minPrice,
                      maximum: maxPrice,
                      numberFormat:
                          NumberFormat.simpleCurrency(decimalDigits: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: boxHeight * 0.07,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: text.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: boxWidth / 6.3,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            textBool = [
                              false,
                              false,
                              false,
                              false,
                              false,
                              false
                            ];
                            textBool[index] = true;
                          });
                          setDays(text[index]);
                          _getChart();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: textBool[index] == true
                                ? Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.3)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              text[index],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [false, false, true, false, false, false];

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

  _handleBtcData(TrackballArgs trackballArgs) {
    DateTime xVal = trackballArgs.chartPointInfo.chartDataPoint!.x;
    double yVal = trackballArgs.chartPointInfo.chartDataPoint!.y;

    widget.btcBloc.actionController
        .add(ShowChartValue(time: xVal, price: yVal));
  }

  Future<void> _getChart() async {
    widget.btcBloc.actionController.add(GetChart(days: days));
  }
}
