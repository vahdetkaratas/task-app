import 'package:flutter_test/flutter_test.dart';
import 'package:kalem/bloc/coin_event.dart';
void main() {
  group('CoinEvent', () {
    test('FetchCoins supports value comparisons', () {
      expect(FetchCoins(), FetchCoins());
    });

    test('SearchCoins supports value comparisons', () {
      expect(const SearchCoins('query'), const SearchCoins('query'));
      expect(const SearchCoins('query'), isNot(const SearchCoins('different_query')));
    });

    test('SortCoins supports value comparisons', () {
      expect(const SortCoins(true), const SortCoins(true));
      expect(const SortCoins(true), isNot(const SortCoins(false)));
    });

    test('LoadFilters supports value comparisons', () {
      expect(LoadFilters(), LoadFilters());
    });

    test('ChangePage supports value comparisons', () {
      expect(const ChangePage(1), const ChangePage(1));
      expect(const ChangePage(1), isNot(const ChangePage(2)));
    });
  });
}