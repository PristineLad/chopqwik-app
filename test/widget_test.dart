import 'package:flutter_test/flutter_test.dart';
import 'package:chopqwik_app/app.dart';

void main() {
  testWidgets('shows the ChopQwik home and Phase 1 services', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    expect(find.text('ChopQwik'), findsOneWidget);
    expect(find.text('What would you like to pay for?'), findsOneWidget);
    expect(find.text('Buy airtime'), findsOneWidget);
    expect(find.text('Buy data'), findsOneWidget);
    expect(find.text('Electricity'), findsOneWidget);
    expect(find.text('Cable TV'), findsOneWidget);
    await tester.ensureVisible(find.text('Rewards are temporarily on hold. You cannot earn or spend ChopCoins yet.'));
    await tester.pumpAndSettle();
    expect(find.text('Rewards are temporarily on hold. You cannot earn or spend ChopCoins yet.'), findsOneWidget);
    expect(find.text('Preview only. Bill payments are not available yet.'), findsOneWidget);
  });

  testWidgets('can navigate to the Pay screen without enabling payments', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('Pay').last);
    await tester.pumpAndSettle();
    expect(find.text('Choose a service to begin. Payments will be enabled after sandbox verification.'), findsOneWidget);
    expect(find.text('No real payment will be initiated from this preview.'), findsOneWidget);
  });

  testWidgets('ChopCoins screen keeps rewards on hold', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('ChopCoins').last);
    await tester.pumpAndSettle();
    expect(find.text('Rewards are currently on hold'), findsOneWidget);
    expect(find.textContaining('issuance remains frozen'), findsOneWidget);
  });
}
