#!/bin/sh

# build.sh

PROJECT_NAME="FeedMe"
BUILD_DIR="Output"

mkdir -p "${BUILD_DIR}"

# compile project
echo Building Project

echo Increment Build No

PLIST="${PROJECT_NAME}/Info.plist"
PLB="/usr/libexec/PlistBuddy"
LAST_NUMBER=$($PLB -c "Print CFBundleVersion" "$PLIST")
NEW_VERSION=$((LAST_NUMBER + 1))
echo $NEW_VERSION
$PLB -c "Set :CFBundleVersion $NEW_VERSION" "$PLIST"

xcodebuild -workspace "${PROJECT_NAME}".xcworkspace -scheme "${PROJECT_NAME}"  archive -configuration release -sdk iphoneos -archivePath "${BUILD_DIR}/${PROJECT_NAME}".xcarchive

echo tag Build No

SHORT_VERSION=$($PLB -c "Print CFBundleShortVersionString" "$PLIST")
BUILD_NUMBER=$($PLB -c "Print CFBundleVersion" "$PLIST")
git tag v$SHORT_VERSION-build$BUILD_NUMBER
#git commit
#git push

#Check if build succeeded
if [ $? != 0 ]
then
  exit 1
fi


echo Generating IPA

xcodebuild -exportArchive -archivePath  "${BUILD_DIR}/${PROJECT_NAME}".xcarchive -exportOptionsPlist ExportOptionList.plist -exportPath  "${BUILD_DIR}"


echo Pushing to FB App distribution

firebase appdistribution:distribute "${BUILD_DIR}/${PROJECT_NAME}".ipa --app "FB_APP_ID" --groups test_group #--token "FB_TOKEN_REFREESH"
