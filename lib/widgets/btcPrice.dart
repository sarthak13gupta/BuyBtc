import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:flutter/material.dart';

class BtcPrice extends StatefulWidget {
  final BtcBloc btcBloc;
  const BtcPrice({required this.btcBloc, super.key});

  @override
  State<BtcPrice> createState() => _BtcPriceState();
}

class _BtcPriceState extends State<BtcPrice> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.btcBloc.btcDataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return const CircularProgressIndicator();
        }
        BtcModel btcData = snapshot.data!;

        return Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  // padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  child: Image.network(btcData.image),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      btcData.id,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      btcData.symbol,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$ ' + btcData.currentPrice.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          btcData.priceChange24H.toString().contains('-')
                              ? "-\$" +
                                  btcData.priceChange24H
                                      .toStringAsFixed(2)
                                      .toString()
                                      .replaceAll('-', '')
                              : "\$" +
                                  btcData.priceChange24H.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          btcData.marketCapChangePercentage24H
                                  .toStringAsFixed(2) +
                              '%',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: btcData.marketCapChangePercentage24H >= 0
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
        );
      },
    );
  }
}
