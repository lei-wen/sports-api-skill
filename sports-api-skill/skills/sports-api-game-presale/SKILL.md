---
name: sports-api-game-presale
description: 查询竞彩足球或竞彩篮球的未开售赛程。
---

# 竞彩足球或竞彩篮球的未开售赛程

## 请求参数

必填整数 `lottery_id`：90 为竞彩足球，91 为竞彩篮球。用户仅说“未开售”时先确认运动项目。

## 调用示例

在总技能根目录运行以下命令。共用脚本从环境变量读取鉴权信息，以 POST 发送表单参数。

```bash
scripts/request.sh /api/v1/gamepresale lottery_id=90
```

## 响应处理

业务码 `errcode` 为 0 时读取数据。遍历 `data` 数组，按 `gameTime`、`issueGameName`、`tournamentName` 和主客队名称整理赛程。`gameId` 对应 `match_id2`，为空表示尚未匹配；保留原值。`reverseStatus` 为 0 表示未颠倒，1 表示主客颠倒，空值表示未匹配。

### 响应字段映射

对应《赛事数据接口说明文档》2.1.8「未开售赛程」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 array | 接口业务数据 |
| `data[].awayTeamId` | `integer` | 客队ID |
| `data[].awayTeamName` | `string` | 客队名称 |
| `data[].awayTeamRank` | `string`；示例可为 null | 客队排名 |
| `data[].gameId` | `integer` | jdd比赛ID,若为空，则表示未匹配，值和match_id2相同 |
| `data[].gamePrompt` | `string`；示例可为 null | 比赛提示 |
| `data[].gameTime` | `string` | 比赛时间 |
| `data[].homeTeamId` | `integer` | 主队ID |
| `data[].homeTeamName` | `string` | 主队名称 |
| `data[].homeTeamRank` | `string`；示例可为 null | 主队排名 |
| `data[].hotState` | `integer`；示例可为 null | 热门状态 |
| `data[].id` | `integer`；示例 string | 主键id |
| `data[].issueGameName` | `string` | 期次场次名 |
| `data[].issueId` | `string` | 期次号 |
| `data[].lotteryCode` | `integer` | 彩种编号 |
| `data[].lotteryTime` | `string`；示例可为 null | 开奖时间 |
| `data[].reverseStatus` | `integer` | 是否主客颠倒 0-否 1-是,若为空，则表示未匹配 |
| `data[].sportId` | `integer` | 运动ID |
| `data[].sportName` | `string`；示例可为 null | 运动名称 |
| `data[].tournamentId` | `integer` | 赛事ID |
| `data[].tournamentName` | `string` | 赛事名称 |
