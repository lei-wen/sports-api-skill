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
