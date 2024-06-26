import 'package:equatable/equatable.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();

  @override
  List<Object?> get props => [];
}

class FetchCoins extends CoinEvent {}

class SearchCoins extends CoinEvent {
  final String query;

  const SearchCoins(this.query);

  @override
  List<Object?> get props => [query];
}

class SortCoins extends CoinEvent {
  final bool ascending;

  const SortCoins(this.ascending);

  @override
  List<Object?> get props => [ascending];
}

class LoadFilters extends CoinEvent {}

class ChangePage extends CoinEvent {
  final int pageIndex;

  const ChangePage(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}
