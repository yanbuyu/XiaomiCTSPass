#!/sbin/sh
print_modname() {
  ui_print "*******************************"
  ui_print "          Xiaomi CTS Pass        "
  ui_print "          Author：yanbuyu    "
  ui_print "          Thanks：sekaiacg    "
  ui_print "*******************************"
}

#magiskhide enable

create_props(){
    propfile=$INSTALLER/props/${DEVICE}_sdk${SDK}.prop
    if [ -f $propfile ];then
        propsuffix=$(grep "ro.build.fingerprint=" $propfile | cut -d'=' -f2)
        rm -f $MODPATH/system.prop
        builds="ro.build.fingerprint ro.build.version.base_os ro.bootimage.build.fingerprint ro.system.build.fingerprint ro.system_ext.build.fingerprint ro.vendor.build.fingerprint ro.product.build.fingerprint ro.odm.build.fingerprint"
        for str in $builds;do
            echo "${str}=${propsuffix}" >>$MODPATH/system.prop
        done
        cat $propfile >>$MODPATH/system.prop
        ##检测模块与模块信息
        cp -af $INSTALLER/scripts/init.d $MODPATH/init.d
        cp -af $INSTALLER/module_pro.prop $MODPATH/module_pro.prop
        cp -af $INSTALLER/module.prop $MODPATH/module.prop
        cp -af $INSTALLER/post-fs-data.sh $MODPATH/post-fs-data.sh
        ##
        ui_print "- 当前设备代号：$DEVICE"
        ui_print "- 当前设备型号：$MODEL"
        ui_print "- 当前安卓SDK版本：$SDK"
        ui_print "- 当前安卓版本：$ANDROID"
        ui_print "- github地址：https://github.com/yanbuyu/XiaomiCTSPass"
    else
        ui_print "- 当前设备代号：$DEVICE"
        ui_print "- 当前设备型号：$MODEL"
        ui_print "- 当前安卓SDK版本：$SDK"
        ui_print "- 当前安卓版本：$ANDROID"
        ui_print "- github地址：https://github.com/yanbuyu/XiaomiCTSPass"
        abort "! 暂未收录该机型或该版本，您可按照开源地址上的说明自行适配"
    fi
}
