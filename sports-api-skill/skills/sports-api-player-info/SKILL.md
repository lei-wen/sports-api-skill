---
name: sports-api-player-info
description: 调用赛事数据服务的“球员资料”接口。适用于查询指定球员的基本资料；不要用于球队资料或其他赛事提供商。
---

# 球员资料

调用红火赛事数据服务的“球员资料”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseplayerinfo`
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

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseplayerinfo" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'playerId=<value>'
```

## 响应处理

成功响应的 `data` 包含 `basicInfo` 等球员资料，源文档列出 `birthday` 等字段。响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`，只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.9.4「球员资料」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.basicInfo` | `object` | 球员基本资料 |
| `data.basicInfo.birthday` | `string` | 生日 |
| `data.basicInfo.contractUntil` | `string` | 合同到期时间 |
| `data.basicInfo.nameChs` | `string` | 中文名称 |
| `data.basicInfo.nameEng` | `string` | 英文全称 |
| `data.basicInfo.nationality` | `string` | 国籍 |
| `data.basicInfo.playerId` | `integer` | 球员id |
| `data.basicInfo.value` | `string` | 身价 |
| `data.basicInfo.weeklySalary` | `string`；示例可为 null | 周薪 |
| `data.clubCareer` | `array[object (Career)]`；示例可为 null | 俱乐部生涯 |
| `data.clubCareer[].appearances` | `integer` | 出场 |
| `data.clubCareer[].assists` | `integer` | 助攻 |
| `data.clubCareer[].beginDate` | `string` | 开始日期 |
| `data.clubCareer[].endDate` | `string` | 结束日期 |
| `data.clubCareer[].goals` | `integer` | 进球 |
| `data.clubCareer[].teamId` | `integer` | 球队id |
| `data.clubCareer[].teamLogo` | `string` | 球队logo |
| `data.clubCareer[].teamName` | `string` | 球队名称 |
| `data.honor` | `array[object (Honor)]` | 荣誉记录 |
| `data.honor[].honorLogo` | `string` | 荣誉logo |
| `data.honor[].honorName` | `string` | 荣誉名称 |
| `data.honor[].seasonName` | `string` | 赛季名称 |
| `data.honor[].seasonYear` | `string` | 赛季年份 |
| `data.honor[].teamId` | `integer`；示例可为 null | 球队id |
| `data.honor[].teamName` | `string`；示例可为 null | 球队名称 |
| `data.honor[].tournamentId` | `integer` | 赛事id |
| `data.honor[].tournamentLevel` | `integer` | 赛事等级 |
| `data.honor[].tournamentName` | `string` | 赛事名称 |
| `data.missing` | `array[object (Missing)]` | 伤病记录 |
| `data.missing[].beginTime` | `string` | 伤病开始时间 |
| `data.missing[].duration` | `integer` | 伤病时长(天) |
| `data.missing[].endTime` | `string` | 伤病结束时间 |
| `data.missing[].missedGames` | `integer` | 错过比赛场次 |
| `data.missing[].missingReason` | `string` | 伤病原因 |
| `data.missing[].teamId` | `integer` | 所在球队id |
| `data.missing[].teamName` | `string` | 球队名称 |
| `data.nationalCareer` | `array[object (Career)]`；示例可为 null | 国家队生涯 |
| `data.nationalCareer[].appearances` | `integer` | 出场 |
| `data.nationalCareer[].assists` | `integer` | 助攻 |
| `data.nationalCareer[].beginDate` | `string` | 开始日期 |
| `data.nationalCareer[].endDate` | `string` | 结束日期 |
| `data.nationalCareer[].goals` | `integer` | 进球 |
| `data.nationalCareer[].teamId` | `integer` | 球队id |
| `data.nationalCareer[].teamLogo` | `string` | 球队logo |
| `data.nationalCareer[].teamName` | `string` | 球队名称 |
| `data.transfer` | `array[object (Transfer)]` | 转会记录 |
| `data.transfer[].date` | `string` | 日期 |
| `data.transfer[].inTeamId` | `integer` | 转入球队id |
| `data.transfer[].inTeamLogo` | `string` | 转入球队logo |
| `data.transfer[].inTeamName` | `string` | 转入球队名称 |
| `data.transfer[].outTeamId` | `integer`；示例可为 null | 转出球队id |
| `data.transfer[].outTeamLogo` | `string`；示例可为 null | 转出球队logo |
| `data.transfer[].outTeamName` | `string`；示例可为 null | 转出球队名称 |
| `data.transfer[].transferPrice` | `string`；示例可为 null | 转会金额 |
| `data.transfer[].transferType` | `integer` | 转会类型 1-租借，2-租借结束，3-转会，4-职业生涯结束，5-选秀，6-解约，7-签约 |
| `data.transfer[].transferTypeDesc` | `string` | 转会类型描述 |
| `data.valueTrend` | `array[object (ValueTrend)]` | 身价走势 |
| `data.valueTrend[].age` | `integer` | 年龄 |
| `data.valueTrend[].date` | `string` | 日期 |
| `data.valueTrend[].playerId` | `integer` | 球员id |
| `data.valueTrend[].playerName` | `string` | 球员名称 |
| `data.valueTrend[].teamId` | `integer` | 球队id |
| `data.valueTrend[].teamLogo` | `string` | 球队logo |
| `data.valueTrend[].teamName` | `string` | 球队名称 |
| `data.valueTrend[].worth` | `string` | 身价 |

来源：[赛事数据接口说明文档 2.9.4](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
