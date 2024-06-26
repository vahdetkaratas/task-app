// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/coin_bloc.dart';
import '../bloc/coin_event.dart';
import '../bloc/coin_state.dart';
import 'coin_detail_screen.dart';
import '../widgets/coin_list_item.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constants.dart';

class CoinListScreen extends StatefulWidget {
  const CoinListScreen({super.key});

  @override
  _CoinListScreenState createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _sortOrder = 'Ascending';

  @override
  void initState() {
    super.initState();
    _loadInitialFilters();
    // Dispatch the FetchCoins event when the screen initializes
    BlocProvider.of<CoinBloc>(context).add(FetchCoins());
  }

  Future<void> _loadInitialFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? query = prefs.getString('query');
    bool? ascending = prefs.getBool('ascending');
    if (query != null && query.isNotEmpty) {
      _searchController.text = query;
      BlocProvider.of<CoinBloc>(context).add(SearchCoins(query));
    }
    if (ascending != null) {
      _sortOrder = ascending ? 'Ascending' : 'Descending';
      BlocProvider.of<CoinBloc>(context).add(SortCoins(ascending));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
     
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: searchHint,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                    ),
                    onChanged: (query) {
                      BlocProvider.of<CoinBloc>(context).add(SearchCoins(query));
                    },
                  ).animate().fadeIn(duration: 300.ms),
                ),
                const SizedBox(width: 8.0),
                DropdownButton<String>(
                  value: _sortOrder,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _sortOrder = value;
                      });
                      final bool ascending = value == 'Ascending';
                      BlocProvider.of<CoinBloc>(context).add(SortCoins(ascending));
                    }
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Ascending',
                      child: Text('Asc'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Descending',
                      child: Text('Desc'),
                    ),
                  ],
                  icon: const Icon(Icons.sort, color: primaryColor),
                  underline: Container(),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CoinBloc, CoinState>(
              builder: (context, state) {
                if (state is CoinLoading) {
                  return Center(child: const CircularProgressIndicator().animate().scale());
                } else if (state is CoinLoaded) {
                  if (state.filteredCoins.isEmpty) {
                    return Center(child: const Text(noMatchesFoundMessage).animate().fadeIn(duration: 300.ms));
                  }
                  return ListView.builder(
                    itemCount: state.filteredCoins.length,
                    itemBuilder: (context, index) {
                      return CoinListItem(
                        coin: state.filteredCoins[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CoinDetailScreen(
                                coin: state.filteredCoins[index],
                              ),
                            ),
                          );
                        },
                      ).animate().slide();
                    },
                  );
                } else if (state is CoinError) {
                  return Center(child: Text(state.message).animate().fadeIn(duration: 300.ms));
                } else {
                  return Center(child: const Text(noDataMessage).animate().fadeIn(duration: 300.ms));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
