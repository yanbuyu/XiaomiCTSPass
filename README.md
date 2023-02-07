# XiaomiCTSPass
### 强制小米设备通过谷歌CTS测试.

#### 描述信息
- 此项目为Magisk模块，可在Magisk Manager App或第三方Recovery（本质还是依赖Magisk环境）中刷入。

#### 自定义扩展
- `./XiaomiCTSPass/props/`下的文件名格式为`机型代号_sdk及版本号.prop`，以安卓11（SDK版本号为30）的小米10机型为例，扩展文件名应为`umi_sdk30.prop`。
- 从小米设备的稳定版固件中提取`ro.build.fingerprint` `ro.build.description` `ro.build.version.security_patch`属性，具体参考`./XiaomiCTSPass/props/`下的文件内容。
- 兼容模式：可提取其他机型的属性强行适配某机型，但文件名格式必须严格按照某机型信息填写，若遇到BUG，请自行卸载模块。

#### 如何使用
- 下载源码，然后安装clang环境，直接make编译出模块；也可在Releases直接下载已经生成的模块；又或者切换至项目根目录下，将所有文件打包成zip压缩包。
- 在面具应用中安装添加编译出来的模块。
- 支持在面具中直接更新。

#### 特别说明
- 跨版本升级时，设备系统会自动比对fingerprint（指纹）属性，从而确定是否正常更新内容，此时如果依然挂载XiaomiCTSPass模块，那么系统更新前后fingerprint（指纹）将完全一致，进而可能导致刷机包中部分更新内容无法更新进设备系统。基于以上理由，每次系统升级后，XiaomiCTSPass模块会自动移除system.prop；更新完开机后，重启一次，即可自动激活XiaomiCTSPass模块，恢复system.prop。注意！这不是XiaomiCTSPass模块的BUG，而是为了保证系统正常稳定升级而有意为之的特性。
- 若Magisk为非zygisk版，刷完后必须开启magisk hide。
- 若系统是2021年8月份后的MIUI版本或Magisk为zygisk版，XiaomiCTSPass模块必须搭配[Universal SafetyNet Fix模块](https://github.com/kdrag0n/safetynet-fix)使用。
- 禁用或启用XiaomiCTSPass模块时，需重新载入参数，首次开机时间变长属于正常情况。

#### 支持机型
- 后续会支持更多机型

| 机型 | 内部代号 | 最低安卓版本 | 最高安卓版本 | 官方维护状态 |
| :----: | :----: | :----: | :----: | :----: |
| 小米 MIX Fold | cetus | Android 11 | Android 11 | √ |
| 小米 MIX4 | odin | Android 11 | Android 12 | √ |
| 小米 MIX3 | perseus | Android 9 | Android 10 | × |
| 小米 MIX2 | chiron | Android 7.1 | Android 9 | × |
| 小米 MIX2S | polaris | Android 9 | Android 10 | × |
| 小米12 Pro | zeus | Android 12 | Android 12 | √ |
| 小米12 | cupid | Android 12 | Android 12 | √ |
| 小米12X | psyche | Android 11 | Android 12 | √ |
| 小米11 | venus | Android 11 | Android 12 | √ |
| 小米11 Ultra | star | Android 11 | Android 12 | √ |
| 小米11 Pro | mars | Android 11 | Android 12 | √ |
| 小米11 青春版 | renoir | Android 11 | Android 12 | √ |
| 小米10 | umi | Android 10 | Android 12 | √ |
| 小米10至尊纪念版 | cas | Android 10 | Android 12 | √ |
| 小米10 Pro | cmi | Android 10 | Android 12 | √ |
| 小米10S | thyme |  Android 11 | Android 12 | √ |
| 小米10青春版 | vangogh | Android 10 | Android 11 | √ |
| 小米9 | cepheus | Android 9 | Android 11 | × |
| 小米9 Pro | crux | Android 9 | Android 11 | × |
| 小米9 SE | grus | Android 9 | Android 11 | × |
| 小米Civi | mona | Android 11 | Android 12 | √ |
| 小米Civi 1S | zijin | Android 12 | Android 12 | √ |
| 小米CC9 | pyxis | Android 9 | Android 11 | × |
| 小米CC9 美图定制版 | vela | Android 9 | Android 11 | × |
| 小米CC9 Pro | tucana | Android 9 | Android 11 | × |
| 小米CC9e | laurus | Android 9 | Android 10 | × |
| 小米8 | dipper | Android 9 | Android 10 | × |
| 小米8屏幕指纹版 | equuleus | Android 9 | Android 10 | × |
| 小米8透明探索版 | ursa | Android 9 | Android 10 | × |
| 小米8青春版 | platina | Android 9 | Android 10 | × |
| 小米8 SE | sirius | Android 8.1 | Android 10 | × |
| 小米6 | sagit | Android 7.1 | Android 9 | × |
| 小米5 | gmini | Android 6 | Android 8 | × |
| 小米平板5 Pro WiFi | elish | Android 11 | Android 11 | √ |
| 小米平板5 Pro | enuma | Android 11 | Android 11 | √ |
| 小米平板5 | nabu | Android 11 | Android 11 | √ |
| 小米平板4 | clover | Android 8.1 | Android 8.1 | × |
| Redmi K60 | mondrian | Android 13 | Android 13 | √ |
| Redmi K50 | rubens | Android 12 | Android 12 | √ |
| Redmi K50 Pro | matisse | Android 12 | Android 12 | √ |
| Redmi K50 电竞版 | ingres | Android 12 | Android 12 | √ |
| Redmi K50 Ultra | diting | Android 12 | Android 12 | √ |
| Redmi K40 | alioth | Android 11 | Android 12 | √ |
| Redmi K40S | munch | Android 12 | Android 12 | √ |
| Redmi K40 Pro/Plus | haydn | Android 11 | Android 12 | √ |
| Redmi K40 游戏增强版 | ares | Android 11 | Android 12 | √ |
| Redmi K30 4G | phoenix | Android 10 | Android 12 | √ |
| Redmi K30 5G | picasso | Android 10 | Android 12 | √ |
| Redmi K30 Pro | lmi | Android 10 | Android 12 | √ |
| Redmi K30 至尊纪念版 | cezanne | Android 10 | Android 12 | √ |
| Redmi K30S 至尊纪念版 | apollo  | Android 10 | Android 12 | √ |
| Redmi K20 | davinci | Android 9 | Android 11 | × |
| Redmi K20 Pro | raphael | Android 9 | Android 11 | × |
| Redmi 10 5G | light | Android 12 | Android 12 | √ |
| Redmi 10X 5G | atom | Android 10 | Android 12 | √ |
| Redmi 10X Pro 5G | bomb | Android 10 | Android 12 | √ |
| Redmi NOTE11 Pro | pissarro | Android 11 | Android 12 | √ |
| Redmi NOTE11 5G | evergo | Android 11 | Android 11 | √ |
| Redmi NOTE11 4G | selene | Android 11 | Android 11 | √ |
| Redmi NOTE10 Pro | chopin | Android 11 | Android 12 | √ |
| Redmi NOTE10 | camellia | Android 11 | Android 12 | √ |
| Redmi NOTE9 | cannon | Android 10 | Android 11 | √ |
| Redmi NOTE9 Pro | gauguin | Android 10 | Android 12 | √ |
| Redmi NOTE8 | ginkgo | Android 9 | Android 11 | × |
| Redmi NOTE8 Pro | begonia | Android 9 | Android 11 | × |
| Redmi NOTE7 | lavender | Android 9 | Android 10 | × |
| Redmi NOTE7 Pro | violet |  Android 9 | Android 10 | × |

#### 特别感谢
- [XDA帖子](https://forum.xda-developers.com/t/module-magiskhide-props-config-safetynet-prop-edits-and-more-v5-4-0.3789228/)
- [SK](https://github.com/sekaiacg)对此模块亦有贡献
