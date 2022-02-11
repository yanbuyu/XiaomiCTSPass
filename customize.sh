#!/sbin/sh
SKIPUNZIP=1

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
    rm -f $TMPDIR/system.prop
    builds="ro.build.fingerprint ro.build.version.base_os ro.bootimage.build.fingerprint ro.system.build.fingerprint ro.system_ext.build.fingerprint ro.vendor.build.fingerprint ro.product.build.fingerprint ro.odm.build.fingerprint"
    for str in $builds;do
        echo "${str}=${propsuffix}" >>$TMPDIR/system.prop
    done
    cat $propfile >>$TMPDIR/system.prop
}

create_props(){
    propfile=$TMPDIR/props/${DEVICE}_sdk${SDK}.prop
    if [ -f $propfile ];then
        main "$propfile"
        show_info
    elif [ "$FIRM" == "xiaomi" ] || [ "$FIRM" == "redmi" ];then
        propfile=$TMPDIR/props/_${FIRM}_sdk${SDK}.prop
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

# Mount partitions
mount_partitions

#额外挂载
if [ -d /dev/block/mapper ]; then
    mount -o ro -t auto /dev/block/mapper/product /product 2>/dev/null;
    mount -o ro -t auto /dev/block/mapper/system_ext /system_ext 2>/dev/null;
else
    mount -o ro -t auto /dev/block/bootdevice/by-name/product /product 2>/dev/null;
    mount -o ro -t auto /dev/block/bootdevice/by-name/system_ext /system_ext 2>/dev/null;
fi;
mount -o ro -t auto /product 2>/dev/null;
mount -o ro -t auto /system_ext 2>/dev/null;

#释放文件
mkdir -p $TMPDIR
unzip -o "$ZIPFILE" module.prop module_pro.prop post-fs-data.sh "props/*" "release/*" customize.sh 'scripts/*' -d $TMPDIR >&2

log=$(cat $TMPDIR/release/changelog.md | tr -s "\n" "\n")
ui_print "$log"
ui_print " "

#加载核心
[ ! -f $TMPDIR/scripts/getinfo.sh ] && abort "! Unable to extract getinfo.sh!"
. $TMPDIR/scripts/getinfo.sh

##
create_props

##复制文件
cp -af $TMPDIR/module.prop $MODPATH/module.prop
cp -af $TMPDIR/module_pro.prop $MODPATH/module_pro.prop
cp -af $TMPDIR/system.prop $MODPATH/system.prop
cp -af $TMPDIR/post-fs-data.sh $MODPATH/post-fs-data.sh
cp -af $TMPDIR/scripts/init.d $MODPATH/init.d

##取消挂载
umount product 2>/dev/null;
umount system_ext 2>/dev/null;
