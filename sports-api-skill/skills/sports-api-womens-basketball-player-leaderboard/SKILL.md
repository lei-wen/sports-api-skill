---
name: sports-api-womens-basketball-player-leaderboard
description: 调用赛事数据服务的“女篮世界杯球员榜”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 女篮世界杯球员榜

调用红火赛事数据服务的“女篮世界杯球员榜”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/BusinessPlayerBball`
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
| `type` | integer | 选填 | 类型 ID；多个值用逗号分隔，留空返回全部 |
| `seasonId` | integer | 选填 | 赛季 ID |
| `tournamentId` | integer | 必填 | 赛事 ID |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/BusinessPlayerBball" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'tournamentId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.7.8「球员榜」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 array | 接口业务数据 |
| `data[].type` | `integer` | 类型 |
| `data[].name` | `string` | 类型名称 |
| `data[].playerStatList` | `array` | 球员统计 |
| `data[].playerStatList[].average` | `number` | 场均 |
| `data[].playerStatList[].playerId` | `integer` | 球员ID |
| `data[].playerStatList[].playerName` | `string` | 球员名 |
| `data[].playerStatList[].rank` | `integer` | 排名 |
| `data[].playerStatList[].teamId` | `integer` | 球队id |
| `data[].playerStatList[].teamName` | `string`；示例可为 null | 球队名 |
| `data[].playerStatList[].total` | `integer`；示例可为 null | 总计 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
