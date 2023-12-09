import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:buy_bitcoin/pages/success.dart';
import 'package:flutter/material.dart';

class BuyBtc extends StatefulWidget {
  // get the amount in btc as a parameter
  final num buyAmountBtc;
  final num buyAmountUsd;
  final BtcBloc btcBloc;
  const BuyBtc({
    required this.buyAmountBtc,
    required this.buyAmountUsd,
    required this.btcBloc,
    super.key,
  });

  @override
  State<BuyBtc> createState() => _BuyBtcState();
}

class _BuyBtcState extends State<BuyBtc> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.btcBloc.btcDataStream,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const CircularProgressIndicator();
          }
          BtcModel btcData = snapshot.data!;
          double total = widget.buyAmountUsd + 0.10;
          double boxHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 43,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "You're buying ",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00305E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 43,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            widget.buyAmountBtc.toStringAsPrecision(6),
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            " BTC",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "1 BTC = ${btcData.currentPrice}",
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Checking Account ****5900",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          Text(
                            "Limit of \$1000",
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Purchase amount",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Text(
                                "\$ ${widget.buyAmountUsd.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fees",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Text(
                                "\$ 0.10",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Text(
                                "\$ ${total.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: boxHeight * 0.03,
                    ),
                    SizedBox(
                      child: Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            SizedBox(
                              width: boxHeight * 0.014,
                            ),

                            SizedBox(
                              height: boxHeight * 0.04,
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Bitcoin purchase with a ',
                                            ),
                                            TextSpan(
                                              text: 'Checking Account',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: ' is available\n',
                                            ),
                                            TextSpan(
                                              text: 'for withdrawal after',
                                            ),
                                            TextSpan(
                                              text: ' 10-30 days.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: boxHeight * 0.01,
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3.0, 0, 0, 0),
                            child: Text(
                              "\$",
                              style: TextStyle(
                                fontSize: 30,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: boxHeight * 0.017,
                          ),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                children: const [
                                  TextSpan(
                                    text:
                                        'Funds for this purchase will be pulled from your bank in the next ',
                                  ),
                                  TextSpan(
                                    text: 'two business days.\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'Please ensure your account has sufficient funds to avoid  ',
                                  ),
                                  TextSpan(
                                    text: 'losing this purchase.\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: boxHeight * 0.05,
                    ),
                    SizedBox(
                      height: boxHeight * 0.08,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton.extended(
                          backgroundColor: Theme.of(context).primaryColorLight,
                          onPressed: () async {
                            _buyBtc().then((value) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SuccessPage(
                                    buyAmountBtc: widget.buyAmountBtc,
                                    buyAmountUsd: widget.buyAmountUsd,
                                  ),
                                ),
                              );
                            });
                          },
                          label: !_loading
                              ? const Text(
                                  "Buy Now",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                )
                              : CircularProgressIndicator(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Future<void> _buyBtc() async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(
      const Duration(seconds: 10),
    );
    setState(() {
      _loading = false;
    });
  }
}
