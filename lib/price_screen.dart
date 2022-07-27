import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
      dropdownItem.add(newItem);
    }

    return DropdownButton<String>(
      dropdownColor: Colors.black87,
      value: selectedCurrency,
      items: dropdownItem,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          getData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(
        currency,
        style: TextStyle(
          color: Colors.white,
        ),
      ));
    }

    return CupertinoPicker(
      offAxisFraction: 0.5,
      itemExtent: 42.0,
      onSelectedItemChanged: (selectedItem) {
        print(selectedItem);
        selectedCurrency = selectedItem.toString();
        getData();
      },
      children: pickerItems,
    );
  }

  Map<String, String> cryptoCoinValue = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      Map cryptoCoinRate = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        cryptoCoinValue = cryptoCoinRate as Map<String, String>;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Column getCards() {
    List<CryptoCard> cryptoCards = [];
    for (String coin in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          coinValue: isWaiting ? '?' : cryptoCoinValue[coin].toString(),
          selectedCurrency: selectedCurrency,
          cryptoCurrency: coin,
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CryptoCoin'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 0.0,
          ),
          getCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              bottom: 5.0,
              top: 5.0,
              left: 165.0,
              right: 150.0,
            ),
            color: Colors.amber.shade900,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.coinValue,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  }) : super(key: key);

  final String coinValue;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, .0),
      child: Card(
        color: Colors.amber[900],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          child: Text(
            '1 $cryptoCurrency = $coinValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Widget getPicker() {
//   return Platform.isIOS ? iosPicker() : androidDropdown();
// }

// DropdownButton<String>(
            //   dropdownColor: Colors.black87,
            //   value: selectedCurrency,
            //   items: getDropDownItems(),
            //   // items:
            //   //     currenciesList.map<DropdownMenuItem<String>>((String value) {
            //   //   return DropdownMenuItem<String>(
            //   //     value: value,
            //   //     child: Text(value),
            //   //   );
            //   // }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedCurrency = value.toString();
            //     });
            //   },
            // ),

// DropdownMenuItem(
//                   value: 'INR',
//                   child: Text(
//                     'INR',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 DropdownMenuItem(
//                   value: 'USD',
//                   child: Text(
//                     'USD',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 DropdownMenuItem(
//                   value: 'EUR',
//                   child: Text(
//                     'EUR',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),

// List<DropdownMenuItem<String>> getDropDownItems() {
//   List<DropdownMenuItem<String>> dropdownItem = [];
//   for (String currency in currenciesList) {
//     var newItem = DropdownMenuItem(
//       value: currency,
//       child: Text(
//         currency,
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//     dropdownItem.add(newItem);
//   }
//   return dropdownItem;
// }