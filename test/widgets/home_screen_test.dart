import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalem/ui/coin_list_screen.dart';
import 'package:kalem/bloc/coin_bloc.dart';
import 'package:kalem/bloc/coin_event.dart';
import 'package:kalem/bloc/coin_state.dart';
import 'package:kalem/widgets/another_screen.dart';
import 'package:kalem/widgets/home_screen.dart';
import 'package:mocktail/mocktail.dart';




// Mock classes for CoinBloc, CoinState, and CoinEvent
class MockCoinBloc extends MockBloc<CoinEvent, CoinState> implements CoinBloc {}
class FakeCoinEvent extends Fake implements CoinEvent {}
class FakeCoinState extends Fake implements CoinState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeCoinEvent());
    registerFallbackValue(FakeCoinState());
  });

  testWidgets('HomeScreen displays CoinListScreen when selectedIndex is 0', (WidgetTester tester) async {
    final mockCoinBloc = MockCoinBloc();

    when(() => mockCoinBloc.state).thenReturn(const PageChanged(0));
    whenListen(mockCoinBloc, Stream.fromIterable([const PageChanged(0)]));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CoinBloc>(
          create: (context) => mockCoinBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();  // Ensure all async operations are complete

    expect(find.byType(CoinListScreen), findsOneWidget);
    expect(find.byType(AnotherScreen), findsNothing);
  });

  testWidgets('HomeScreen displays AnotherScreen when selectedIndex is 1', (WidgetTester tester) async {
    final mockCoinBloc = MockCoinBloc();

    when(() => mockCoinBloc.state).thenReturn(const PageChanged(1));
    whenListen(mockCoinBloc, Stream.fromIterable([const PageChanged(1)]));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CoinBloc>(
          create: (context) => mockCoinBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();  // Ensure all async operations are complete

    expect(find.byType(CoinListScreen), findsNothing);
    expect(find.byType(AnotherScreen), findsOneWidget);
  });
}
