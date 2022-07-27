import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(BitcoinTicker());

class BitcoinTicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black87,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            color: Colors.amber.shade900,
          )),
      home: PriceScreen(),
    );
  }
}
