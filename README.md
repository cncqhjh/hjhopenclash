# hjhopenclash

OpenClash/Subconverter 自定义模板与本地规则。

## 第三方规则快照

`rules/blackmatrix7/` 保存了模板所引用的 `blackmatrix7/ios_rule_script` Clash 规则快照，来源提交：

`f9e403a75bbc4bee939c6d8dd766cf78f1b512f3`

这些文件遵循上游 GPL-2.0 许可证，许可证副本见 `rules/blackmatrix7/LICENSE`。

## IPv6 节点组

两个模板均提供以下两个 IPv6 节点组：

- `🌐 IPv6-自动检测`：使用 IPv6-only 地址 `https://ipv6.google.com/generate_204` 每 300 秒检测节点，排除“剩余/到期/重置/流量/套餐/官网/时间”等机场信息项，并自动选择检测成功的低延迟节点。
- `🌐 IPv6-手动`：按节点名称中的 `IPv6`、`V6` 或 `IP6` 标记筛选，未匹配时只保留 `REJECT`，避免误直连。

IPv6-only 检测成功表示节点能够访问 IPv6 目标，但不保证所有双栈网站都会采用 IPv6。使用前仍应分别实测 IPv4、IPv6 与 DNS 出口。

`AI1` 和 `AI2` 默认使用 `美国-自动`，且不提供 `DIRECT`，避免 AI 服务在新配置中意外直连。
