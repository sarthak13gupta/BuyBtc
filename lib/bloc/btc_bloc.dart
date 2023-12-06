import 'dart:async';

import 'package:buy_bitcoin/api/api_call.dart';
import 'package:buy_bitcoin/bloc/btc_event.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:buy_bitcoin/pages/preview.dart';
import 'package:flutter/material.dart';

class BtcBloc {
  BtcBloc() {
    _init();
  }
  StreamController<BtcEvents> actionController =
      StreamController<BtcEvents>.broadcast();

  Stream<BtcEvents> get actionStream => actionController.stream;

  final StreamController<BtcModel> _btcDataController =
      StreamController<BtcModel>.broadcast();

  Stream<BtcModel> get btcDataStream => _btcDataController.stream;

  Future<void> _init() async {
    actionStream.listen((event) {
      if (event is CallPriceApi) {
        _callPriceApi(event);
      } else if (event is BuyBtc) {
        _buyBtc(event);
      }
    });
  }

  Future<void> _callPriceApi(CallPriceApi event) async {
    ApiCall apiCall = ApiCall();
    try {
      // Timer.periodic(const Duration(seconds: 3), (timer) {
      Map<String, dynamic> responseData = await apiCall.fetch();
      BtcModel btcData = BtcModel.fromJson(responseData);
      _btcDataController.add(btcData);
      // });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _buyBtc(BuyBtc event) async {
    await Navigator.of(event.context).push(MaterialPageRoute(
      builder: (_) => PreviewPage(
          // marketPrice: marketPrice,
          ),
    ));
  }
}
