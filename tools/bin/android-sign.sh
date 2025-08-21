#!/usr/bin/env bash
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel)"
APP_PUBSPEC="$(git -C "$ROOT" ls-files '**/pubspec.yaml' | head -n1 || true)"
if [[ -z "${APP_PUBSPEC:-}" ]]; then
  echo "No Flutter project found; skip signing."
  exit 0
fi
APK_PATH="$(ls -1 "$(dirname "$APP_PUBSPEC")"/build/app/outputs/flutter-apk/app-debug.apk 2>/dev/null || true)"
if [[ -z "${APK_PATH:-}" ]]; then
  echo "No APK found to sign; ensure android-build ran first."
  exit 0
fi
if [[ -z "${ANDROID_KEYSTORE_BASE64:-}" || -z "${ANDROID_KEY_ALIAS:-}" || -z "${ANDROID_KEYSTORE_PASSWORD:-}" || -z "${ANDROID_KEY_PASSWORD:-}" ]]; then
  echo "Android signing secrets not present; skipping signing (non-blocking)."
  exit 0
fi
WORK="$(mktemp -d)"
echo "$ANDROID_KEYSTORE_BASE64" | base64 -d > "$WORK/keystore.jks"
export ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-$HOME/android-sdk}"
echo y | sdkmanager --licenses >/dev/null 2>&1 || true
sdkmanager "build-tools;34.0.0" >/dev/null
BUILD_TOOLS="$ANDROID_SDK_ROOT/build-tools/34.0.0"
SIGNED_APK="${APK_PATH%.apk}-signed.apk"
"$BUILD_TOOLS/apksigner" sign --ks "$WORK/keystore.jks" --ks-key-alias "$ANDROID_KEY_ALIAS" --ks-pass "pass:$ANDROID_KEYSTORE_PASSWORD" --key-pass "pass:$ANDROID_KEY_PASSWORD" --out "$SIGNED_APK" "$APK_PATH"
"$BUILD_TOOLS/apksigner" verify "$SIGNED_APK"
mkdir -p "$ROOT/build_reports"
jq -n --arg path "$(python3 - <<PY
import os,sys
print(os.path.realpath(sys.argv[1]))
PY
 "$SIGNED_APK")" '
{
  platform:"android",
  signed_apk_debug:{path:$path},
  timestamp: (now | strflocaltime("%Y-%m-%dT%H:%M:%SZ"))
}' > "$ROOT/build_reports/BuildReport.signed.json"
echo "Signed APK: $SIGNED_APK"
