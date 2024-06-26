import 'package:flutter_test/flutter_test.dart';
import 'package:kalem/data/coin_api_service.dart';
import 'package:kalem/data/coin_model.dart';


void main() {
  group('CoinApiService', () {
    late CoinApiService apiService;

    setUp(() {
      apiService = CoinApiService(baseUrl: 'https://api.coindesk.com/v1/bpi/currentprice.json');
    });

    test('fetchCoins returns a list of coins', () async {
      final coins = await apiService.fetchCoins();
      expect(coins, isA<List<Coin>>());
    });
  });
}
