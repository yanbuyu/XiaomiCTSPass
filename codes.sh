#!/sbin/sh
print_modname() {
  ui_print "*******************************"
  ui_print "          Xiaomi CTS Pass        "
  ui_print "          Author：yanbuyu    "
  ui_print "          Thanks：sekaiacg    "
  ui_print "*******************************"
  log=$(cat $INSTALLER/release/changelog.md | tr -s "\n" "\n")
  ui_print "$log"
  ui_print " "
}

#magiskhide enable

show_info(){
    ui_print "- 当前设备制造商：$FIRM"
    ui_print "- 当前设备代号：$DEVICE"
    ui_print "- 当前设备型号：$MODEL"
    ui_print "- 当前安卓SDK版本：$SDK"
    ui_print "- 当前安卓版本：$ANDROID"
    ui_print "- github地址：https://github.com/yanbuyu/XiaomiCTSPass"
}

main(){
    propsuffix=$(grep "ro.build.fingerprint=" $1 | cut -d'=' -f2)
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
}

create_props(){
    propfile=$INSTALLER/props/${DEVICE}_sdk${SDK}.prop
    if [ -f $propfile ];then
        main "$propfile"
        show_info
    elif [ "$FIRM" == "xiaomi" ] || [ "$FIRM" == "redmi" ];then
        propfile=$INSTALLER/props/_${FIRM}_sdk${SDK}.prop
        if [ -f "$propfile" ];then
            ui_print "- 暂未收录该机型或该版本, 正在开启兼容模式..."
            main "$propfile"
            show_info
        else
            show_info
            abort "! 该机型或该版本不支持兼容模式，您可按照开源地址上的说明自行适配"
        fi
    else
        show_info
        abort "! 暂未收录该机型或该版本，您可按照开源地址上的说明自行适配"
    fi
}
