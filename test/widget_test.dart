import 'package:flutter_test/flutter_test.dart';

import 'package:attendify/app/app.dart';

void main() {
  testWidgets('App should render without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Verify the temporary home page renders
    expect(find.text('Attendify'), findsOneWidget);
  });
}
