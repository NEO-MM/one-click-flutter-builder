# SECURITY BASELINE
- OIDC→KMS for secrets only; no plaintext.
- Ephemeral isolated runners; egress allowlist.
- SBOM + vuln gating (Trivy/OSV); OPA policies.
- SLSA3+ provenance with cosign & transparency log.
- Responsible disclosure: security@example.com.
