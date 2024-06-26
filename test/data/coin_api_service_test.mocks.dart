// Generate this file by running `flutter pub run build_runner build` after adding the annotation below
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kalem/data/coin_api_service.dart';
import 'package:kalem/data/coin_model.dart';
import 'package:mockito/mockito.dart';

import 'coin_api_services.mocks.dart';

// Annotation which generates the mock HTTP client

void main() {
  group('CoinApiService', () {
    late CoinApiService apiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiService = CoinApiService(client: mockClient, baseUrl: 'https://api.coindesk.com/v1/bpi/currentprice.json');
    });

    test('returns a list of coins if the http call completes successfully', () async {
      final response = {
        "bpi": {
          "BTC": {"code": "BTC", "rate": "50000", "description": "Bitcoin"},
          "ETH": {"code": "ETH", "rate": "1500", "description": "Ethereum"}
        }
      };

      when(mockClient.get(Uri.parse(apiService.baseUrl)))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      final coins = await apiService.fetchCoins();

      expect(coins, isA<List<Coin>>());
      expect(coins.length, 2);
      expect(coins[0].code, 'BTC');
      expect(coins[1].code, 'ETH');
    });

    test('throws an exception if the http call completes with an error', () async {
      when(mockClient.get(Uri.parse(apiService.baseUrl)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(apiService.fetchCoins(), throwsException);
    });
  });
}
