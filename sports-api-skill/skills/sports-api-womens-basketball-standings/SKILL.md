---
name: sports-api-womens-basketball-standings
description: 调用赛事数据服务的“女篮世界杯分组与积分”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 女篮世界杯分组与积分

调用红火赛事数据服务的“女篮世界杯分组与积分”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseteamrankbball`
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
| `seasonId` | integer | 必填 | 赛季 ID，文档称默认当前赛季，但同时标为必填 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseteamrankbball" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'seasonId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.7.5「分组 & 积分」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 array | 接口业务数据 |
| `data[].awayLosses` | `integer`；示例可为 null | 客场负场 |
| `data[].awayWins` | `integer`；示例可为 null | 客场胜场 |
| `data[].conference` | `string` | 分部名称 |
| `data[].conferenceLosses` | `integer`；示例可为 null | 分部负场 |
| `data[].conferenceWins` | `integer`；示例可为 null | 分部胜场 |
| `data[].createTime` | `string` | 创建时间 |
| `data[].division` | `string` | 赛区 |
| `data[].divisionLosses` | `integer`；示例可为 null | 赛区负场 |
| `data[].divisionWins` | `integer`；示例可为 null | 赛区胜场 |
| `data[].enableState` | `integer` | 启用状态 |
| `data[].groupId` | `integer` | 分组id |
| `data[].groupName` | `string`；示例可为 null | 分组名称 |
| `data[].homeLosses` | `integer`；示例可为 null | 主场负场 |
| `data[].homeWins` | `integer`；示例可为 null | 主场胜场 |
| `data[].id` | `string`；示例可为 null | 记录唯一编号 |
| `data[].loss` | `integer` | 负场次数 |
| `data[].lossStreak` | `integer` | 连负 |
| `data[].operateState` | `integer` | 维护状态 |
| `data[].operateTime` | `string`；示例可为 null | 操作时间 |
| `data[].phaseId` | `integer` | 阶段id |
| `data[].phaseName` | `string`；示例可为 null | 阶段名称 |
| `data[].pointsAvg` | `number` | 场均得分 |
| `data[].pointsDiff` | `number` | 净胜 |
| `data[].pointsLostAvg` | `number` | 场均失分 |
| `data[].rankCode` | `integer` | 排名 |
| `data[].rankType` | `integer` | 排名类型，字典类型 |
| `data[].seasonId` | `integer` | 赛季ID |
| `data[].seasonName` | `string`；示例可为 null | 赛季名称 |
| `data[].signature` | `string`；示例可为 null | 签名编号 |
| `data[].source` | `integer`；示例可为 null | 数据来源 |
| `data[].teamId` | `integer` | 球队ID |
| `data[].teamName` | `string` | 球队名称 |
| `data[].tournamentId` | `integer` | 赛事ID |
| `data[].tournamentName` | `string` | 赛事名称 |
| `data[].updateTime` | `string` | 更新时间 |
| `data[].win` | `integer` | 胜场次数 |
| `data[].winDiff` | `string` | 胜差 |
| `data[].winPct` | `number` | 胜率 |
| `data[].winStreak` | `integer` | 连胜 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
