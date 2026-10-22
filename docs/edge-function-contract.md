# ChopQwik Edge Function contract review

**Review date:** 22 October 2026  
**Environment:** Supabase project `chopqwik-test` (`ogqjjbzdcmgurxnxnoah`)  
**Change type:** Read-only inspection; no database or provider configuration changed.

## Current verified blockers

1. `bill_providers`: 0 rows.
2. `bill_services`: 0 rows.
3. `bill_products`: 0 rows.
4. `v_bill_products_catalog`: 0 available rows.
5. Paystack configuration is marked sandbox and has a verification timestamp, but all bill capabilities are false.
6. VTPass is marked sandbox, but `config_verified_at` is null and all bill capabilities are false.
7. The current reserve status is `issuance_frozen=true`, `reserve_policy_complete=false`, `coverage_band=HARD_FREEZE`.

**Decision:** keep all purchase controls disabled until catalogue population, VTPass verification and category capability gates pass. Do not test by initiating a customer payment.

## Read interfaces

### Bill catalogue

The `public.v_bill_products_catalog` view exists with `security_invoker=true`; SELECT is granted to `anon` and `authenticated`. It exposes service/provider/product identifiers, amounts, customer-identifier requirements, typical fee, display order and maintenance fields. It currently returns no rows because the provider/service/product tables are empty.

The mobile app must show a safe empty/unavailable state, not fabricated products or prices.

## User-authenticated Edge Functions

All calls below are POST requests with the signed-in user's Supabase access token in `Authorization: Bearer <access_token>`. Do not send a service-role key from Flutter.

### `create_bill_transaction`

Request fields:
- `client_request_id`: client-generated stable idempotency value
- `type`: `airtime`, `data`, `electricity`, or `cable`
- `provider_product`: verified catalog product UUID or product code
- `customer_identifier`: Nigerian phone number for airtime/data, meter/smartcard identifier for electricity/cable
- `bill_amount_kobo`: integer amount in kobo
- `subscription_type`: required for cable, `renew` or `change`; omitted for other types

The server validates the authenticated user, provider readiness, product mapping, amount bounds/fixed amounts, customer identifier and idempotency. A successful response includes `transaction_id`, `status`, `payment_state`, amount fields and selected product details. Do not calculate trusted fees or final payable amount in the client.

### `verify_vtpass_customer`

Request: `{ "transaction_id": "<uuid>" }`

Use only for electricity/cable customer verification, before payment. It requires a transaction owned by the authenticated user in `created` state and verified VTPass sandbox configuration. It returns a verified customer name/evidence result or a failure code. It must not be treated as payment confirmation.

### `create_transaction_initiate_paystack`

Request: `{ "transaction_id": "<uuid>" }`

Requires the transaction to belong to the authenticated user, a verified sandbox Paystack configuration, a verified/enabled VTPass product and any required customer verification. A successful `funding_pending` response contains the Paystack `authorization_url` and may include an `access_code`. The client must launch checkout only when the server returns a valid authorization URL.

A `payment_status_pending` or `provider_outcome_unknown` response is not proof of payment failure. Refresh/reconcile the same transaction/reference; do not create a second purchase automatically.

### Transaction history and balance

- `transactions` has an authenticated SELECT grant and an own-user RLS policy. However, the table contains internal/provider fields (including provider request/response JSON and payment access/authorization fields). **Do not wire the mobile UI directly to a full-row `transactions` query yet.** First provide and review a minimal safe projection for transaction history/status.
- `get_payment_state_history(p_transaction_id)` is executable by authenticated users and checks ownership, but returns audit context JSON. Review/redact that context before displaying it in the customer UI.
- `get_user_coin_balance(p_user_id)` is not executable by `anon` or `authenticated`; no client balance call is approved by this review. Keep the UI balance as an unavailable placeholder while rewards are frozen.

## Backend-only functions — never call directly from Flutter

- `sync-vtpass-catalog`: requires service-role bearer authorization; sandbox-only. Its latest inspected configuration is not ready to populate the catalogue.
- `process_vtpass_fulfillment`: service-role only; initiates provider fulfillment after confirmed payment.
- `process_vtpass_requery`: service-role only; reconciles an existing VTPass request.
- `process_paystack_webhook` / `paystack-webhook`: server-to-server webhook handling; never invoke as a customer API.
- `sync-vtpass-float`, `award-reward`, `bootstrap_payment_sandbox`: operational/privileged functions; do not call from the mobile app.

## Payment state mapping

The `transactions` table contains both `status` and `payment_state`. They are related but not interchangeable. Keep both values in the repository/domain model and display a customer-friendly state mapping only after it is documented and tested.

At minimum:
- `created` / `pending_payment`: payment not confirmed
- `funding_pending` / `initiate_paystack_pending`: checkout is pending
- `funded` / `payment_confirmed`: payment confirmed; fulfillment is not necessarily complete
- `fulfillment_pending` or `processing`: provider outcome needs reconciliation
- `completed` / `fulfilled`: show success only when backend evidence supports completion
- `failed`, `refund_pending`, `refunded`: show distinct failure/refund states; do not infer refunds from timeouts

## Gate status

- **G1a — schema/function inventory:** reviewed.
- **G1b — catalogue availability:** BLOCKED (zero provider/service/product rows).
- **G1c — VTPass capability readiness:** BLOCKED (configuration verification timestamp absent; capabilities false).
- **G1d — safe transaction-history projection:** BLOCKED (no reviewed customer-facing projection identified).
- **G1e — Flutter compile/widget tests:** NOT YET RUN; CI workflow is added to the repository.
- **Rewards:** HARD FREEZE remains active.
- **Live payment testing:** NOT AUTHORIZED.
