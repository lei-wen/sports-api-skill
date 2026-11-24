---
name: sports-api-womens-basketball-games
description: 调用赛事数据服务的“女篮世界杯赛程”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 女篮世界杯赛程

调用红火赛事数据服务的“女篮世界杯赛程”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/gamelistbball`
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
| `seasonId` | integer | 必填 | 赛季 ID |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/gamelistbball" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'seasonId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.7.6「赛程」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 array | 接口业务数据 |
| `data[].awayTeamId` | `integer` | 客场球队 |
| `data[].awayTeamName` | `string` | 客场球队名称 |
| `data[].awayTeamRank` | `string`；示例可为 null | 客队排名 |
| `data[].awayTeamScores` | `string` | 客队比分 |
| `data[].coverage` | `string` | 是否有动画、情报、阵容 |
| `data[].createTime` | `string` | 创建时间 |
| `data[].enableState` | `integer` | 启用状态 |
| `data[].gameState` | `integer` | 比赛状态 |
| `data[].gameTime` | `string` | 比赛时间 |
| `data[].groupId` | `integer` | 赛季分组 |
| `data[].groupName` | `string`；示例可为 null | 赛季分组名称 |
| `data[].homeTeamId` | `integer` | 主场球队 |
| `data[].homeTeamName` | `string` | 主场球队名称 |
| `data[].homeTeamRank` | `string`；示例可为 null | 主队排名 |
| `data[].homeTeamScores` | `string` | 主队比分 |
| `data[].humidity` | `string`；示例可为 null | 湿度 |
| `data[].id` | `integer` | 唯一编号 |
| `data[].mainRefereeId` | `integer`；示例可为 null | 主裁判 |
| `data[].mainRefereeName` | `string`；示例可为 null | 主裁判名称 |
| `data[].neaturalState` | `integer` | 中立场状态 |
| `data[].operateState` | `integer` | 维护状态 |
| `data[].operateTime` | `string`；示例可为 null | 操作时间 |
| `data[].phaseId` | `integer` | 赛季阶段 |
| `data[].phaseName` | `string` | 赛季阶段名称 |
| `data[].pressure` | `string`；示例可为 null | 气压 |
| `data[].roundId` | `integer` | 赛季轮次 |
| `data[].roundName` | `string`；示例可为 null | 赛季轮次名称 |
| `data[].seasonId` | `integer` | 赛季 |
| `data[].seasonName` | `string` | 赛季名称 |
| `data[].signature` | `string`；示例可为 null | 签名编号 |
| `data[].source` | `integer` | 数据来源 |
| `data[].sportId` | `integer` | 运动类型 |
| `data[].sportName` | `string` | 运动类型名称 |
| `data[].temperature` | `string`；示例可为 null | 气温 |
| `data[].tournamentId` | `integer` | 赛事 |
| `data[].tournamentName` | `string` | 赛事名称 |
| `data[].updateTime` | `string` | 更新时间 |
| `data[].venueId` | `integer`；示例可为 null | 场馆 |
| `data[].venueName` | `string`；示例可为 null | 场馆名称 |
| `data[].viewerNum` | `integer`；示例可为 null | 观众数 |
| `data[].weather` | `integer`；示例可为 null | 气象 |
| `data[].wind` | `string`；示例可为 null | 风速 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
