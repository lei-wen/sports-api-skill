---
name: sports-api-team-home
description: 调用赛事数据服务的“球队主页”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 球队主页

调用红火赛事数据服务的“球队主页”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseteamhomedata`
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

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseteamhomedata" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'teamId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.8.5「球队主页」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.draw` | `integer` | 球队战绩-平 |
| `data.lose` | `integer` | 球队战绩-负 |
| `data.marketValue` | `string` | 球队市值 |
| `data.recentResults` | `array` | 球队近5场比赛的胜平负情况 |
| `data.regionId` | `integer` | 球队所在区域id |
| `data.regionLogo` | `string` | 球队所在国家或地区Logo |
| `data.regionName` | `string` | 球队所在国家或地区 |
| `data.teamCount` | `integer` | 球队数量 |
| `data.teamEnName` | `string` | 球队英文名称 |
| `data.teamId` | `integer` | 球队id |
| `data.teamLogo` | `string` | 球队logo |
| `data.teamName` | `string` | 球队名称 |
| `data.tournamentId` | `integer` | 球队所在赛事id |
| `data.tournamentName` | `string` | 球队所在赛事名称 |
| `data.tournamentRank` | `integer` | 球队所在赛事排名 |
| `data.win` | `integer` | 球队战绩-胜 |
| `data.worldRank` | `integer` | 球队世界排名 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
