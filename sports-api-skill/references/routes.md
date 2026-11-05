# 接口指南路由表

根据用户的主要对象和动作选择一个接口指南。确定路由后，读取 `skills/<guide-name>/SKILL.md` 获取所需参数，不在本文件重复维护参数定义。嵌套指南是总 Skill 的附带资源，不要求宿主将它们注册为独立 Skill。

维护时以[赛事数据接口说明文档](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)为准。每次同步后核对每个有请求定义的接口恰好对应一个指南和一条路由，移除文档已删除的指南和路由。待定章节在接口定义发布后再加入。

## 2.1 赛事数据

| 用户意图 | 接口指南 |
|---|---|
| 当前开售竞猜赛程、竞彩赛程、竞彩足球/竞彩篮球/传统足彩赛程 | `sports-api-match-list` |
| 某场或某玩法的可选投注项、玩法选项 | `sports-api-match-options` |
| 按比赛日期或传统足彩期次查询赛果、开奖 | `sports-api-match-prize-list` |
| 按一个或多个比赛 ID 查询赛果 | `sports-api-match-prize-by-id` |
| 数字彩最新开奖，如双色球、大乐透、快乐8、七星彩、福彩3D、排列三、排列五 | `sports-api-number-prize-list` |
| 指定数字彩彩种最近 15 期开奖历史 | `sports-api-number-prize-history` |

## 2.2 比赛详情

| 用户意图 | 接口指南 |
|---|---|
| 历史交锋、近期战绩 | `sports-api-match-history` |
| 阵容、首发、替补 | `sports-api-match-lineup` |
| 比赛相关排名、积分排名 | `sports-api-match-ranking` |
| 比赛直播数据、实时事件 | `sports-api-match-live` |

## 2.3 指数

| 用户意图 | 接口指南 |
|---|---|
| 胜平负、让球、凯利、欧赔、亚盘或大小球指数列表 | `sports-api-odds-main` |
| 总进球数、比分或半全场指数列表 | `sports-api-odds-score` |
| 某公司的胜平负、让球、凯利、欧赔、亚盘或大小球指数详情 | `sports-api-odds-main-detail` |
| 某公司的总进球数、比分或半全场指数详情 | `sports-api-odds-score-detail` |
| 欧指走势、欧赔概率变化、赔率升降公司数、公司风险分布 | `sports-api-odds-europe-trend` |
| 主客队近 20 场的进球、半场/全场胜平负或常见比分对比 | `sports-api-odds-home-away` |
| 亚指走势、升降盘、高低水、赢盘率或同盘口历史 | `sports-api-odds-asia-trend` |
| 必发盈亏、成交量或胜平负各方向的盈亏汇总 | `sports-api-odds-betfair-profit` |
| 必发大额交易、买卖盘、近 6 小时交易走势或成交明细 | `sports-api-odds-betfair-detail` |

## 2.4 情报内参

| 用户意图 | 接口指南 |
|---|---|
| 密报 | `sports-api-secret-report` |
| 内参、比赛分析 | `sports-api-insider-analysis` |
| 选号分布、投注热度 | `sports-api-pick-distribution` |

## 2.5 专家及内容

接口文档将此分组标为待定。

## 2.6 世界杯赛事资料

| 用户意图 | 接口指南 |
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

| 用户意图 | 接口指南 |
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

| 用户意图 | 接口指南 |
|---|---|
| 指定球队的赛程 | `sports-api-team-games` |
| 指定年份的球队球员转会 | `sports-api-team-transfers` |
| 球队基本资料 | `sports-api-team-info` |
| 球队球员名单 | `sports-api-team-players` |
| 球队主页聚合数据 | `sports-api-team-home` |
| 球队统计分析数据 | `sports-api-team-stats` |
| 球队可查询的转会年份列表 | `sports-api-team-transfer-years` |

## 2.9 球员资料库

| 用户意图 | 接口指南 |
|---|---|
| 指定球员的主页聚合数据 | `sports-api-player-home` |
| 指定球员的赛程、比赛记录或翻页查询 | `sports-api-player-games` |
| 指定球员的能力、能力值或能力指标 | `sports-api-player-ability` |
| 球员基本资料 | `sports-api-player-info` |
| 球员统计分析数据 | `sports-api-player-stats` |
| 根据别名文字查询对应实体，未指定实体类型 | `sports-api-alias` |
| 根据实体类型（赛事/比赛/球队/球员/裁判/教练/场馆）和别名文字查询 | `sports-api-alias-type` |
| 根据比赛 ID 列表批量获取关联球队、教练、裁判、场馆的别名 | `sports-api-alias-games` |

三个别名接口沿用源文档 2.9 的章节归属，查询对象不限于球员。

## 2.10 赛事资讯资料库

| 用户意图 | 接口指南 |
|---|---|
| 指定日期的赛事资讯、体育新闻、中英文资讯内容 | `sports-api-game-news-date` |
| 按一个或多个比赛 ID 查询外网文章、新闻或中文资讯 | `sports-api-game-news-external` |
| 按单个比赛 ID 查询综合情报、伤停、主客队情报和外网资讯 | `sports-api-game-news-report` |

## 决策边界

- “竞彩赛程”优先路由到 `sports-api-match-list`。
- 用户明确提到世界杯或女篮世界杯时，优先使用对应专题指南，而不是通用竞猜赛程。
- 用户明确提供 `teamId` 并询问赛程时，优先使用 `sports-api-team-games`。
- 用户明确提供 `playerId` 并询问赛程时，优先使用 `sports-api-player-games`；询问能力时使用 `sports-api-player-ability`。
- 按机构查赔率列表或单一机构的变化历史时，选择原指数列表或详情接口。查跨机构的概率、水位、升降盘统计时，选择欧指或亚指走势。必发汇总和逐笔明细分别走对应必发接口。
- 比赛赛果按 ID 使用 `sports-api-match-prize-by-id`，按比赛日期或传统足彩期次使用 `sports-api-match-prize-list`。数字彩使用本表的最新开奖或历史开奖指南。
- 用户提供别名文字且明确实体类型时使用 `sports-api-alias-type`；仅提供别名文字时使用 `sports-api-alias`；提供比赛 ID 列表并要关联实体别名时使用 `sports-api-alias-games`。名称为“比赛”的实体类型查询仍属于 `sports-api-alias-type`，不能误当成比赛 ID 查询。
- 按日期查资讯使用 `sports-api-game-news-date`。按比赛查外网文章使用 `sports-api-game-news-external`，需要单场综合情报与资讯时使用 `sports-api-game-news-report`。
- 仍有两个同等合理的候选项时，不调用接口，先给出编号选项让用户确认。
