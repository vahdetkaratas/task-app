import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/coin_model.dart';
import '../utils/constants.dart';

class CoinListItem extends StatelessWidget {
  final Coin coin;
  final VoidCallback onTap;

  const CoinListItem({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        title: Text(
          coin.code,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: textColorPrimary,
          ),
        ),
        subtitle: Text(
          coin.rate,
          style: const TextStyle(
            fontSize: 20.0,
            color: textColorSecondary,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward, color: iconColor),
        onTap: onTap,
      ).animate().fadeIn(duration: 300.ms).scale(),
    );
  }
}
