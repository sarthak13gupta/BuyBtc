import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:buy_bitcoin/pages/buyBtc.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  final BtcBloc btcBloc;
  PreviewPage({required this.btcBloc, super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final TextEditingController _controller = TextEditingController();
  double btcVal = 0.00000;
  double usdVal = 0.0;
  double marketPrice = 43000;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.btcBloc.btcDataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          );
        }
        BtcModel btcData = snapshot.data!;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      "Buy \$",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00305E),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            // label: Text("\$"),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              fontSize: 40, color: Colors.black),
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            double val =
                                value.isNotEmpty ? double.parse(value) : 0;
                            setState(() {
                              btcVal = (val) / marketPrice;
                              usdVal = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "in Bitcoin",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00305E),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "1 BTC = ${btcData.currentPrice}",
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 55,
                  child: DropdownButton<String>(
                    isExpanded:
                        true, // Ensure the dropdown button fills the width
                    value:
                        'Your Single Value', // The selected value (set to the single value)
                    onChanged: null, // Disable dropdown selection
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Your Single Value',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Checking Account ****5900",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            Text(
                              "Limit of \$1000",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    onPressed: () {
                      btcVal > 0.0
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BuyBtc(
                                btcBloc: widget.btcBloc,
                                buyAmountBtc: btcVal,
                                buyAmountUsd: usdVal,
                              ),
                            ))
                          : null;
                    },
                    label: const Text(
                      "Preview Buy",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
