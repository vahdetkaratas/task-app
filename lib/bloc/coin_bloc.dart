import 'package:bloc/bloc.dart';
import 'package:kalem/data/coin_model.dart';
import 'package:kalem/data/coin_reporsitory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'coin_event.dart';
import 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinRepository repository;

  CoinBloc(this.repository) : super(CoinInitial()) {
    add(LoadFilters());
  }

  @override
  Stream<CoinState> mapEventToState(CoinEvent event) async* {
    if (event is FetchCoins) {
      yield CoinLoading();
      try {
        final coins = await repository.getCoins();
        yield CoinLoaded(coins: coins, filteredCoins: coins);
      } catch (e) {
        yield CoinError(e.toString());
      }
    } else if (event is SearchCoins) {
      if (state is CoinLoaded) {
        final allCoins = (state as CoinLoaded).coins;
        final filteredCoins = allCoins
            .where((coin) =>
                coin.code.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        yield CoinLoaded(coins: allCoins, filteredCoins: filteredCoins);
        _saveFilters(query: event.query);
      }
    } else if (event is SortCoins) {
      if (state is CoinLoaded) {
        final allCoins = (state as CoinLoaded).coins;
        final sortedCoins = List<Coin>.from((state as CoinLoaded).filteredCoins)
          ..sort((a, b) => event.ascending
              ? a.code.compareTo(b.code)
              : b.code.compareTo(a.code));
        yield CoinLoaded(coins: allCoins, filteredCoins: sortedCoins);
        _saveFilters(ascending: event.ascending);
      }
    } else if (event is LoadFilters) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? query = prefs.getString('query');
      bool? ascending = prefs.getBool('ascending');
      add(FetchCoins());
      if (query != null && query.isNotEmpty) {
        add(SearchCoins(query));
      }
      if (ascending != null) {
        add(SortCoins(ascending));
      }
    } else if (event is ChangePage) {
      yield PageChanged(event.pageIndex);
    }
  }

  Future<void> _saveFilters({String? query, bool? ascending}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (query != null) {
      prefs.setString('query', query);
    }
    if (ascending != null) {
      prefs.setBool('ascending', ascending);
    }
  }
}
