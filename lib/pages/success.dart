import 'package:buy_bitcoin/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessPage extends StatefulWidget {
  final num buyAmountBtc;
  final num buyAmountUsd;
  const SuccessPage(
      {required this.buyAmountBtc, required this.buyAmountUsd, super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MyHomePage()));
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Color(0xFF00305E),
                ),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.network(
              "https://statics.myclickfunnels.com/image/595469/file/4b18f605527113817170bf856ede9dad.svg",
              semanticsLabel: 'Acme Logo',
              height: 50,
              width: 80,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 35,
                  color: Color(0xFF00305E),
                  // fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'You stacked\n',
                  ),
                  TextSpan(
                    text: 'with Swan!',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$ ${widget.buyAmountUsd}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_right_alt_rounded),
                Text(
                  "${widget.buyAmountBtc.toStringAsPrecision(6)} BTC",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'As computers get faster and the total\n'
                  'computing power applied to creating\n'
                  'bitcoins increases, the difficulty increases\n'
                  'proportionally to keep the total\n'
                  'new production constant.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF00305E),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8), // Adding a bit of spacing
                Text(
                  '- Satoshi Nakamoto',
                  style: TextStyle(
                    fontSize: 14, // smaller font size for the author's name
                    color: Color(0xFF00305E),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Tap: ',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Tap the amount to switch between Sats\n',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: 'and USD or to hide the amount completely.\n\n',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Share",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
