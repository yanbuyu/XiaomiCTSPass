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
        ##自启目录
        cat $INSTALLER/scripts/getinfo.sh >$MODPATH/post-fs-data.sh
        cat $INSTALLER/init.d | sed "s#REPLACE_SDK#$SDK#g;s#REPLACE_MODULE#$NVBASE/modules/XiaomiCTSPass#g" >>$MODPATH/post-fs-data.sh
        ##
        cp -af $INSTALLER/module.prop $MODPATH/module.prop
        ##
        ui_print "- 当前机型代号：$miuidevice"
        ui_print "- 当前安卓SDK版本：$SDK"
    else
        abort "! 暂未收录该机型"
    fi
}
