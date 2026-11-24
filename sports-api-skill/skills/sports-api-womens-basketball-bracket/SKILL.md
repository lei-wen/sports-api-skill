---
name: sports-api-womens-basketball-bracket
description: 调用赛事数据服务的“女篮世界杯晋级图”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 女篮世界杯晋级图

调用红火赛事数据服务的“女篮世界杯晋级图”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseprochartbball`
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
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseprochartbball" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'seasonId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.7.4「晋级图」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 array | 接口业务数据 |
| `data[].awayScore` | `integer` | 客队比分 |
| `data[].awayTeamId` | `integer` | 客队id |
| `data[].awayTeamLogo` | `string` | 客队logo |
| `data[].awayTeamName` | `string` | 客队名称 |
| `data[].bracketId` | `integer` | 对阵图id |
| `data[].bracketName` | `string` | 对阵图名称 |
| `data[].childrenIds` | `string`；示例可为 null | 连线上一对阵id |
| `data[].endTime` | `string`；示例可为 null | 对阵图结束时间 |
| `data[].gameIds` | `string` | 对阵关联的比赛id |
| `data[].groupId` | `integer` | 对阵图分组id |
| `data[].homeScore` | `integer` | 主队比分 |
| `data[].homeTeamId` | `integer` | 主队id |
| `data[].homeTeamLogo` | `string` | 主队logo |
| `data[].homeTeamName` | `string` | 主队名称 |
| `data[].parentIds` | `string` | 连线下一对阵id |
| `data[].roundId` | `integer` | 对阵阶段id |
| `data[].roundName` | `string` | 对阵阶段名称 |
| `data[].seasonId` | `integer` | 赛季id |
| `data[].startTime` | `string`；示例可为 null | 对阵图开始时间 |
| `data[].stateId` | `integer` | 状态说明 0-占位，1-未开始，2-进行中，3-完成 |
| `data[].typeId` | `integer` | 赛制说明 1-单败淘汰赛，2-双败淘汰赛 |
| `data[].upId` | `integer` | 对阵id |
| `data[].upSort` | `integer` | 排序 |
| `data[].winnerTeamId` | `integer` | 胜利队id |
| `data[].gameList` | `array` | 比赛信息 |
| `data[].gameList[].awayTeamScores` | `string` | 客队比分 |
| `data[].gameList[].gameId` | `integer` | 比赛id |
| `data[].gameList[].gameState` | `integer` | 比赛状态 |
| `data[].gameList[].gameTime` | `string` | 比赛时间 |
| `data[].gameList[].homeTeamScores` | `string` | 主队比分 |
| `data[].gameList[].reverse` | `integer` | 是否颠倒比分 0-否，1-是 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
