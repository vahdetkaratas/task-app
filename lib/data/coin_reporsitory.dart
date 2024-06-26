import 'coin_api_service.dart';
import 'coin_model.dart';

class CoinRepository {
  final CoinApiService apiService;

  CoinRepository(this.apiService);

  Future<List<Coin>> getCoins() {
    return apiService.fetchCoins();
  }
}
