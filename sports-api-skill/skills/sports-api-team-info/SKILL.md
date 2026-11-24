---
name: sports-api-team-info
description: 调用赛事数据服务的“球队资料”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 球队资料

调用红火赛事数据服务的“球队资料”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseteaminfo`
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
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseteaminfo" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'teamId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.8.3「球队资料」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.buildDate` | `string` | 成立时间 |
| `data.coaches` | `array` | 历任主教练 |
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
| `data.courtRecords` | `array` | 队史-出场榜 |
| `data.courtRecords[].avatar` | `string`；示例可为 null | 球员头像logo |
| `data.courtRecords[].birth` | `string` | 出生日期 |
| `data.courtRecords[].nationality` | `string`；示例可为 null | 球员国籍 |
| `data.courtRecords[].num` | `integer` | 进球数/出场数 |
| `data.courtRecords[].playerId` | `integer` | 球员id |
| `data.courtRecords[].playerName` | `string` | 球员名称 |
| `data.goalRecords` | `array` | 队史-进球榜 |
| `data.goalRecords[].avatar` | `string`；示例可为 null | 球员头像logo |
| `data.goalRecords[].birth` | `string` | 出生日期 |
| `data.goalRecords[].nationality` | `string`；示例可为 null | 球员国籍 |
| `data.goalRecords[].num` | `integer` | 进球数/出场数 |
| `data.goalRecords[].playerId` | `integer` | 球员id |
| `data.goalRecords[].playerName` | `string` | 球员名称 |
| `data.honors` | `array` | 球队荣誉 |
| `data.honors[].honorLogo` | `string` | 荣誉logo |
| `data.honors[].honorName` | `string` | 荣誉名称 |
| `data.honors[].seasonName` | `string` | 赛季名称 |
| `data.honors[].seasonYear` | `string` | 赛季年份 |
| `data.honors[].teamId` | `integer` | 球队id |
| `data.honors[].teamName` | `string` | 球队名称 |
| `data.honors[].tournamentId` | `integer`；示例可为 null | 赛事id |
| `data.honors[].tournamentName` | `string`；示例可为 null | 赛事名称 |
| `data.nickname` | `string`；示例可为 null | 球队绰号 |
| `data.ranks` | `array` | 近年联赛排名 |
| `data.ranks[].maxTeamCount` | `integer` | 赛事下球队最大数量 |
| `data.ranks[].rank` | `integer` | 排名 |
| `data.ranks[].seasonId` | `integer` | 赛季id |
| `data.ranks[].seasonName` | `string` | 赛季名称 |
| `data.ranks[].tournamentId` | `integer` | 赛事id |
| `data.ranks[].tournamentLevel` | `integer` | 赛事等级 |
| `data.ranks[].tournamentName` | `string` | 赛事名称 |
| `data.regionName` | `string` | 所在地区 |
| `data.teamId` | `integer` | 球队id |
| `data.teamLogo` | `string` | 球队logo |
| `data.teamName` | `string` | 球队名称 |
| `data.venueCapacity` | `integer` | 球场容量 |
| `data.venueName` | `string` | 主场 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
