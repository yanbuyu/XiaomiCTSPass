#!/sbin/sh

#某些rec可能getprop会报错，干脆重写了一个获取ROM信息的函数
getName(){
    unset getValue
    [ -f $2 ] && getValue=`grep "${1}=" $2 | sed -n '$p' | cut -d'=' -f2 | sed 's# ##g' | tr -d '\n\r'`
}

##
systemBuildProp=/system/system/build.prop
[ ! -f $systemBuildProp ] && systemBuildProp=/system/build.prop
vendorBuildProp=/vendor/build.prop

##获取MIUI版本号
getName "ro.build.version.incremental" $systemBuildProp
VERSION="$getValue"
if [ ! "$VERSION" ];then
    getName "ro.system.build.version.incremental" $systemBuildProp
    VERSION="$getValue"
fi
##获取SDK版本
getName "ro.build.version.sdk" $systemBuildProp
SDK="$getValue"
if [ ! "$SDK" ];then
    getName "ro.system.build.version.sdk" $systemBuildProp
    SDK="$getValue"
fi
##获取安卓版本
getName "ro.build.version.release" $systemBuildProp
ANDROID="$getValue"
if [ ! "$ANDROID" ];then
    getName "ro.system.build.version.release" $systemBuildProp
    ANDROID="$getValue"
fi
##获取设备代号
getName "ro.product.device" $systemBuildProp
DEVICE="$getValue"
if [ ! "$DEVICE" ];then
    getName "ro.product.vendor.device" $vendorBuildProp
    DEVICE="$getValue"
fi
##对一个包对应多个机型代号的情况进行特殊处理
newName=$(getprop "ro.boot.hardware.sku" 2>/dev/null)
[[ "$newName" ]] && DEVICE="$newName"

##获取老设备型号
getName "ro.product.model" $systemBuildProp
MODEL="$getValue"
##获取build_xxx.prop路径
vendorBuildProps=$(ls /vendor/*build*.prop | sed 's#/vendor/build.prop##' 2>/dev/null)" /vendor/build.prop"
for buildProp in $vendorBuildProps;do
    getName "ro.product.vendor.device" $buildProp
    if [ "$getValue" ] && [ "$getValue" == "$DEVICE" ] && [ ! "$MODEL" ];then
        getName "ro.product.vendor.marketname" $buildProp
        MODEL="$getValue"
        [[ "$MODEL" ]] && break
    fi
done
##获取默认型号
if [ ! "$MODEL" ];then
    getName "ro.product.vendor.model" $vendorBuildProp
    MODEL="$getValue"
fi
##兼容sgsi
if [ ! "$MODEL" ];then
    getName "ro.product.system.model" $systemBuildProp
    MODEL="$getValue"
fi

##判断是否为小米或红米
getName "ro.build.fingerprint=" $systemBuildProp
fingerprint="$getValue"
if [[ ! "$fingerprint" ]];then
    getName "ro.vendor.build.fingerprint" $vendorBuildProp
    #ui_print "$getValue"
    fingerprint="$getValue"
    [[ -n "$fingerprint" ]] && FIRM=$(echo "$fingerprint" | cut -d'/' -f1 | tr "[A-Z]" "[a-z]")
fi
