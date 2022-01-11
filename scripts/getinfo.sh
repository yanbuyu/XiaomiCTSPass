#!/sbin/sh

#某些rec可能getprop会报错，干脆重写了一个获取ROM信息的函数
getName(){
    unset getValue
    [ -f $2 ] && getValue=`grep "${1}=" $2 | cut -d'=' -f2 | sed 's# ##g' | tr -d '\n\r'`
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

##获取老设备型号
getName "ro.product.model" $systemBuildProp
MODEL="$getValue"
##获取build_xxx.prop路径
vendorBuildProps=$(ls /vendor/*.prop 2>/dev/null)
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
