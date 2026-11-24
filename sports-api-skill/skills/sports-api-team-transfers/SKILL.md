---
name: sports-api-team-transfers
description: 调用赛事数据服务的“球队球员转会”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 球队球员转会

调用红火赛事数据服务的“球队球员转会”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseteamplayertransfer`
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
| `transferYear` | integer | 必填 | 转会年份，例如 2026 |
| `teamId` | integer | 必填 | 球队 ID |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseteamplayertransfer" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'transferYear=<value>' \
  --form 'teamId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.8.2「球队球员转会」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.transferIn` | `array` | 转入列表 |
| `data.transferIn[].inTeamId` | `integer` | 转入球队id |
| `data.transferIn[].inTeamName` | `string` | 转入球队名称 |
| `data.transferIn[].nationality` | `string` | 球员国籍 |
| `data.transferIn[].outTeamId` | `integer` | 转出球队id |
| `data.transferIn[].outTeamName` | `string` | 转出球队名称 |
| `data.transferIn[].playerAge` | `integer` | 球员年龄 |
| `data.transferIn[].playerId` | `integer` | 球员id |
| `data.transferIn[].playerLogo` | `string` | 球员头像logo |
| `data.transferIn[].playerName` | `string` | 球员名称 |
| `data.transferIn[].position` | `string` | 球员位置 |
| `data.transferIn[].transferPrice` | `string`；示例可为 null | 转会费 |
| `data.transferIn[].transferTime` | `string` | 转会时间 |
| `data.transferIn[].transferType` | `integer` | 转会类型 |
| `data.transferOut` | `array` | 赛季列表（倒序） |
| `data.transferOut[].inTeamId` | `integer` | 转入球队id |
| `data.transferOut[].inTeamName` | `string` | 转入球队名称 |
| `data.transferOut[].nationality` | `string` | 球员国籍 |
| `data.transferOut[].outTeamId` | `integer` | 转出球队id |
| `data.transferOut[].outTeamName` | `string` | 转出球队名称 |
| `data.transferOut[].playerAge` | `integer` | 球员年龄 |
| `data.transferOut[].playerId` | `integer` | 球员id |
| `data.transferOut[].playerLogo` | `string` | 球员头像logo |
| `data.transferOut[].playerName` | `string` | 球员名称 |
| `data.transferOut[].position` | `string` | 球员位置 |
| `data.transferOut[].transferPrice` | `string`；示例可为 null | 转会费 |
| `data.transferOut[].transferTime` | `string` | 转会时间 |
| `data.transferOut[].transferType` | `integer` | 转会类型 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
