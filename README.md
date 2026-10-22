# ChopQwik Flutter App

ChopQwik's Phase 1 mobile application, built with Flutter and intended to integrate with Supabase.

## Phase 1 scope

- Airtime
- Mobile data
- Electricity
- Cable TV subscriptions

ChopQwik's broader company vision includes payments, rewards, engagement, commerce and logistics. Food, grocery and logistics ordering are not part of this Phase 1 app.

## Current implementation status

- Flutter navigation shell: Home, Pay, ChopCoins and Profile.
- Home service tiles navigate to the matching service in Pay.
- Pay includes a local-only preview form with service-specific fields and basic input validation. Reviewing details is not a payment and does not contact any provider.
- Profile clearly identifies guest preview and unavailable account actions.
- ChopCoins shows no spendable balance and states that rewards are on hold.
- Official logo is intentionally not finalised; the founder will provide the final asset later.
- Supabase Auth, live catalogue, real provider payment flow, transaction history and support actions are not connected.
- Real bill purchase must remain disabled until provider catalogue and sandbox payment/reconciliation tests pass.
- ChopCoins issuance/spending remains disabled while the board reserve hard freeze is active.
- No Supabase schema or provider configuration changes are part of this frontend work.

## Run locally

Install Flutter (Dart 3.7 / Flutter 3.29 or newer), then run:

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

## Configuration and secrets

Never commit provider credentials, Supabase service-role/secret keys, bootstrap tokens, or signing keys. The mobile app may use only a Supabase publishable key (or legacy anon key) with RLS; privileged operations must stay server-side.

## Integration readiness

See [the frontend/backend contract](docs/frontend-backend-contract.md), [the Edge Function review](docs/edge-function-contract.md), and [the UI design decisions](docs/ui-design-decisions.md).

As last audited, the bill provider/service/product tables are empty, VTPass sandbox configuration is not verified, and provider capabilities are disabled. Do not enable real payments or imply a bill was paid until the server confirms the outcome.
