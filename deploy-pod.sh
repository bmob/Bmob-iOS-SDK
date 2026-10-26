#!/bin/bash
set -euo pipefail
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$CURRENT_DIR"
VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then read -r -p "INPUT THE VERSION OF THE BMOB_SDK : " VERSION; fi
[[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Invalid version"; exit 1; }
SPEC_VERSION="$(ruby -e 'puts File.read("BmobSDK.podspec").match(/s\.version\s*=\s*"([^"]+)"/)[1]')"
[[ "$VERSION" == "$SPEC_VERSION" ]] || { echo "Update podspec to $VERSION first"; exit 1; }
bash "$CURRENT_DIR/build-xcframework.sh" "$VERSION"
pod lib lint BmobSDK.podspec --allow-warnings
if [[ "${2:-}" != --publish ]]; then
  echo "Build and validation complete. Use --publish to commit, tag, push and publish."
  exit 0
fi
if git rev-parse "$VERSION" >/dev/null 2>&1; then echo "Tag already exists: $VERSION"; exit 1; fi
git add BmobSDK_xcframework/BmobSDK.xcframework BmobSDK.podspec README.md Bmob_iOS_SDK更新历史.txt build-xcframework.sh deploy-pod.sh LICENSE-AliyunOSS
git diff --cached --check
git commit -m "chore(release): publish BmobSDK $VERSION"
git tag "$VERSION"
git push origin HEAD
git push origin "refs/tags/$VERSION"
pod spec lint BmobSDK.podspec --allow-warnings
pod trunk push BmobSDK.podspec --allow-warnings
