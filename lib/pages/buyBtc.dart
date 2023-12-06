import 'package:buy_bitcoin/pages/success.dart';
import 'package:flutter/material.dart';

class BuyBtc extends StatefulWidget {
  // get the amount in btc as a parameter
  const BuyBtc({super.key});

  @override
  State<BuyBtc> createState() => _BuyBtcState();
}

class _BuyBtcState extends State<BuyBtc> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: _visible,
              child: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("34.900 BTC"),
            const SizedBox(
              height: 40,
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                // Simulate network call
                _buyBtc().then((value) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SuccessPage()),
                  );
                });
              },
              label: const Text("Buy"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buyBtc() async {
    setState(() {
      _visible = true;
    });
    await Future.delayed(
      const Duration(seconds: 10),
    );
    setState(() {
      _visible = false;
    });
  }
}
