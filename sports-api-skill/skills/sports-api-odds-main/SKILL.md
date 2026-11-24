---
name: sports-api-odds-main
description: 调用赛事数据服务的“胜平负、让球、凯利”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 胜平负、让球、凯利

调用红火赛事数据服务的“胜平负、让球、凯利”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/matchoddslist6`
- 生产环境：`https://apic.17honghuoyun.com`
- 请求体：文档示例使用 `multipart/form-data`，用 curl 的 `--form` 传参。

## 鉴权与本地配置

从环境变量读取凭据，绝不把真实密钥写入 Skill、命令历史、源码或输出：

- `SPORTS_API_APP_ID` -> 请求头 `app-id`
- `SPORTS_API_APP_SECRET` -> 请求头 `app-secret`
- `SPORTS_API_BASE_URL` -> 可选；未设置时使用生产环境

调用前检查两个凭据变量非空；缺失时停止并请用户配置。不要输出或回显完整凭据。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | string | 必填 | 外部/映射比赛 ID |
| `lottery_id` | integer | 必填 | 竞足 90、竞篮 91、足彩 10 |
| `odds_type` | integer | 必填 | 1 欧指及凯利（胜平负）、2 亚指（让球、凯利）、3 欧指及凯利（让球）、4 亚指（大小球） |
| `filter_type` | integer | 必填 | 1 典型指数、2 大公司、3 交易所、4 本土 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/matchoddslist6" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'match_id2=<value>' \
  --form 'lottery_id=<value>' \
  --form 'odds_type=<value>' \
  --form 'filter_type=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.3.1「胜平负、让球、凯利」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 array | 接口业务数据 |
| `data[].playType` | `integer` | 指数类型： / 1 - 欧指、凯利（胜平负） / 2 - 亚指（让球、凯利） / 3 - 欧指、凯利（让球） / 4 - 亚指（大小球） |
| `data[].bookmakerName` | `string` | 机构名称 |
| `data[].bookmakerId` | `integer` | 机构ID |
| `data[].firstBackRate` | `integer`；示例 integer / number | 凯利初始赔付率 |
| `data[].firstHandicap` | `string` | 初始盘口 |
| `data[].firstHandicapName` | `string` | 初始盘口名称 |
| `data[].firstKellyIndex` | `array`；示例 object | 初始凯利指数 |
| `data[].firstOdds1` | `string` | 指数/让球：初始赔率 - 胜/大球 |
| `data[].firstOdds2` | `string` | 指数/让球：初始赔率 - 平 |
| `data[].firstOdds3` | `string` | 指数/让球：初始赔率 - 负/小球 |
| `data[].lastBackRate` | `string` | 凯利最新赔付率 |
| `data[].lastHandicap` | `string` | 最新盘口 |
| `data[].lastHandicapName` | `string` | 最新盘口名称 |
| `data[].lastKellyIndex` | `array`；示例 object | 凯利最新指数 |
| `data[].lastKellyIndex.index1` | `string` | 胜 |
| `data[].lastKellyIndex.index2` | `string` | 平 |
| `data[].lastKellyIndex.index3` | `string` | 负 |
| `data[].lastOdds1` | `string` | 指数/让球：最新赔率 - 胜 |
| `data[].lastOdds2` | `string` | 指数/让球：最新赔率 - 平 |
| `data[].lastOdds3` | `string` | 指数/让球：最新赔率 - 负 |
| `data[].prob1` | `integer`；示例 number | 凯利指数 - 胜概率 |
| `data[].prob2` | `integer`；示例 integer / number | 凯利指数 - 平概率 |
| `data[].prob3` | `integer`；示例 integer / number | 凯利指数 - 负概率 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
