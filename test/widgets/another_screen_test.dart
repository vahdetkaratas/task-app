import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// The AnotherScreen widget
class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Another Screen'),
    );
  }
}

void main() {
  testWidgets('AnotherScreen displays correct text', (WidgetTester tester) async {
    // Build the AnotherScreen widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: AnotherScreen(),
      ),
    ));

    // Verify that the text 'Another Screen' is displayed
    expect(find.text('Another Screen'), findsOneWidget);
  });
}
