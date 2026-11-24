---
name: sports-api-match-lineup
description: 调用赛事数据服务的“阵容”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 阵容

调用红火赛事数据服务的“阵容”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/analyzeLineupDataV1`
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
| `match_id2` | integer | 必填 | 比赛 ID |
| `lottery_id` | integer | 必填 | 竞足类型为 90 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/analyzeLineupDataV1" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'match_id2=<value>' \
  --form 'lottery_id=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.2.2「阵容」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.aId` | `integer` | 客队ID |
| `data.aName` | `string` | 客队名 |
| `data.awayAvgAge` | `integer` | 客队平均年龄 |
| `data.awayAvgHeight` | `integer` | 客队平均身高 |
| `data.awayCard` | `array` | 客队球员红黄牌情况 |
| `data.awayCoach` | `string` | 客队教练 |
| `data.awayFormation` | `string` | 客队阵容 |
| `data.awayInjury` | `array` | 客队预计伤停球员名单 |
| `data.awayInjuryPrice` | `string` | 客队伤停球员身价 |
| `data.awayPrice` | `string` | 客队总身价 |
| `data.awayStarter` | `array` | 客队首发人员名单 |
| `data.awayStarterAvgAge` | `integer` | 客队首发平均年龄 |
| `data.awayStarterAvgHeight` | `integer` | 客队首发平均身高 |
| `data.awayStarterPrice` | `string` | 客队首发球员身价 |
| `data.awaySubstitute` | `array` | 客队替补球员名单 |
| `data.awaySubstitutePrice` | `string` | 客队替补球员身价 |
| `data.hId` | `integer` | 客队ID |
| `data.hName` | `string` | 客队名 |
| `data.homeAvgAge` | `integer` | 客队平均年龄 |
| `data.homeAvgHeight` | `integer` | 客队平均身高 |
| `data.homeCard` | `array` | 客队球员红黄牌情况 |
| `data.homeCoach` | `string` | 主队教练 |
| `data.homeFormation` | `string` | 主队阵容 |
| `data.homeInjury` | `array` | 主队预计伤停球员名单 |
| `data.homeInjuryPrice` | `string` | 主队伤停球员身价 |
| `data.homePrice` | `string` | 主队总身价 |
| `data.homeStarter` | `array` | 主队首发人员名单 |
| `data.homeStarterAvgAge` | `integer` | 主队首发平均年龄 |
| `data.homeStarterAvgHeight` | `integer` | 主队首发平均身高 |
| `data.homeStarterPrice` | `string` | 主队首发球员身价 |
| `data.homeSubstitute` | `array` | 主队替补球员名单 |
| `data.homeSubstitutePrice` | `string` | 主队替补球员身价 |
| `data.createTime` | `string` | isCurrentMatch=1，主客队阵容最后更新时间 / isCurrentMatch=0，主客队阵容上一场的最后更新时间 |
| `data.isCurrentMatch` | `string` | 是否本场阵容 1：是 0：上一场 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
