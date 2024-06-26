import 'package:flutter/material.dart';
import '../data/coin_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constants.dart';

class CoinDetailScreen extends StatelessWidget {
  final Coin coin;

  const CoinDetailScreen({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${coin.code}$detailScreenTitleSuffix'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Code: ${coin.code}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColorPrimary,
                    ),
                  ).animate().fadeIn(duration: 300.ms).slide(),
                  const SizedBox(height: 16),
                  Text(
                    'Rate: ${coin.rate}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: textColorSecondary,
                    ),
                  ).animate().fadeIn(duration: 500.ms).slide(),
                  const SizedBox(height: 16),
                  Text(
                    'Description: ${coin.description}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: textColorDescription,
                    ),
                  ).animate().fadeIn(duration: 700.ms).slide(),
                ],
              ),
            ).animate().scale(duration: 300.ms),
          ],
        ),
      ),
    );
  }
}
