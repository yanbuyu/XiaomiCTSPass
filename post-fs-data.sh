#!/sbin/sh
mount -o remount,rw -t auto /data

##变量
MODDIR=${0%/*}
MODSDIR=$(dirname ${MODDIR%/*})/XiaomiCTSPass
systemprop=$MODDIR/system.prop
systemprop_bak=$MODDIR/system.prop.bak
moduleprop=$MODDIR/module.prop
##检测安卓版本
SDK=$(getprop ro.build.version.sdk)
[[ "$SDK" != REPLACE_SDK ]] && rm -rf $MODDIR
##比对指纹
fingerprint=$(getprop ro.build.fingerprint)
mkdir -p $MODSDIR
log=$MODSDIR/fingerprint_record.log
if [ -f "$log" ];then
    getline=$(cat $log | sed 's/\n//g;s/\r//g')
    if [ "$getline" == "$fingerprint" ];then
        [[ -f $systemprop_bak ]] && mv -f $systemprop_bak $systemprop
        sed -i "s#description=.*#description=强制小米设备通过谷歌CTS测试，github开源地址：https://github.com/yanbuyu/XiaomiCTSPass#" $moduleprop
    else
        [[ -f $systemprop ]] && mv -f $systemprop $systemprop_bak
        sed -i "s#description=.*#description=🤔该设备似乎刚更新完系统，请重启设备以激活XiaomiCTSPass#" $moduleprop
    fi
fi
echo "$fingerprint" >$log
