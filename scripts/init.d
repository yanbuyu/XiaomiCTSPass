#!/sbin/sh
##检测安卓版本
SDK=$(getprop ro.build.version.sdk)
currentDir=REPLACE_MODULE
[ ! "$SDK" == REPLACE_SDK ] && rm -rf $currentDir
##比对指纹
fingerprint=$(getprop ro.build.fingerprint)
log=/data/system/fingerprint_record.log
if [ -d $currentDir ];then
    if [ -f "$log" ];then
        getline=$(cat $log | sed 's/\n//g')
        if [ "$getline" == "$fingerprint" ];then
            rm -f $currentDir/disable
        else
            [ ! -f $currentDir/disable ] && touch $currentDir/disable
        fi
    else
        rm -f $currentDir/disable
    fi
fi
echo "$fingerprint" >$log
