import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalem/ui/coin_list_screen.dart';
import '../bloc/coin_bloc.dart';
import '../bloc/coin_event.dart';
import '../bloc/coin_state.dart';
import 'another_screen.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinBloc, CoinState>(
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is PageChanged) {
          selectedIndex = state.pageIndex;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Text(
                    navigationTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text(coinListTitle),
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<CoinBloc>(context).add(const ChangePage(0));
                    BlocProvider.of<CoinBloc>(context).add(FetchCoins()); // Ensure data is fetched
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text(anotherScreenTitle),
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<CoinBloc>(context).add(const ChangePage(1));
                  },
                ),
              ],
            ),
          ),
          body: selectedIndex == 0 ? const CoinListScreen() : const AnotherScreen(),
        );
      },
    );
  }
}
