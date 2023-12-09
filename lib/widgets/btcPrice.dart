import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/bloc/btc_event.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BtcPrice extends StatefulWidget {
  final BtcBloc btcBloc;
  const BtcPrice({required this.btcBloc, super.key});

  @override
  State<BtcPrice> createState() => _BtcPriceState();
}

class _BtcPriceState extends State<BtcPrice> {
  bool _showChartValue = false;
  double? _chartPrice;
  String? _chartPriceTime;
  String? _chartPriceDate;
  @override
  void initState() {
    super.initState();
    _setShowChartValueListener();
  }

  _setShowChartValueListener() {
    widget.btcBloc.showChartValueStream.listen((event) {
      if (event.time != null) {
        setState(() {
          _showChartValue = true;
          _chartPrice = event.price;
          _chartPriceDate = DateFormat('MM/dd/yyyy').format(event.time!);
          _chartPriceTime = DateFormat('hh:mm a').format(event.time!);
        });
      } else {
        setState(() {
          _showChartValue = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.btcBloc.btcDataStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "  BITCOIN PRICE",
              style: TextStyle(fontSize: 15, color: Color(0xFF00305E)),
            ),
            snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ))
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _showChartValue == true
                                  ? '\$${_chartPrice!.toStringAsFixed(2)}'
                                  : '\$${snapshot.data!.currentPrice}',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _showChartValue == true
                                      ? '$_chartPriceDate'
                                      : snapshot.data!.priceChange24H
                                              .toString()
                                              .contains('-')
                                          ? "-\$${snapshot.data!.priceChange24H.toStringAsFixed(2).toString().replaceAll('-', '')}"
                                          : "\$${snapshot.data!.priceChange24H.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF00305E)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  _showChartValue
                                      ? '$_chartPriceTime'
                                      : '${snapshot.data!.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: _showChartValue
                                          ? Colors.black
                                          : snapshot.data!
                                                      .marketCapChangePercentage24H >=
                                                  0
                                              ? Colors.green
                                              : Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
