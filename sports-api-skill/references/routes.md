# 子 Skill 路由表

根据用户的主要对象和动作选择一个子 Skill。确定路由后，读取该子 Skill 的 `SKILL.md` 获取所需参数，不在本文件重复维护参数定义。

## 2.1 赛事数据

| 用户意图 | 子 Skill |
|---|---|
| 当前开售竞猜赛程、竞彩赛程、竞彩足球/竞彩篮球/传统足彩赛程 | `sports-api-match-list` |
| 某场或某玩法的可选投注项、玩法选项 | `sports-api-match-options` |
| 按比赛日期或传统足彩期次查询赛果、开奖 | `sports-api-match-prize-list` |
| 按一个或多个比赛 ID 查询赛果 | `sports-api-match-prize-by-id` |

## 2.2 比赛详情

| 用户意图 | 子 Skill |
|---|---|
| 历史交锋、近期战绩 | `sports-api-match-history` |
| 阵容、首发、替补 | `sports-api-match-lineup` |
| 比赛相关排名、积分排名 | `sports-api-match-ranking` |
| 比赛直播数据、实时事件 | `sports-api-match-live` |
| 比赛名称别名、翻译或批量校验 | `sports-api-match-alias-translation` |

## 2.3 指数

| 用户意图 | 子 Skill |
|---|---|
| 胜平负、让球、凯利、欧赔、亚盘或大小球指数列表 | `sports-api-odds-main` |
| 总进球数、比分或半全场指数列表 | `sports-api-odds-score` |
| 某公司的胜平负、让球、凯利、欧赔、亚盘或大小球指数详情 | `sports-api-odds-main-detail` |
| 某公司的总进球数、比分或半全场指数详情 | `sports-api-odds-score-detail` |

## 2.4 情报内参

| 用户意图 | 子 Skill |
|---|---|
| 密报 | `sports-api-secret-report` |
| 内参、比赛分析 | `sports-api-insider-analysis` |
| 选号分布、投注热度 | `sports-api-pick-distribution` |
| 交易数据、平台交易比例对比 | `sports-api-trade-ratio` |

## 2.5 分析预测

| 用户意图 | 子 Skill |
|---|---|
| 专家推荐列表 | `sports-api-expert-recommendations` |
| 专家推荐内容详情 | `sports-api-recommendation-detail` |
| 牛单推荐列表 | `sports-api-bull-pick-list` |
| 牛单详情 | `sports-api-bull-pick-detail` |

## 2.6 世界杯赛事资料

| 用户意图 | 子 Skill |
|---|---|
| 世界杯赛季列表 | `sports-api-world-cup-seasons` |
| 世界杯赛事介绍 | `sports-api-world-cup-intro` |
| 世界杯近期赛程 | `sports-api-world-cup-recent` |
| 世界杯淘汰赛晋级图 | `sports-api-world-cup-bracket` |
| 世界杯分组与积分 | `sports-api-world-cup-standings` |
| 世界杯完整赛程 | `sports-api-world-cup-games` |
| 世界杯球队榜 | `sports-api-world-cup-team-leaderboard` |
| 世界杯球员榜 | `sports-api-world-cup-player-leaderboard` |

## 2.7 女篮世界杯赛事资料

| 用户意图 | 子 Skill |
|---|---|
| 女篮世界杯赛季列表 | `sports-api-womens-basketball-seasons` |
| 女篮世界杯赛事介绍、赛事资料 | `sports-api-womens-basketball-intro` |
| 女篮世界杯近期赛程 | `sports-api-womens-basketball-recent` |
| 女篮世界杯晋级图 | `sports-api-womens-basketball-bracket` |
| 女篮世界杯分组与积分 | `sports-api-womens-basketball-standings` |
| 女篮世界杯完整赛程 | `sports-api-womens-basketball-games` |
| 女篮世界杯球队榜 | `sports-api-womens-basketball-team-leaderboard` |
| 女篮世界杯球员榜 | `sports-api-womens-basketball-player-leaderboard` |

## 2.8 球队资料库

| 用户意图 | 子 Skill |
|---|---|
| 指定球队的赛程 | `sports-api-team-games` |
| 指定年份的球队球员转会 | `sports-api-team-transfers` |
| 球队基本资料 | `sports-api-team-info` |
| 球队球员名单 | `sports-api-team-players` |
| 球队主页聚合数据 | `sports-api-team-home` |
| 球队统计分析数据 | `sports-api-team-stats` |
| 球队可查询的转会年份列表 | `sports-api-team-transfer-years` |

## 决策边界

- “竞彩赛程”优先路由到 `sports-api-match-list`。
- 用户明确提到世界杯或女篮世界杯时，优先使用对应专题 Skill，而不是通用竞猜赛程。
- 用户明确提供 `teamId` 并询问赛程时，优先使用 `sports-api-team-games`。
- 用户要赔率列表时用 `*-odds-*` 列表 Skill；同时指定公司或 `book_maker_id` 时使用详情 Skill。
- 用户要按 ID 查赛果时使用 `sports-api-match-prize-by-id`；按日期、彩种或期次查赛果时使用 `sports-api-match-prize-list`。
- 仍有两个同等合理的候选项时，不调用接口，先给出编号选项让用户确认。
