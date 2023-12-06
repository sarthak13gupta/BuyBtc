import 'package:buy_bitcoin/bloc/btc_bloc.dart';
import 'package:buy_bitcoin/pages/preview.dart';
import 'package:buy_bitcoin/widgets/btcChart.dart';
import 'package:buy_bitcoin/widgets/btcPrice.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BtcBloc bloc = BtcBloc();
  @override
  void initState() {
    super.initState();
    // bloc.actionController.add(CallPriceApi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Wallet Money",
              style: TextStyle(fontSize: 20),
            ),
            const Divider(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    // height: 400,
                    child: BtcChart(
                      btcBloc: bloc,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    // height: 100,
                    child: BtcPrice(
                      btcBloc: bloc,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PreviewPage(),
                          ));
                        },
                        label: const Text("BUY BTC")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
