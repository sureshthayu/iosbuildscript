#!/bin/sh

# build.sh

PROJECT_NAME="FeedMe"
BUILD_DIR="Output"

mkdir -p "${BUILD_DIR}"

# compile project
echo Building Project

xcodebuild -workspace "${PROJECT_NAME}".xcworkspace -scheme "${PROJECT_NAME}"  archive -configuration release -sdk iphoneos -archivePath "${BUILD_DIR}/${PROJECT_NAME}".xcarchive

#Check if build succeeded
if [ $? != 0 ]
then
  exit 1
fi


echo Generating IPA

xcodebuild -exportArchive -archivePath  "${BUILD_DIR}/${PROJECT_NAME}".xcarchive -exportOptionsPlist ExportOptionList.plist -exportPath  "${BUILD_DIR}"


echo Pushing to FB App distribution

firebase appdistribution:distribute "${BUILD_DIR}/${PROJECT_NAME}".ipa --app "FB APP ID" --groups test_group #--token "FB_TOKEN_REFREESH"
