#!/sbin/sh

getpropPro(){
    propValue=`grep "${1}=" $2 | cut -d'=' -f2 | sed 's# ##g' | tr -d '\n\r'`
 }

blockList="system/system system_ext product system vendor"
for blockName in ${blockList};do
    buildFile=/$blockName/build.prop
    ##获取设备代号
    blockName=$(echo "$blockName" | sed "s#/system##g")
    deviceList="ro.product.${blockName}.device ro.product.device"
    for d in ${deviceList};do
        if [ -f $buildFile ];then
            getpropPro "$d" "$buildFile"
            if [ "$propValue" ] && [ "$propValue" != "qssi" ];then
                miuidevice=$propValue
                break
            fi
        fi
    done
    ##获取机型号
    modelList="ro.product.${blockName}.marketname ro.product.marketname ro.product.${blockName}.model ro.product.model"
    for d in ${modelList};do
        if [ -f $buildFile ];then
            getpropPro "$d" "$buildFile"
            if [ "$propValue" ] && [ ! "$(echo "$propValue" | grep -E "qssi|arm64")" ];then
                miuimodel=$propValue
                break
            fi
        fi
    done
    ##获取SDK
    SDKList="ro.${blockName}.build.version.sdk ro.build.version.sdk"
    for d in ${SDKList};do
        if [ -f $buildFile ];then
            getpropPro "$d" "$buildFile"
            if [ "$propValue" ];then
                SDK=$propValue
                break
            fi
        fi
    done
    ##获取miui版本号
    versionList="ro.${blockName}.build.version.incremental ro.build.version.incremental"
    for d in ${versionList};do
        if [ -f $buildFile ];then
            getpropPro "$d" "$buildFile"
            if [ "$propValue" ];then
                miuiversion=$propValue
                break
            fi
        fi
    done
done
