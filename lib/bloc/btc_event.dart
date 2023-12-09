import 'package:flutter/material.dart';

abstract class BtcEvents {}

// event of buying a bitcoin
class BuyBtc extends BtcEvents {
  final BuildContext context;
  BuyBtc({required this.context});
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
