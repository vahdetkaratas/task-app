import 'package:flutter_test/flutter_test.dart';
import 'package:kalem/data/coin_model.dart';

void main() {
  group('Coin', () {
    test('can be serialized to JSON', () {
      final coin = Coin(
        code: 'BTC',
        rate: '50000.0',
        description: 'Bitcoin',
      );

      final json = coin.toJson();

      expect(json['code'], 'BTC');
      expect(json['rate'], '50000.0');
      expect(json['description'], 'Bitcoin');
    });

    test('can be deserialized from JSON', () {
      final json = {
        'code': 'BTC',
        'rate': '50000.0',
        'description': 'Bitcoin',
      };

      final coin = Coin.fromJson(json);

      expect(coin.code, 'BTC');
      expect(coin.rate, '50000.0');
      expect(coin.description, 'Bitcoin');
    });
  });
}
