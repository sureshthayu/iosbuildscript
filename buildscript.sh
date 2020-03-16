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

xcodebuild -exportArchive -archivePath  "${BUILD_DIR}/${PROJECT_NAME}".xcarchive -exportOptionsPlist ExportOptionList.plist -exportPath  "${BUILD_DIR}"

