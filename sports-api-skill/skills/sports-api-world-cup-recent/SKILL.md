---
name: sports-api-world-cup-recent
description: 调用赛事数据服务的“世界杯近期赛程”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 世界杯近期赛程

调用红火赛事数据服务的“世界杯近期赛程”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baserecentgames`
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
| `topNum` | integer | 选填 | 未来比赛场数，默认 3 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baserecentgames" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'seasonId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.6.3「近期赛程」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 array | 接口业务数据 |
| `data[].awayTeamId` | `integer` | 客队id |
| `data[].awayTeamLogo` | `string` | 客队logo |
| `data[].awayTeamName` | `string` | 客队名称 |
| `data[].awayTeamScore` | `string` | 客队比分 |
| `data[].gameId` | `integer` | 比赛id |
| `data[].gameState` | `integer` | 比赛状态，详见**状态说明 |
| `data[].gameStateDesc` | `string` | 比赛状态描述 |
| `data[].gameTime` | `string` | 比赛时间 |
| `data[].homeTeamId` | `integer` | 主队id |
| `data[].homeTeamLogo` | `string` | 主队logo |
| `data[].homeTeamName` | `string` | 主队名称 |
| `data[].homeTeamScore` | `string` | 主队比分 |
| `data[].gameStatus` | `string` | N-未开赛 L-进行中 F-已结束 A-中断 |
| `data[].tournamentId` | `string`；示例 integer | 赛事ID |
| `data[].tournamentName` | `string` | 赛事名称 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
