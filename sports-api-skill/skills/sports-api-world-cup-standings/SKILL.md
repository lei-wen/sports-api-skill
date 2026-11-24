---
name: sports-api-world-cup-standings
description: 调用赛事数据服务的“世界杯分组与积分”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 世界杯分组与积分

调用红火赛事数据服务的“世界杯分组与积分”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseteamrank`
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
| `tournamentId` | integer | 必填 | 赛事 ID |
| `seasonId` | integer | 选填 | 赛季 ID，默认当前赛季 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseteamrank" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'tournamentId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.6.5「分组 & 积分」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

`tableList` 属于分组对象，具体积分数据在其球队记录中。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.groupTables` | `array` | 分组情况 |
| `data.groupTables[].phaseId` | `integer` | 阶段ID |
| `data.groupTables[].phaseName` | `string` | 阶段名称 |
| `data.groupTables[].groupName` | `integer`；示例 string | 分组名称 |
| `data.groupTables[].tableList` | `array` | 分组列表 |
| `data.groupTables[].tableList[].teamId` | `integer` | 球队ID |
| `data.groupTables[].tableList[].teamName` | `string` | 球队名称 |
| `data.groupTables[].tableList[].teamLogo` | `string` | 球队图标 |
| `data.groupTables[].tableList[].rank` | `integer` | 排名 |
| `data.groupTables[].tableList[].points` | `integer` | 得分 |
| `data.groupTables[].tableList[].win` | `integer` | 胜场数 |
| `data.groupTables[].tableList[].draw` | `integer` | 平局数 |
| `data.groupTables[].tableList[].loss` | `integer` | 负场数 |
| `data.groupTables[].tableList[].goals` | `integer` | 进球数 |
| `data.groupTables[].tableList[].goalsLost` | `integer` | 失球数 |
| `data.tournamentType` | 示例 integer | 赛事类型 |
| `data.desc` | 示例 string | 赛事及小组赛规则说明 |
| `data.homeGroupTables` | 示例 array | 主场分组积分表 |
| `data.awayGroupTables` | 示例 array | 客场分组积分表 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
