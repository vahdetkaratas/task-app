import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalem/data/coin_model.dart';
import 'package:kalem/widgets/coin_list_item.dart';

void main() {
  testWidgets('CoinListItem displays coin data', (WidgetTester tester) async {
    final coin = Coin(code: 'BTC', rate: '50000', description: 'Bitcoin');
    onTap() {}

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CoinListItem(coin: coin, onTap: onTap),
      ),
    ));

    expect(find.text('BTC'), findsOneWidget);
    expect(find.text('50000'), findsOneWidget);
  });
}
