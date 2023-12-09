import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/bloc/btc_event.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:buy_bitcoin/pages/preview.dart';
import 'package:buy_bitcoin/widgets/alertDialog.dart';
import 'package:buy_bitcoin/widgets/btcChart.dart';
import 'package:buy_bitcoin/widgets/btcPrice.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BtcBloc bloc = BtcBloc();
  BtcModel? btcData;
  @override
  void initState() {
    super.initState();
    _callBtcPrice();
  }

  void _callBtcPrice() async {
    bloc.actionController.add(CallPriceApi(context: context));
    btcData = await bloc.btcDataStream.first;
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: myHeight * 0.15,
              child: BtcPrice(
                btcBloc: bloc,
              ),
            ),
            SizedBox(
              height: myHeight * 0.55,
              child: BtcChart(
                btcBloc: bloc,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: myHeight * 0.07,
                width: double.infinity,
                child: FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    onPressed: () {
                      btcData != null
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => PreviewPage(
                                btcBloc: bloc,
                              ),
                            ))
                          : null;
                    },
                    label: const Text(
                      "BUY BTC",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
