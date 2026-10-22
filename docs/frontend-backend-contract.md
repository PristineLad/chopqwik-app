# ChopQwik frontend/backend contract — draft 0.1

## Scope
Phase 1 is a Flutter mobile app for airtime, mobile data, electricity and cable TV payments. Broader ChopQwik positioning includes rewards, engagement, commerce and logistics, but food, grocery and logistics ordering are outside Phase 1.

## Current frontend status
- Flutter UI shell only; no authentication or provider calls are wired.
- Home, Pay, ChopCoins and Profile navigation is present.
- Service buttons are placeholders and must not initiate payments.
- No balance, catalogue, transaction or user information is fabricated.

## Integration rules
1. Use only a Supabase publishable/anon client key in the mobile app. Never ship a service-role key, provider secret, bootstrap token, or encryption key.
2. Confirm authentication and row-level security before reading user-specific records.
3. The client must not directly create or update privileged payment state, payment evidence, webhook logs, reserve state, or reward ledger records.
4. Use reviewed server-side Edge Functions for customer verification, transaction preparation, Paystack checkout, VTPass fulfillment, requery, and status reconciliation.
5. A timeout or unknown provider result is not proof of failure. Reconcile using the same request/reference before offering a retry; do not silently create a duplicate purchase.
6. No live customer payments during this phase. Provider integration remains sandbox-only until explicit release review.
7. ChopCoins issuance and spending stay disabled in the app while the board reserve hard freeze is active. The UI must not imply rewards are available.
8. Store no provider credentials or private environment values in source control.

## Required contract review before integration
- Confirm exact column names, constraints, RLS policies and intended client access for the catalogue and authenticated user profile.
- Confirm request/response schemas, authorization requirements and idempotency behavior of each Edge Function.
- Confirm payment state mapping across the status and payment_state columns; do not assume they are interchangeable.
- Confirm approved public catalogue view or RPC, transaction-history RPC and safe user-profile access path.
- Add integration tests for unauthenticated access, another user's transaction, duplicate request IDs, provider timeout/requery, fulfillment failure and refund states.

## Release gates
- G1: schema and Edge Function contract reviewed.
- G2: Flutter app builds and navigation/widget tests pass.
- G3: auth and catalogue integration verified against sandbox/test users.
- G4: sandbox payment state transitions and duplicate protection tested.
- G5: independent security, reserve and release approval. No release based only on a successful UI demo.
