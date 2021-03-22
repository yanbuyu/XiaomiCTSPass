#!/sbin/sh
currentDir=$(dirname $0)
modulesDir=$(dirname $currentDir)
newModule=$modulesDir/checkCTSModule
mkdir -p $newModule
cp -af $currentDir/module_pro.prop $newModule/module.prop
##自启脚本
SDK=$(getprop ro.build.version.sdk)
cat $currentDir/init.d | sed "s#REPLACE_SDK#$SDK#g;s#REPLACE_MODULE#$currentDir#g" >$newModule/post-fs-data.sh
