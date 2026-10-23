# hjhopenclash

OpenClash/Subconverter 自定义模板与本地规则。

## 第三方规则快照

`rules/blackmatrix7/` 保存了模板所引用的 `blackmatrix7/ios_rule_script` Clash 规则快照，来源提交：

`f9e403a75bbc4bee939c6d8dd766cf78f1b512f3`

这些文件遵循上游 GPL-2.0 许可证，许可证副本见 `rules/blackmatrix7/LICENSE`。

## IPv6 节点组

两个模板均提供 `🌐 IPv6-手动`。该组按节点名称中的 `IPv6`、`V6` 或 `IP6` 标记筛选节点；如果订阅没有符合名称的节点，组内只保留 `REJECT`，避免误直连。节点名称匹配并不能证明出口具备 IPv6，仍需在 OpenClash 中选中节点后实测 IPv4、IPv6 与 DNS 出口。
