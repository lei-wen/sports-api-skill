---
name: sports-api-player-stats
description: 调用赛事数据服务的“球员统计数据”接口。适用于查询指定球员的统计或分析数据；不要用于球员能力或其他赛事提供商。
---

# 球员统计数据

调用红火赛事数据服务的“球员统计数据”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseplayeranaly`
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
| `playerId` | integer | 必填 | 球员 ID |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseplayeranaly" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'playerId=<value>'
```

## 响应处理

成功响应的 `data` 包含杯赛等统计数据；源文档列出 `cup` 数组及 `aerialAvg` 场均争顶等字段。响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`，只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.9.5「球员统计数据」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

联赛、杯赛和国家队记录共用 Detail 字段。示例只展示联赛记录，源表重名或拼写存疑处已标注。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.cup` | `array[object (Detail)]` | 杯赛 |
| `data.cup[].aerialAvg` | `string` | 场均争顶 |
| `data.cup[].aerialWonRate` | `string` | 争顶成功率 |
| `data.cup[].assist` | `integer` | 助攻 |
| `data.cup[].bigChancesCreated` | `integer` | 创造进球机会 |
| `data.cup[].bigChancesMissed` | `integer` | 错失绝佳机会 |
| `data.cup[].blockedShots` | `integer` | 封堵射门 |
| `data.cup[].carriesDistanceAvg` | `string` | 场均带球距离 |
| `data.cup[].clearancesAvg` | `string` | 场均解围 |
| `data.cup[].court` | `integer` | 出场 |
| `data.cup[].crossesAccuracyRate` | `string` | 传中成功率 |
| `data.cup[].crossesAvg` | `string` | 场均传中 |
| `data.cup[].distanceAvg` | `string` | 场均跑动 |
| `data.cup[].dribbleSuccessAvg` | `string` | 场均成功过人 |
| `data.cup[].dribbleSuccessRate` | `string` | 过人成功率 |
| `data.cup[].dribbledPastAvg` | `string` | 场均被过 |
| `data.cup[].errorLeadToGoal` | `integer` | 失误导致丢球 |
| `data.cup[].expectedAssist` | `string` | 预期助攻 |
| `data.cup[].expectedGoals` | `string` | 预期进球 |
| `data.cup[].fouls` | `integer` | 犯规 |
| `data.cup[].goals` | `integer` | 进球 |
| `data.cup[].goalsAvg` | `string` | 场均进球 |
| `data.cup[].interceptionsAvg` | `string` | 场均拦截 |
| `data.cup[].keyPasses` | `integer` | 关键传球 |
| `data.cup[].longBallsAccuracyRate` | `string` | 长传成功率 |
| `data.cup[].longBallsAvg` | `string` | 场均长传 |
| `data.cup[].maxSpeed` | `string` | 最高速度 |
| `data.cup[].offside` | `integer` | 越位 |
| `data.cup[].passAvg` | `string` | 场均传球 |
| `data.cup[].passesAccuracyRate` | `string` | 传球成功率 |
| `data.cup[].playedMinutes` | `integer` | 出场时间 |
| `data.cup[].playedMinutesAvg` | `string` | 场均时间 |
| `data.cup[].possLostsAvg` | `string` | 场均丢失球权 |
| `data.cup[].progressiveCarriesAvg` | `string` | 场均带球推进 |
| `data.cup[].progressiveDistanceAvg` | `string` | 场均推进距离 |
| `data.cup[].red` | `integer` | 红牌 |
| `data.cup[].seasonId` | `integer` | 赛季id |
| `data.cup[].seasonName` | `string` | 赛季名称 |
| `data.cup[].shotOnRate` | `string` | 射正率 |
| `data.cup[].shots` | `integer` | 射门 |
| `data.cup[].sprintsAvg` | `string` | 场均冲刺（源表也用此键标注场均抢断，抢断字段待确认） |
| `data.cup[].starter` | `integer` | 首发 |
| `data.cup[].teamId` | `integer` | 球队id |
| `data.cup[].teamLogo` | `string` | 球队logo |
| `data.cup[].teamName` | `string` | 球队名称 |
| `data.cup[].timePerGoal` | `string` | 每球耗时 |
| `data.cup[].touchesAvg` | `string` | 场均触球 |
| `data.cup[].tournamentId` | `integer` | 赛事id |
| `data.cup[].tournamentName` | `string` | 赛事名称 |
| `data.cup[].wasFouled` | `integer` | 被犯规 |
| `data.cup[].wasFouledwonPenaltyGoals` | `integer` | 造点球（源表字段；联赛示例使用 `wonPenaltyGoals`） |
| `data.cup[].yellow` | `integer` | 黄牌 |
| `data.league` | `array[object (Detail)]` | 联赛 |
| `data.league[]` | — | 与 `data.cup[]` 使用相同的 Detail 字段 |
| `data.national` | `array[object (Detail)]` | 国家队 |
| `data.national[]` | — | 与 `data.cup[]` 使用相同的 Detail 字段 |
| `data.total` | `array[object (Total)]`；示例可为 null | 总计 |
| `data.total[].assist` | `integer` | 助攻 |
| `data.total[].court` | `integer` | 出场 |
| `data.total[].goals` | `integer` | 进球 |
| `data.total[].red` | `integer` | 红牌 |
| `data.total[].seasonId` | `integer` | 赛季id |
| `data.total[].seasonName` | `string` | 赛季名称 |
| `data.total[].starter` | `integer` | 首发 |
| `data.total[].teamId` | `integer` | 球队id |
| `data.total[].teamLogo` | `string` | 球队logo |
| `data.total[].teamName` | `string` | 球队名称 |
| `data.total[].yellow` | `integer` | 黄牌 |
| `data.league[].wonPenaltyGoals` | 示例 integer | 造点球 |

来源：[赛事数据接口说明文档 2.9.5](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
