import 'package:flutter_test/flutter_test.dart';
import 'package:chopqwik_app/app.dart';

void main() {
  testWidgets('shows the ChopQwik home and primary navigation', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    expect(find.text('ChopQwik'), findsOneWidget);
    expect(find.text('Pay a bill'), findsOneWidget);
    expect(find.text('ChopCoins'), findsWidgets);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('can navigate to the Pay screen', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('Pay').last);
    await tester.pumpAndSettle();
    expect(find.text('Choose a service to begin. Payments will be enabled after sandbox verification.'), findsOneWidget);
    expect(find.text('Airtime'), findsWidgets);
  });
}
