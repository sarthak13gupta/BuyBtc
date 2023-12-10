import 'package:flutter/material.dart';

abstract class BtcEvents {}

// event of buying a bitcoin
class BuyBtcEvent extends BtcEvents {
  final BuildContext context;
  final double buyAmountBtc;
  final double buyAmountUsd;
  BuyBtcEvent(
      {required this.context,
      required this.buyAmountBtc,
      required this.buyAmountUsd});
}

class GetChart extends BtcEvents {
  final int days;
  GetChart({required this.days});
}

// event of calling api for btc prices

class CallPriceApi extends BtcEvents {
  final BuildContext context;
  CallPriceApi({required this.context});
}

class ShowChartValue extends BtcEvents {
  DateTime? time;
  double? price;
  ShowChartValue({
    required this.time,
    required this.price,
  });
}
