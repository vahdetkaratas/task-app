import 'dart:convert';
import 'package:http/http.dart' as http;
import 'coin_model.dart';

class CoinApiService {
  final String baseUrl;
  final http.Client client;

  CoinApiService({required this.baseUrl, http.Client? client})
      : client = client ?? http.Client();

  Future<List<Coin>> fetchCoins() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['bpi'] as Map<String, dynamic>;
      return data.values.map((json) => Coin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load coins');
    }
  }
}
