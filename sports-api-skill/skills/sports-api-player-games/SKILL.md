---
name: sports-api-player-games
description: 调用赛事数据服务的“球员赛程”接口。适用于查询指定球员的赛程、比赛记录或继续翻页；不要用于球队赛程或其他赛事提供商。
---

# 球员赛程

调用红火赛事数据服务的“球员赛程”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseplayergame`
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
| `pageSize` | integer | 选填 | 每页数量，默认 `10` |
| `id` | string | 选填 | 数据 ID；第一次请求不传，后续翻页传上次返回结果的 `id` |

## 调用模板

首次请求只发送 `playerId`，用户指定分页大小时再添加 `pageSize`；继续翻页时添加上次响应返回的 `id`：

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseplayergame" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'playerId=<value>' \
  --form 'pageSize=<value>' \
  --form 'id=<value>'
```

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.9.2「球员赛程」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.list` | `array` | 球员比赛记录列表 |
| `data.list[].assists` | `integer` | 助攻数 |
| `data.list[].awayTeamLogo` | `string` | 客队logo |
| `data.list[].awayTeamName` | `string` | 客队名称 |
| `data.list[].cards` | `integer` | 红黄牌数 |
| `data.list[].gameId` | `integer` | 比赛id |
| `data.list[].gameResult` | `integer` | 赛果 3-胜，1-平，0-负 |
| `data.list[].gameTime` | `string` | 比赛时间 |
| `data.list[].goals` | `integer` | 进球数 |
| `data.list[].groupName` | `string`；示例可为 null | 分组名称 |
| `data.list[].homeTeamLogo` | `string` | 主队logo |
| `data.list[].homeTeamName` | `string` | 主队名称 |
| `data.list[].isPlayed` | `integer` | 是否出场 0-未出场，1-已出场 |
| `data.list[].notPlayedReasonName` | `string` | 未出场原因（已出场时为空） |
| `data.list[].phaseName` | `string` | 阶段名称 |
| `data.list[].playMinutes` | `integer` | 上场时间(分钟) |
| `data.list[].rating` | `string` | 评分 |
| `data.list[].redCards` | `integer` | 红牌数 |
| `data.list[].roundName` | `string` | 轮次名称 |
| `data.list[].score` | `string` | 比分 |
| `data.list[].tournamentName` | `string` | 赛事名称 |
| `data.list[].yellowCards` | `integer` | 黄牌数 |
| `data.page` | `integer` | — |
| `data.size` | `integer` | — |
| `data.total` | `integer` | — |

来源：[赛事数据接口说明文档 2.9.2](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
