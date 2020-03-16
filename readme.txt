steps to setup ios build script

1. copy buildscript.sh and ExportOptionList.plist file into the root folder of xcode project.
2. open & edit buildscript to your project name.
3. open & edit ExportOptionList plist to teamID - XXXXXXXXX
4. add method to <string>ad-hoc</string> for distribution.
5. or if add method to <string>development</string> for development.
5. add method to <string>app-store</string> for app-store.
6. once updated with edits, open terminal to this project root folder (where project file).
7. type sh buidscript.sh
8. will create xcarchive and ipa (and other log file), under the build_dir (output example)

reference:
https://gist.github.com/cocoaNib/502900f24846eb17bb29


