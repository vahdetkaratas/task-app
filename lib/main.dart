import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalem/data/coin_reporsitory.dart';
import 'package:kalem/widgets/home_screen.dart';
import 'bloc/coin_bloc.dart';
import 'data/coin_api_service.dart';
import 'utils/constants.dart';

void main() {
  final CoinApiService apiService = CoinApiService(baseUrl: 'https://api.coindesk.com/v1/bpi/currentprice.json');
  final CoinRepository repository = CoinRepository(apiService);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final CoinRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => CoinBloc(repository),
        child: const HomeScreen(),
      ),
    );
  }
}
