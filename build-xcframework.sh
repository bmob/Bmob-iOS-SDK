#!/bin/bash
set -euo pipefail
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="${1:?Usage: bash build-xcframework.sh VERSION}"
PROJECT_PATH="$CURRENT_DIR/../Bmob-iOS/Bmob_iOS_Source_New/BmobMutiSDK/BmobSDK/BmobSDK.xcodeproj"
WORK_DIR="$(mktemp -d /tmp/bmob-sdk-build.XXXXXX)"
echo "Build output: $WORK_DIR"
for SDK in iphoneos iphonesimulator; do
  ARCHS_VALUE=arm64
  if [[ "$SDK" == iphonesimulator ]]; then ARCHS_VALUE="arm64 x86_64"; fi
  xcodebuild -project "$PROJECT_PATH" -target BmobSDK -configuration Release -sdk "$SDK" \
    ARCHS="$ARCHS_VALUE" ONLY_ACTIVE_ARCH=NO CODE_SIGNING_ALLOWED=NO \
    CONFIGURATION_BUILD_DIR="$WORK_DIR/$SDK" OBJROOT="$WORK_DIR/obj-$SDK" \
    MODULE_CACHE_DIR="$WORK_DIR/module-cache" build
  PLIST="$WORK_DIR/$SDK/BmobSDK.framework/Info.plist"
  /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $VERSION" "$PLIST"
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $VERSION" "$PLIST"
done
xcodebuild -create-xcframework \
  -framework "$WORK_DIR/iphoneos/BmobSDK.framework" \
  -framework "$WORK_DIR/iphonesimulator/BmobSDK.framework" \
  -output "$WORK_DIR/BmobSDK.xcframework"
DEST="$CURRENT_DIR/BmobSDK_xcframework/BmobSDK.xcframework"
if [[ -d "$DEST" ]]; then mv "$DEST" "$WORK_DIR/previous-BmobSDK.xcframework"; fi
mkdir -p "$(dirname "$DEST")"
cp -R "$WORK_DIR/BmobSDK.xcframework" "$DEST"
echo "XCFramework $VERSION: $DEST"
