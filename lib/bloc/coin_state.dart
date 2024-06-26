import 'package:equatable/equatable.dart';
import '../data/coin_model.dart';

abstract class CoinState extends Equatable {
    const CoinState();

  @override
  List<Object> get props => [];
}

class CoinInitial extends CoinState {}

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final List<Coin> coins;
  final List<Coin> filteredCoins;

  const CoinLoaded({ required this.coins,  required this.filteredCoins});

  @override
  List<Object> get props => [coins, filteredCoins];
}

class CoinError extends CoinState {
  final String message;

  const CoinError(this.message);

  @override
  List<Object> get props => [message];
}

class PageChanged extends CoinState {
  final int pageIndex;

  const PageChanged(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}




