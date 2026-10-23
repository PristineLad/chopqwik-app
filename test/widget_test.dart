import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chopqwik_app/app.dart';
import 'package:chopqwik_app/screens/pay_screen.dart';

void main() {
  testWidgets('home shows Phase 1 services and preview-only status', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());

    expect(find.text('ChopQwik'), findsOneWidget);
    expect(find.text('What would you like to pay for?'), findsOneWidget);
    for (final label in ['Buy airtime', 'Buy data', 'Electricity', 'Cable TV']) {
      await tester.scrollUntilVisible(
        find.text(label),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(label), findsOneWidget);
    }

    final preview = find.text('Preview only · Payments are not enabled');
    await tester.scrollUntilVisible(
      preview,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(preview, findsOneWidget);

    final rewards = find.text('ChopCoins rewards are on hold');
    await tester.scrollUntilVisible(
      rewards,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.text('You cannot earn or spend ChopCoins yet. We will update this screen when rewards are approved.'),
      findsOneWidget,
    );
  });

  testWidgets('Home service tile opens Pay with the selected service', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    final airtimeTile = find.text('Buy airtime');
    await tester.scrollUntilVisible(airtimeTile, 250, scrollable: find.byType(Scrollable).first);
    final airtimeTapTarget = find.ancestor(
      of: airtimeTile,
      matching: find.byType(InkWell),
    ).first;
    await tester.ensureVisible(airtimeTapTarget);
    await tester.pumpAndSettle();
    await tester.tap(airtimeTapTarget);
    await tester.pumpAndSettle();

    expect(find.text('Pay a bill'), findsOneWidget);
    final payScrollable = find.descendant(of: find.byType(PayScreen), matching: find.byType(Scrollable)).first;
    await tester.scrollUntilVisible(find.text('Mobile network'), 200, scrollable: payScrollable);
    expect(find.text('Mobile network'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);

    final warning = find.text(
      'Preview only. No money will be collected and no bill will be paid. Do not treat this screen as a receipt.',
    );
    await tester.scrollUntilVisible(
      warning,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(warning, findsOneWidget);
  });

  testWidgets('airtime preview validates required fields before review', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PayScreen(initialService: 'Airtime')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    final review = find.text('Review details');
    await tester.scrollUntilVisible(
      review,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(review);
    await tester.pumpAndSettle();
    final reviewButton = find.byType(FilledButton).first;
    await tester.ensureVisible(reviewButton);
    await tester.tap(reviewButton);
    await tester.pumpAndSettle();

    expect(find.text('Choose a mobile network'), findsOneWidget);
    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.text('Enter an amount using numbers only'), findsOneWidget);
    expect(find.text('Review your details'), findsNothing);
  });

  testWidgets('valid preview details can be reviewed without starting payment', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('Pay').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Airtime').first);
    await tester.tap(find.text('Airtime').first);
    await tester.pumpAndSettle();

    final networkField = find.byType(DropdownButtonFormField<String>).first;
    await tester.ensureVisible(networkField);
    await tester.tap(networkField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('MTN').last);
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    expect(fields, findsNWidgets(2));
    await tester.ensureVisible(fields.at(0));
    await tester.enterText(fields.at(0), '08012345678');
    await tester.ensureVisible(fields.at(1));
    await tester.enterText(fields.at(1), '1000');

    final review = find.text('Review details');
    await tester.scrollUntilVisible(
      review,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(review);
    await tester.pumpAndSettle();

    expect(find.text('Review your details'), findsOneWidget);
    expect(find.text('This is a design preview. No payment will be started.'), findsOneWidget);
    expect(find.text('₦1000'), findsOneWidget);
    expect(find.text('Pay now'), findsNothing);
  });

  testWidgets('ChopCoins screen keeps rewards on hold and shows no invented balance', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('ChopCoins').last);
    await tester.pumpAndSettle();

    expect(find.text('Rewards are currently on hold'), findsOneWidget);
    expect(find.textContaining('issuance remains frozen'), findsOneWidget);
    expect(find.text('—'), findsOneWidget);
  });

  testWidgets('Home can select the same service again after leaving Pay', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    final airtimeTile = find.text('Buy airtime');
    final airtimeTapTarget = find.ancestor(
      of: airtimeTile,
      matching: find.byType(InkWell),
    ).first;
    await tester.ensureVisible(airtimeTapTarget);
    await tester.tap(airtimeTapTarget);
    await tester.pumpAndSettle();
    expect(find.text('Mobile network'), findsOneWidget);

    await tester.tap(find.text('Home').last);
    await tester.pumpAndSettle();
    final airtimeTileAgain = find.text('Buy airtime');
    final airtimeTapTargetAgain = find.ancestor(
      of: airtimeTileAgain,
      matching: find.byType(InkWell),
    ).first;
    await tester.ensureVisible(airtimeTapTargetAgain);
    await tester.tap(airtimeTapTargetAgain);
    await tester.pumpAndSettle();

    expect(find.text('Pay a bill'), findsOneWidget);
    expect(find.text('Mobile network'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
  });

  testWidgets('Profile clearly identifies the app as a guest preview', (tester) async {
    await tester.pumpWidget(const ChopQwikApp());
    await tester.tap(find.text('Profile').last);
    await tester.pumpAndSettle();

    expect(find.text('Guest preview'), findsOneWidget);
    expect(
      find.text('You are not signed in. Account registration and login are not connected in this preview.'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(find.text('Preview version · No account actions are available yet.'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.text('Preview version · No account actions are available yet.'), findsOneWidget);
  });
}
