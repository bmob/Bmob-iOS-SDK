#!/bin/bash

# 设置变量
SCHEME="BmobSDK" # 你的 scheme/target 名称
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../Bmob-iOS/Bmob_iOS_Source_New/BmobMutiSDK/BmobSDK/BmobSDK.xcodeproj"
OUTPUT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/BmobSDK_xcframework"
FRAMEWORK_NAME="BmobSDK"

# 清理旧产物
rm -rf "${OUTPUT_DIR}"
mkdir -p "${OUTPUT_DIR}"

# 构建 iOS 设备 framework
xcodebuild archive \
  -project "${PROJECT_PATH}" \
  -scheme "${SCHEME}" \
  -configuration Release \
  -sdk iphoneos \
  -archivePath "${OUTPUT_DIR}/ios_devices.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# 构建 iOS 模拟器 framework
xcodebuild archive \
  -project "${PROJECT_PATH}" \
  -scheme "${SCHEME}" \
  -configuration Release \
  -sdk iphonesimulator \
  -archivePath "${OUTPUT_DIR}/ios_simulator.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# 合成 xcframework
xcodebuild -create-xcframework \
  -framework "${OUTPUT_DIR}/ios_devices.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
  -framework "${OUTPUT_DIR}/ios_simulator.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
  -output "${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework"

echo "✅ XCFramework 已生成：${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework"
