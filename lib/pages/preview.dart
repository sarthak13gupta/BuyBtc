import 'package:buy_bitcoin/pages/buyBtc.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  num? marketPrice = 43000;
  PreviewPage({this.marketPrice, super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final TextEditingController _controller = TextEditingController();
  num convertedVal = 0.00000;
  num marketPrice = 43000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  "USD",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      double val = value.isNotEmpty ? double.parse(value) : 0;
                      setState(() {
                        convertedVal = (val) / marketPrice;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const Text(
                  "BTC",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "$convertedVal",
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const BuyBtc(),
                ));
              },
              label: const Text("Confirm Buy"),
            )
          ],
        ),
      ),
    );
  }
}
