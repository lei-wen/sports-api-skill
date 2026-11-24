---
name: sports-api-team-stats
description: 调用赛事数据服务的“球队统计数据”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 球队统计数据

调用红火赛事数据服务的“球队统计数据”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseanalydata`
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
| `teamId` | integer | 必填 | 球队 ID |
| `seasonId` | integer | 必填 | 赛季 ID |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseanalydata" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'teamId=<value>' \
  --form 'seasonId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.8.6「球队统计数据」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.keyPlayers` | `array` | 关键球员 |
| `data.keyPlayers[].avatar` | `string` | 球员头像 |
| `data.keyPlayers[].dimension` | `string` | 维度 |
| `data.keyPlayers[].playerId` | `integer` | 球员id |
| `data.keyPlayers[].playerName` | `string` | 球员名称 |
| `data.keyPlayers[].value` | `integer` | 数值 |
| `data.leagueData` | `object` | LeagueData |
| `data.leagueData.dataAnalysis` | `object` | DataAnalysis |
| `data.leagueData.dataAnalysis.bigChancesCreated` | `integer` | 绝佳机会 |
| `data.leagueData.dataAnalysis.bigChancesMissed` | `integer` | 错失绝佳机会 |
| `data.leagueData.dataAnalysis.clearancesAvg` | `string` | 场均解围 |
| `data.leagueData.dataAnalysis.cornerAvg` | `string` | 场均角球 |
| `data.leagueData.dataAnalysis.crossesAccuracyRate` | `string` | 传中成功率 |
| `data.leagueData.dataAnalysis.crossesAvg` | `string` | 场均传中 |
| `data.leagueData.dataAnalysis.errorsLeadingToGoal` | `integer`；示例可为 null | 失误导致丢球 |
| `data.leagueData.dataAnalysis.errorsLeadingToShot` | `integer`；示例可为 null | 失误导致射门 |
| `data.leagueData.dataAnalysis.fouls` | `integer` | 犯规 |
| `data.leagueData.dataAnalysis.goals` | `integer` | 进球 |
| `data.leagueData.dataAnalysis.goalsLost` | `integer` | 失球 |
| `data.leagueData.dataAnalysis.hitWoodwork` | `integer`；示例可为 null | 击中门框 |
| `data.leagueData.dataAnalysis.interceptionsAvg` | `string` | 场均拦截 |
| `data.leagueData.dataAnalysis.keepInAvg` | `string` | 场均扑救 |
| `data.leagueData.dataAnalysis.keyPasses` | `integer` | 关键传球 |
| `data.leagueData.dataAnalysis.longBallsAccuracyRate` | `string` | 长传成功率 |
| `data.leagueData.dataAnalysis.longBallsAvg` | `string` | 场均长传 |
| `data.leagueData.dataAnalysis.passAccuracyRate` | `string` | 传球成功率 |
| `data.leagueData.dataAnalysis.passAvg` | `string` | 场均传球 |
| `data.leagueData.dataAnalysis.penalty` | `integer`；示例可为 null | 点球进球 |
| `data.leagueData.dataAnalysis.possessionPercentage` | `string`；示例可为 null | 控球率 |
| `data.leagueData.dataAnalysis.red` | `integer` | 红牌 |
| `data.leagueData.dataAnalysis.shotAvg` | `string` | 场均射门 |
| `data.leagueData.dataAnalysis.shotOnAvg` | `string` | 场均射正 |
| `data.leagueData.dataAnalysis.stealsAvg` | `string`；示例可为 null | 场均抢断 |
| `data.leagueData.dataAnalysis.yellow` | `integer` | 黄牌 |
| `data.leagueData.rankTrend` | `array` | 排名走势 |
| `data.leagueData.rankTrend[].games` | `array` | 本轮比赛 |
| `data.leagueData.rankTrend[].rank` | `integer` | 排名 |
| `data.leagueData.rankTrend[].roundName` | `string` | 轮次名称 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
