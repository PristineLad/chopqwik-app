# ChopQwik Flutter App

ChopQwik's Phase 1 mobile application, built with Flutter and Supabase.

## Phase 1 scope

- Airtime
- Mobile data
- Electricity
- Cable TV subscriptions

ChopQwik's broader company vision includes payments, rewards, engagement, commerce and logistics. Food, grocery and logistics ordering are not part of this Phase 1 app.

## Current status

- Initial Flutter navigation shell and four screens are committed.
- Home, Pay, ChopCoins and Profile are preview screens.
- Payment buttons are intentionally disabled.
- Authentication, live catalogue data and provider payment flows are not yet connected.
- ChopCoins issuance/spending remains disabled while the board reserve hard freeze is active.
- Supabase backend is not to be changed as part of frontend work without a separate reviewed decision.

## Run locally

Install Flutter (Dart 3.7 / Flutter 3.29 or newer), then run:

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

## Configuration and secrets

Never commit provider credentials, Supabase service-role/secret keys, bootstrap tokens, or signing keys. The mobile app may use only the Supabase publishable key (or legacy anon key) with RLS; privileged operations must stay server-side.

## Integration readiness

See [the frontend/backend contract](docs/frontend-backend-contract.md) and [the current Edge Function review](docs/edge-function-contract.md). As of 22 October 2026, the bill provider/service/product tables are empty, VTPass sandbox configuration is not verified, and provider capabilities are disabled. Therefore, real bill purchase must remain disabled.
