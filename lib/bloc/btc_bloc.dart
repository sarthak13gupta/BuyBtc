import 'dart:async';
import 'dart:math';

import 'package:buy_bitcoin/api/api_call.dart';
import 'package:buy_bitcoin/bloc/btc_event.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:buy_bitcoin/pages/success.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class BtcBloc {
  BtcBloc() {
    _init();
  }
  StreamController<BtcEvents> actionController =
      StreamController<BtcEvents>.broadcast();

  Stream<BtcEvents> get actionStream => actionController.stream;

  final BehaviorSubject<BtcModel> _btcDataController =
      BehaviorSubject<BtcModel>();

  Stream<BtcModel> get btcDataStream => _btcDataController.stream;

  final BehaviorSubject<ChartData> _btcChartController =
      BehaviorSubject<ChartData>();

  Stream<ChartData> get btcChartStream => _btcChartController.stream;

  final BehaviorSubject<ShowChartValue> _showChartValueController =
      BehaviorSubject<ShowChartValue>();

  Stream<ShowChartValue> get showChartValueStream =>
      _showChartValueController.stream;

  final BehaviorSubject<bool> _buyBtcLoadingController =
      BehaviorSubject<bool>();

  Stream<bool> get buyBtcLoadingStream => _buyBtcLoadingController.stream;

  Future<void> _init() async {
    actionStream.listen((event) {
      if (event is CallPriceApi) {
        _callPriceApi(event);
      } else if (event is BuyBtcEvent) {
        _buyBtc(event);
      } else if (event is GetChart) {
        _getChart(event);
      } else if (event is ShowChartValue) {
        _showChartvalue(event);
      }
    });
  }

  Future<void> _callPriceApi(CallPriceApi event) async {
    ApiCall apiCall = ApiCall();
    try {
      // Timer.periodic(const Duration(seconds: 10), (timer) async {
      Map<String, dynamic> responseData =
          await apiCall.fetchBtcPrice(event.context);
      BtcModel btcData = BtcModel.fromJson(responseData);
      _btcDataController.add(btcData);
      // });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _buyBtc(BuyBtcEvent event) async {
    // start loading
    _buyBtcLoadingController.add(true);

    final navigator = Navigator.of(event.context);

    await Future.delayed(
      const Duration(seconds: 10),
    );

    navigator.push(
      MaterialPageRoute(
        builder: (_) => SuccessPage(
          buyAmountBtc: event.buyAmountBtc,
          buyAmountUsd: event.buyAmountUsd,
        ),
      ),
    );

    // stop loading
    _buyBtcLoadingController.add(false);
  }

  Future<void> _getChart(GetChart event) async {
    ApiCall apiCall = ApiCall();
    Map<String, dynamic> responseData = await apiCall.fetchBtcChart(event.days);

    double tempMin = 1e9;
    double tempMax = 0;
    List<dynamic> prices = responseData['prices'];
    List<ChartModel> modelList = [];
    for (int i = 0; i < prices.length; i += 9) {
      tempMin = min(prices[i][1], tempMin);
      tempMax = max(prices[i][1], tempMax);
      modelList.add(
        ChartModel.fromJson(prices[i]),
      );
    }

    double diff = tempMax - tempMin;
    tempMax += diff / 10;
    tempMin -= diff / 10;

    ChartData chartData = ChartData(
      chartValues: modelList,
      maxPrice: tempMax,
      minPrice: tempMin,
    );
    _btcChartController.add(chartData);
  }

  void _showChartvalue(ShowChartValue event) async {
    _showChartValueController.add(event);
  }
}
