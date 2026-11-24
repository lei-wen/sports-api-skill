---
name: sports-api-team-players
description: 调用赛事数据服务的“球队球员”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 球队球员

调用红火赛事数据服务的“球队球员”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseteamplayer`
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
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseteamplayer" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'teamId=<value>' \
  --form 'seasonId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.8.4「球队球员」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.coaches` | `array` | 教练列表 |
| `data.coaches[].age` | `integer` | 教练年龄 |
| `data.coaches[].avatar` | `string` | 教练头像logo |
| `data.coaches[].coachId` | `integer` | 教练id |
| `data.coaches[].coachName` | `string` | 教练名称 |
| `data.coaches[].draw` | `integer` | 平 |
| `data.coaches[].endTime` | `string` | 在任结束时间 |
| `data.coaches[].lose` | `integer` | 负 |
| `data.coaches[].nationality` | `string` | 教练国籍 |
| `data.coaches[].startTime` | `string` | 在任开始时间 |
| `data.coaches[].tenureDuration` | `string` | 在任时长 |
| `data.coaches[].win` | `integer` | 胜 |
| `data.coaches[].winRate` | `string` | 胜率 |
| `data.players` | `array` | 球员列表（按位置分组：前锋、中场、后卫、门将） |
| `data.players[].players` | `array` | 球员列表 |
| `data.players[].players[].age` | `integer` | 球员年龄 |
| `data.players[].players[].appearances` | `integer`；示例可为 null | 出场次数 |
| `data.players[].players[].assists` | `integer`；示例可为 null | 助攻数 |
| `data.players[].players[].avatar` | `string` | 球员头像logo |
| `data.players[].players[].clearances` | `integer`；示例可为 null | 解围 |
| `data.players[].players[].goals` | `integer`；示例可为 null | 进球数 |
| `data.players[].players[].nationality` | `string` | 球员国籍 |
| `data.players[].players[].playerId` | `integer` | 球员id |
| `data.players[].players[].playerName` | `string` | 球员名称 |
| `data.players[].players[].playerWorth` | `string`；示例可为 null | 身价 |
| `data.players[].players[].position` | `string` | 球员位置 |
| `data.players[].players[].saves` | `integer`；示例可为 null | 扑救 |
| `data.players[].players[].shirtNumber` | `string` | 球员球衣号码 |
| `data.players[].position` | `string` | 出生日期 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
