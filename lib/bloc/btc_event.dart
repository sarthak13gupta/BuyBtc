import 'package:flutter/material.dart';

abstract class BtcEvents {}

// event of buying a bitcoin
class BuyBtc extends BtcEvents {
  final BuildContext context;
  BuyBtc({required this.context});
}

// event of calling api for btc prices

class CallPriceApi extends BtcEvents {}
