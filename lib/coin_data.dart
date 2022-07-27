import 'package:bitcoin_ticker_flutter/networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'MATIC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx';
// const apiKey = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx';

class CoinData {
  Future<Map> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoListPrice = {};
    for (String coin in cryptoList) {
      print(coin);
      String url = '$coinAPIURL/$coin/$selectedCurrency?apikey=$apiKey';
      NetworkHelper networkHelper = NetworkHelper(url);
      var coinRate = await networkHelper.getData();
      cryptoListPrice[coin] = coinRate.toStringAsFixed(2);
    }
    return cryptoListPrice;
  }
}

// CoinData(this.selectedCurrency);
// String selectedCurrency;
