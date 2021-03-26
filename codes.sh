#!/sbin/sh
print_modname() {
  ui_print "*******************************"
  ui_print "          Xiaomi CTS Pass        "
  ui_print "          Author：yanbuyu    "
  ui_print "          Thanks：sekaiacg    "
  ui_print "*******************************"
}

create_props(){
    propfile=$INSTALLER/props/${miuidevice}_sdk${SDK}.prop
    if [ -f $propfile ];then
        propsuffix=$(grep "ro.build.fingerprint=" $propfile | cut -d'=' -f2)
        rm -f $MODPATH/system.prop
        builds="ro.bootimage.build.fingerprint ro.system.build.fingerprint ro.system_ext.build.fingerprint ro.vendor.build.fingerprint ro.product.build.fingerprint ro.odm.build.fingerprint"
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
        ui_print "- 当前机型代号：$miuidevice"
        ui_print "- 当前安卓SDK版本：$SDK"
        ui_print "- github地址：https://github.com/yanbuyu/XiaomiCTSPass"
    else
        abort "! 暂未收录该机型或该版本"
    fi
}
