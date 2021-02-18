# XiaomiCTSPass
### 强制小米设备通过谷歌CTS测试.

#### 描述信息
- 此项目为Magisk模块，可在Magisk Manager App或第三方Recovery（本质还是依赖Magisk环境）中刷入。

#### 支持机型
- 小米MIX3（安卓9～10）
- 小米MIX2（安卓7.1～9）
- 小米MIX2S（安卓9～10）
- 小米11（安卓11）
- 小米10至尊纪念版（安卓10～11）
- 小米10 Pro（安卓10～11）
- 小米10（安卓10～11）
- 小米10青春版（安卓10～11）
- 小米9（安卓9～10）
- 小米CC9（安卓9～10）
- 小米8（安卓9～10）
- 小米8屏幕指纹版（安卓9～10）
- 小米6（安卓7.1～9）
- 小米5（安卓6～8）
- 小米平板4（安卓8.1）
- Redmi K20（安卓9～10）
- Redmi K20 Pro（安卓9～10）
- Redmi K30 4G（安卓10～11）
- Redmi K30 5G（安卓10～11）
- Redmi K30 Pro（安卓10～11）
- Redmi K30至尊纪念版（安卓10）
- Redmi K30S至尊纪念版（安卓10）
- Redmi NOTE9（安卓10）
- 后续会支持更多机型

#### 自定义扩展
- `./XiaoMiCTSPass/props/`下的文件名格式为`机型代号_sdk及版本号.prop`，以安卓11（SDK版本号为30）的小米10机型为例，扩展文件名应为`umi_sdk30.prop`。
- 从小米设备的稳定版固件中提取`ro.build.fingerprint` `ro.build.description` `ro.build.version.security_patch`属性，具体参考`./XiaoMiCTSPass/props/`下的文件内容。

#### 如何使用
- 下载源码，然后直接make编译出模块（也可在Releases直接下载已经生成的模块）
- 面具安装添加编译出来的模块

#### 特别感谢
- [XDA帖子](https://forum.xda-developers.com/t/module-magiskhide-props-config-safetynet-prop-edits-and-more-v5-4-0.3789228/)
- [SK对此模块亦有贡献](https://github.com/sekaiacg)
