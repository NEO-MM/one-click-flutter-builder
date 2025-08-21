#!/usr/bin/env bash
set -euo pipefail
# Example usage: bash tools/bin/set-android-secrets.example.sh keystore.jks alias storepass keypass
# This will base64-encode your keystore and store all values as GitHub repo secrets.
FILE="$1"; ALIAS="$2"; STOREPASS="$3"; KEYPASS="$4"
B64="$(base64 < "$FILE")"
OWNER="$(gh api user -q .login)"
REPO="one-click-flutter-builder"
printf "%s" "$B64" | gh secret set ANDROID_KEYSTORE_BASE64 --repo "$OWNER/$REPO"
printf "%s" "$ALIAS" | gh secret set ANDROID_KEY_ALIAS --repo "$OWNER/$REPO"
printf "%s" "$STOREPASS" | gh secret set ANDROID_KEYSTORE_PASSWORD --repo "$OWNER/$REPO"
printf "%s" "$KEYPASS" | gh secret set ANDROID_KEY_PASSWORD --repo "$OWNER/$REPO"
echo "Secrets set for $OWNER/$REPO"
