import 'package:flutter_test/flutter_test.dart';
import 'package:chopqwik_app/app.dart';

void main() {
  testWidgets('home presents the four Phase 1 services and honest preview status', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    expect(find.text('ChopQwik'), findsOneWidget);
    expect(find.text('What would you like to pay for?'), findsOneWidget);
    expect(find.text('Buy airtime'), findsOneWidget);
    expect(find.text('Buy data'), findsOneWidget);
    expect(find.text('Electricity'), findsOneWidget);
    expect(find.text('Cable TV'), findsOneWidget);
    expect(find.text('Preview only · Payments are not enabled'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('ChopCoins rewards are on hold'), 250, scrollable: find.byType(Scrollable).first);
    expect(find.text('You cannot earn or spend ChopCoins yet. We will update this screen when rewards are approved.'), findsOneWidget);
  });

  testWidgets('home service tile opens Pay with the selected service', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('Buy airtime'));
    await tester.pumpAndSettle();
    expect(find.text('Pay a bill'), findsOneWidget);
    expect(find.text('Airtime'), findsOneWidget);
    expect(find.text('Mobile network'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    final warning = find.text('Preview only. No money will be collected and no bill will be paid. Do not treat this screen as a receipt.');
    await tester.scrollUntilVisible(warning, 250, scrollable: find.byType(Scrollable).first);
    expect(warning, findsOneWidget);
  });

  testWidgets('airtime preview validates required fields before review', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('Pay').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Airtime').first);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Review details'));
    await tester.tap(find.text('Review details'));
    await tester.pumpAndSettle();
    expect(find.text('Choose a mobile network'), findsOneWidget);
    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.text('Enter an amount using numbers only'), findsOneWidget);
    expect(find.text('Review your details'), findsNothing);
  });

  testWidgets('valid preview details can be reviewed without initiating payment', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('Pay').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Airtime').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('MTN').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Phone number'), '08012345678');
    await tester.enterText(find.widgetWithText(TextFormField, 'Amount in naira (₦)'), '1000');
    await tester.ensureVisible(find.text('Review details'));
    await tester.tap(find.text('Review details'));
    await tester.pumpAndSettle();
    expect(find.text('Review your details'), findsOneWidget);
    expect(find.text('This is a design preview. No payment will be started.'), findsOneWidget);
    expect(find.text('₦1000'), findsOneWidget);
    expect(find.text('Pay now'), findsNothing);
  });

  testWidgets('ChopCoins screen keeps rewards on hold and does not invent a balance', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('ChopCoins').last);
    await tester.pumpAndSettle();
    expect(find.text('Rewards are currently on hold'), findsOneWidget);
    expect(find.textContaining('issuance remains frozen'), findsOneWidget);
    expect(find.text('—'), findsOneWidget);
  });
}
