# ARCHITECTURE
Overview: Intake/Validation → Figma Extractor/Drift → Static Analysis/Tests →
Auto-Repair (fixers → LLM with Judge/Verifier & AST/SMT) → Build/Sign →
Security/Policy (SBOM/Trivy, OPA) → Artifacts/Provenance (SLSA3+, cosign) → Observability/Billing/Tenancy.
Diagram placeholder: docs/diagrams/overview.png
