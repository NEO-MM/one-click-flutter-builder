<div align="center">

# 🚀 One-Click Mobile Builder for Flutter
**Flutter repo + Figma → auto-test, auto-repair, sign, and ship iOS/Android in one click.**

![Build Status](https://img.shields.io/badge/ci-setup--pending-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Conventional Commits](https://img.shields.io/badge/commits-Conventional%20Commits-orange)
![SemVer](https://img.shields.io/badge/versioning-SemVer-lightgrey)

</div>

## Executive Summary
This tool converts any **Flutter codebase** and **Figma designs** into **store-ready iOS & Android builds** automatically.  
It finds issues, **repairs them**, re-tests until green, then **signs and packages** release artifacts with full **security & provenance**.

## Product Explanation (Problem → Solution → Outcomes)
- **Problem:** Build breaks, config drift, and store compliance waste time.
- **Solution:** A **one-click** pipeline that analyzes code & Figma, auto-fixes, validates quality, and produces **signed** `.aab/.apk` and **IPA/TestFlight**.
- **Outcomes:** Faster releases, fewer regressions, policy-compliant, audit-ready.

## Detailed Product Overview (Inputs → Process → Outputs)
- **Inputs:** Flutter repo (zip/Git), Figma URLs + token, build profile, optional YAML “build hints” & design tokens.
- **Process:** Preflight → Static analysis → Auto-repair (deterministic fixers → LLM plans) → Tests (unit/widget/smoke/fuzz) →  
  Golden & drift checks → A11y/i18n → Perf/size budgets → Security (SBOM/trivy) & Policy (OPA) → Store compliance.
- **Outputs:** Signed `.aab/.apk` and IPA/TestFlight receipt, `SBOM`, `SARIF`, `RepairLog.md`, `DesignDriftReport.json`, SLSA3+ provenance, logs & videos.

## Scope
- Deterministic, reproducible builds on isolated runners (Android in containers; iOS on ephemeral macOS).
- Auto-repair for Dart/Flutter, Gradle/Xcode, assets, i18n, tests/lints, Figma constraints/token drift.
- Security gates (SBOM/vulns), OPA policy checks, provenance attestations.

## Non-Scope
- We do not author your app’s business logic.
- No long-term secret storage (keys via OIDC→KMS only during builds).

## Phase 0 Summary (Concise)
- **Architecture:** intake/validation, Figma extractor & drift checker, static suite, **Auto-Repair Orchestrator** (fixers → LLM with Judge/Verifier & AST/SMT), build/sign/export, policy/vuln gates, artifacts/provenance, observability, billing, tenancy, CLI/Web.
- **Quality Gates:** lints/tests OK; design drift ≤ threshold; a11y & i18n OK; perf/size budgets met; no High/Critical vulns; store compliance pass; reproducible capsule; signed artifacts + SLSA provenance.
- **Security:** ephemeral runners; egress allowlist; OIDC→KMS; SBOM; SLSA3+; cosign; transparency log.
- **Ops:** cache strategy; cost controls; A/B canary for models/prompts; SLA credits.

## Phase 1 Roadmap
1) Create repo & skeleton  
2) Add standards, governance, and docs  
3) Seed CI scaffold and labels  
4) Protect `main` and link Project board  
5) Ready for Phase 2 (workflows/scripts/infra)

## Architecture Overview
Intake & Preflight → Figma Extractor & Drift → Static Analysis & Tests → Auto-Repair → Build/Sign → Security/Policy → Artifacts/Provenance.  
*Diagram placeholder:* `docs/diagrams/overview.png`.

## Security & Compliance Baseline
Secrets via **OIDC→KMS** only; ephemeral runners; network egress allowlist; SBOM + vuln gating; OPA checks; SLSA3+ provenance.  
See `docs/SECURITY.md`.

## Repository Structure
(See the tree in this README and the `docs/` folder for details.)

## Contribution Quick Start
Use **Conventional Commits**. Open a PR. Ensure CI is green. See `CONTRIBUTING.md`.

## License & Support
MIT License. For help open an Issue. Security disclosures: security@example.com.
