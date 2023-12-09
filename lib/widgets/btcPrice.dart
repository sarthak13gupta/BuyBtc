import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/bloc/btc_event.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:flutter/material.dart';

class BtcPrice extends StatefulWidget {
  final BtcBloc btcBloc;
  const BtcPrice({required this.btcBloc, super.key});

  @override
  State<BtcPrice> createState() => _BtcPriceState();
}

class _BtcPriceState extends State<BtcPrice> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.btcBloc.actionController.add(CallPriceApi());
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.btcBloc.btcDataStream,
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting ||
        //     snapshot.data == null) {
        //   return Center(
        //       child: CircularProgressIndicator(
        //     color: Theme.of(context).primaryColorDark,
        //   ));
        // }

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
                        // flex: 2,
                        child: Column(
                          children: [
                            Text(
                              '\$${snapshot.data!.currentPrice}',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!.priceChange24H
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
                                  '${snapshot.data!.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: snapshot.data!
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
