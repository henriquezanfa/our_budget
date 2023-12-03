import 'package:flutter_test/flutter_test.dart';
import 'package:ob/app/app.dart';
import 'package:ob/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
