import 'package:flutter_test/flutter_test.dart';
import 'package:kalem/bloc/coin_state.dart';
import 'package:kalem/data/coin_model.dart';

void main() {
  group('CoinState', () {
    test('CoinInitial supports value comparisons', () {
      expect(CoinInitial(), CoinInitial());
    });

    test('CoinLoading supports value comparisons', () {
      expect(CoinLoading(), CoinLoading());
    });

    test('CoinLoaded supports value comparisons', () {
      final coins = [
        Coin(code: 'USD', rate: '61,783.938', description: 'United States Dollar'),
        Coin(code: 'GBP', rate: '48,708.788', description: 'British Pound Sterling'),
        Coin(code: 'EUR', rate: '57,675.306', description: 'Euro'),
      ];

      expect(CoinLoaded(coins: coins, filteredCoins: coins), 
             CoinLoaded(coins: coins, filteredCoins: coins));
    });

    test('CoinError supports value comparisons', () {
      expect(const CoinError('error'), const CoinError('error'));
    });

    test('PageChanged supports value comparisons', () {
      expect(const PageChanged(1), const PageChanged(1));
    });
  });
}
