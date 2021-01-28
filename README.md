# XiaomiCTSPass
### 强制小米设备通过谷歌CTS测试.

#### 描述信息
- 此项目为Magisk模块，可在Magisk Manager App或recovery中刷入。

#### 支持机型
- 小米11（安卓11）
- 小米10至尊纪念版（安卓10）
- 小米10 Pro（安卓10-11）
- 小米10（安卓10-11）
- 小米9（安卓9-10）
- Redmi K20 Pro（安卓9-10）
- 后续会支持更多机型

#### 自定义扩展
- `./XiaoMiCTSPass/props/`下的文件名格式为`机型代号_sdk及版本号.prop`，以安卓11（SDK版本号为30）的小米10机型为例，扩展文件名应为`umi_sdk30.prop`。
- 从小米设备的稳定版固件中提取`ro.build.fingerprint` `ro.build.description` `ro.build.version.security_patch`属性，具体参考`./XiaoMiCTSPass/props/`下的文件内容。

#### 特别感谢
- [XDA帖子](https://forum.xda-developers.com/t/module-magiskhide-props-config-safetynet-prop-edits-and-more-v5-4-0.3789228/)
- [SK对此模块亦有贡献](https://github.com/sekaiacg)
