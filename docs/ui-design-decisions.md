# ChopQwik Phase 1 — UI and accessibility decisions

Status: APPROVED DESIGN DIRECTION; implementation and usability testing remain in progress.

## Brand source of truth
- Use the supplied official ChopQwik Q symbol and wordmark, preserving their red-to-gold identity.
- Do not redraw, distort, recolour, or substitute the official logo with a generic bolt icon in final release assets.
- The supplied logo preview includes a checkerboard background. Do not ship that preview as a logo asset; obtain a clean transparent SVG/PNG or vector source before adding it to Flutter assets.
- Use a restrained brand palette: deep red as the primary action colour, gold as a supporting accent, neutral surfaces, and high-contrast text.
- Support a clean light theme first. A dark theme may be added after contrast and device testing; do not make the dark promotional mockup the only theme.

## Phase 1 scope visible in the app
Primary bill services:
1. Airtime
2. Data
3. Electricity
4. Cable TV

Do not present a stored-value wallet, cash-out, peer-to-peer transfers, merchant acceptance, or "pay and get paid" as live Phase 1 capabilities. Logistics belongs to the broader ChopQwik vision, not the Phase 1 bill-payment flow.

## Rewards safety
- Keep ChopCoins visible only with clear explanatory copy that earning and spending are currently unavailable.
- Do not show a spendable balance, promise rewards on a transaction, or make reward issuance available until the board reserve conditions are independently verified and the freeze is explicitly cleared.

## Low-literacy and accessibility rules
- Use familiar action words: "Buy airtime", "Buy data", "Pay electricity bill", "Pay TV bill".
- Pair every meaningful icon with a text label. Never rely on colour or an icon alone to explain a choice.
- Use large, well-spaced tap targets; a 48 logical-pixel minimum is the implementation target.
- Keep one obvious primary action per screen and short sentences.
- Use readable text, strong contrast, clear field labels, and visible validation errors next to the field that needs attention.
- Show Naira amounts clearly and itemise any applicable fee before the user confirms payment.
- Never describe a payment as successful until the server/provider result confirms it.
- For an uncertain payment result, explain that it is being checked and discourage starting a duplicate transaction.
- Avoid decorative 3D art and large lifestyle photos in transactional screens; optimise for affordable Android phones, fast loading, and focus.

## Claims and trust
- Do not claim "bank-grade security", encryption properties, or other certifications unless the exact claim has been technically verified and approved.
- Do not imply that payment, catalogue, or rewards functionality is live while its integration is unverified.
- Use explicit disabled states and helpful explanations rather than controls that appear to work but do nothing.

## Screen direction
- Welcome/onboarding: official logo, one plain-language value proposition, clear "Get started" and "Log in" actions, and no list of future features presented as available.
- Home: the four Phase 1 services first; a concise ChopCoins status section below them.
- Pay: service selection, customer details, amount, fee breakdown, review, and a clear confirm action.
- Payment status: plain-language status, reference/help option, and no unsafe duplicate-payment retry.
- ChopCoins: explain the freeze and show no spendable balance or reward promise.
- Profile: account and support information; no unsupported financial account features.

## Release gate
The UI shell is not a production-ready payment app. Before real transactions, complete authentication, safe customer-facing backend projections, populated and verified provider catalogue, sandbox integration tests, idempotency/requery handling, and end-to-end Android tests. Keep all service-role keys and provider secrets server-side.
