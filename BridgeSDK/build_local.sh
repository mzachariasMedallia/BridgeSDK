#!/bin/sh

bold=$(tput bold)
reset=$(tput sgr0)

if [ "$1" = "-h" ]; then
  echo "Usage: build_local.sh [-d] [-{TARGET}]"
  echo "    -d             Compile in Debug mode"
  echo "    {TARGET}       Specify the target name of the Xcode project"
  exit 1
fi

if [ $# -eq 2 ]; then
  mode=$1
  target=${2:1}
else
  if [ "$1" = "-d" ]; then
    mode=$1
  else
    target=${1:1}
  fi
fi

SDK_DIR="$HOME/Development/private/DynamicLibrary/BridgeSDK/BridgeSDK"
MODE=Release
VERSION=`git describe --tags --abbrev=0`

echo

if [ "$mode" = "-d" ]; then
  echo "${bold}** DEBUG MODE **${reset}"
  MODE=Debug
else
  echo "${bold}** RELEASE MODE **${reset}"
fi

echo

ARCHIVE_DIR="$SDK_DIR/Archives/$MODE/BridgeSDK"
ARCHIVE_DIR_SIMULATOR="$SDK_DIR/Archives/$MODE/BridgeSDK-Simulator"
XCFRAMEWORK_DIR="$SDK_DIR/$VERSION/"

rm -rf "$ARCHIVE_DIR.xcarchive"
rm -rf "$ARCHIVE_DIR_SIMULATOR.xcarchive"
rm -rf "$XCFRAMEWORK_DIR"

sleep 1

xcodebuild archive \
    -scheme "BridgeSDK" \
    -destination "generic/platform=iOS" \
    -archivePath "$ARCHIVE_DIR" \
    -configuration "$MODE" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    
xcodebuild archive \
    -scheme "BridgeSDK" \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "$ARCHIVE_DIR_SIMULATOR" \
    -configuration "$MODE" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
    -framework "$ARCHIVE_DIR.xcarchive/Products/Library/Frameworks/BridgeSDK.framework" \
    -framework "$ARCHIVE_DIR_SIMULATOR.xcarchive/Products/Library/Frameworks/BridgeSDK.framework" \
    -output "$XCFRAMEWORK_DIR/BridgeSDK.xcframework"
    
#codesign --timestamp -v --sign "Apple Distribution: Decibel Insight Ltd. (RLTB3DP362)" "$XCFRAMEWORK_DIR"

cp "$SDK_DIR/Package.swift" "$XCFRAMEWORK_DIR/Package.swift"

rm -rf "$SDK_DIR/Archives/"
