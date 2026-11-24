---
name: sports-api-game-news-report
description: 按单个竞猜比赛 ID 查询综合情报、伤停、主客队情报和外网资讯汇总。
---

# 情报资讯汇总

使用红火赛事数据的 `POST /api/v1/getnewsreport`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | integer | 必填 | 竞猜比赛 ID，使用竞猜赛程返回的 `match_id2` |

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/getnewsreport match_id2=2688874
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

从 `data.reportList` 读取内参、精选密报及伤停，从 `data.SoccerMatchTeamInfo` 区分主客队和中立情报。源示例的 `data.info` 是资讯数组，字段表标作对象，按实际结构读取。引用资讯时保留来源与时间。源文档注明 `bulletSport` 已停止更新，若使用该字段须标明时效。

### 响应字段映射

对应《赛事数据接口说明文档》2.10.3「情报资讯汇总」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

`info` 的字段表和响应示例存在差异。示例展示关联赛事、球队、裁判和场馆；读取资讯字段时以实际返回的结构为准。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.reportList` | `object` | 情报 |
| `data.reportList.inner_ref` | `object`；示例 array | 内参密报 |
| `data.reportList.trace_analysis` | `array` | 猛料追踪 |
| `data.reportList.selected_news` | `object`；示例 array | 精选密报 |
| `data.reportList.inner_ref_num` | `integer`；示例 string | 内参密报数量 |
| `data.reportList.home_team_name` | `string` | 主队名称 |
| `data.reportList.away_team_name` | `string` | 客队名称 |
| `data.reportList.home_team_img` | `string` | 主队图标 |
| `data.reportList.away_team_img` | `string` | 客队图标 |
| `data.reportList.lottery_no` | `integer`；示例 string | 竞彩编号 |
| `data.reportList.serial_no` | `string` | 赛事编号 |
| `data.reportList.injury_analysis` | `string` | 伤情解读 |
| `data.reportList.home_injury` | `array` | 主队伤停预览 |
| `data.reportList.away_injury` | `array` | 客队伤停预览 |
| `data.reportList.match_forecast` | `string` | 海外专家团 - 赛事预测 |
| `data.reportList.home_news` | `string` | 海外专家团 - 主队新闻 |
| `data.reportList.away_news` | `string` | 海外专家团 - 客队新闻 |
| `data.reportList.match_data` | `string` | 海外专家团 - 赛事数据 |
| `data.reportList.result_forecast` | `string` | 海外专家团 - 比分参考 |
| `data.reportList.com_refer` | `object` | 综合分析 |
| `data.reportList.report_update_time` | `string` | 情报更新时间 |
| `data.reportList.analysis_update_time` | `string` | 分析更新时间 |
| `data.reportList.update_time` | `string` | 更新时间 |
| `data.SoccerMatchTeamInfo` | `object` | 比赛情报数据 |
| `data.SoccerMatchTeamInfo.info_num` | `integer`；示例 string | 情报角标总数 |
| `data.SoccerMatchTeamInfo.home_list` | `object` | 主队情报 |
| `data.SoccerMatchTeamInfo.home_list.good` | `key` | 主队有利情报 |
| `data.SoccerMatchTeamInfo.home_list.good[].gameId` | `integer`；示例 string | 比赛 ID |
| `data.SoccerMatchTeamInfo.home_list.good[].importantValue` | `integer`；示例 string | 情报重要程度（1–5，值越大越重要） |
| `data.SoccerMatchTeamInfo.home_list.good[].intelligenceType` | `integer`；示例 string | 情报类型：0 中立、1 有利、2 不利 |
| `data.SoccerMatchTeamInfo.home_list.good[].intelligenceValue` | `string` | 情报内容文本 |
| `data.SoccerMatchTeamInfo.home_list.good[].sort` | `integer`；示例 string | 排序值，升序展示 |
| `data.SoccerMatchTeamInfo.home_list.good[].teamSide` | `integer`；示例 string | 所属方：1 主队、2 客队（0 或中立情报时无意义） |
| `data.SoccerMatchTeamInfo.home_list.bad` | `key` | 主队不利情报 |
| `data.SoccerMatchTeamInfo.home_list.bad[].gameId` | `integer`；示例 string | 比赛 ID |
| `data.SoccerMatchTeamInfo.home_list.bad[].importantValue` | `integer`；示例 string | 情报重要程度（1–5，值越大越重要） |
| `data.SoccerMatchTeamInfo.home_list.bad[].intelligenceType` | `integer`；示例 string | 情报类型：0 中立、1 有利、2 不利 |
| `data.SoccerMatchTeamInfo.home_list.bad[].intelligenceValue` | `string` | 情报内容文本 |
| `data.SoccerMatchTeamInfo.home_list.bad[].sort` | `integer`；示例 string | 排序值，升序展示 |
| `data.SoccerMatchTeamInfo.home_list.bad[].teamSide` | `integer`；示例 string | 所属方：1 主队、2 客队（0 或中立情报时无意义） |
| `data.SoccerMatchTeamInfo.away_list` | `object` | 客队情报 |
| `data.SoccerMatchTeamInfo.away_list.good` | `key` | 客队有利情报 |
| `data.SoccerMatchTeamInfo.away_list.good[].gameId` | `integer`；示例 string | 比赛 ID |
| `data.SoccerMatchTeamInfo.away_list.good[].importantValue` | `integer`；示例 string | 情报重要程度（1–5，值越大越重要） |
| `data.SoccerMatchTeamInfo.away_list.good[].intelligenceType` | `integer`；示例 string | 情报类型：0 中立、1 有利、2 不利 |
| `data.SoccerMatchTeamInfo.away_list.good[].intelligenceValue` | `string` | 情报内容文本 |
| `data.SoccerMatchTeamInfo.away_list.good[].sort` | `integer`；示例 string | 排序值，升序展示 |
| `data.SoccerMatchTeamInfo.away_list.good[].teamSide` | `integer`；示例 string | 所属方：1 主队、2 客队（0 或中立情报时无意义） |
| `data.SoccerMatchTeamInfo.away_list.bad` | `key` | 客队不利情报 |
| `data.SoccerMatchTeamInfo.away_list.bad[].gameId` | `integer`；示例 string | 比赛 ID |
| `data.SoccerMatchTeamInfo.away_list.bad[].importantValue` | `integer`；示例 string | 情报重要程度（1–5，值越大越重要） |
| `data.SoccerMatchTeamInfo.away_list.bad[].intelligenceType` | `integer`；示例 string | 情报类型：0 中立、1 有利、2 不利 |
| `data.SoccerMatchTeamInfo.away_list.bad[].intelligenceValue` | `string` | 情报内容文本 |
| `data.SoccerMatchTeamInfo.away_list.bad[].sort` | `integer`；示例 string | 排序值，升序展示 |
| `data.SoccerMatchTeamInfo.away_list.bad[].teamSide` | `integer`；示例 string | 所属方：1 主队、2 客队（0 或中立情报时无意义） |
| `data.SoccerMatchTeamInfo.equal_list` | `array` | 中立情报（不分主客） |
| `data.SoccerMatchTeamInfo.info_type` | `integer`；示例 string | 情报来源类型：1 默认情报（编辑情报）；2 爆料或伤停情报 |
| `data.SoccerMatchTeamInfo.remark` | `array` | 爆料或伤停情报列表 |
| `data.info` | `object`；示例 array | 资讯 |
| `data.info.id` | `string` | id。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.infoId` | `string` | 文章id。文档列于 `info` 下，示例未展示此路径。 |
| `data.info[].gameId` | `integer`；示例 string | 比赛id |
| `data.info.issueId` | `string` | 期次。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.issueNum` | `string` | 场次。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.gameTime` | `string` | 比赛时间。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.title` | `string` | 标题。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.titleChs` | `string` | 标题（中文）。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.content` | `string` | 文章内容。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.contentChs` | `string` | 文章内容（中文）。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.category` | `string` | 分类。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.tournamentName` | `string` | 赛事名称。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.homeTeamName` | `string` | 主队名称。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.awayTeamName` | `string` | 客队名称。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.publishTime` | `string` | 文章发布时间。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.authorName` | `string` | 文章作者名称。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.summary` | `string` | 文章摘要。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.summaryChs` | `string` | 文章摘要（中文）。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.possibleLineup` | `string` | 预计首发内容。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.possibleLineupChs` | `string` | 计首发内容（中文）。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.teamNews` | `string` | 团队新闻。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.teamNewsChs` | `string` | 团队新闻（中文）。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.recommend` | `string` | 推荐。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.recommendChs` | `string` | 推荐（中文）。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.prediction` | `string` | 预测。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.predictionChs` | `string` | 预测（中文）。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.dataAnalysis` | `string` | 数据分析。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.dataAnalysisChs` | `string` | 数据分析（中文）。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.url` | `string` | 文章链接。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.site` | `string` | 来源网站。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.enableState` | `integer` | 启用状态。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.createTime` | `string` | 创建时间。文档列于 `info` 下，示例未展示此路径。 |
| `data.info.updateTime` | `string` | 更新时间。文档列于 `info` 下，示例未展示此路径。 |
| `data.bulletSport` | `object` | 子弹体育数据（已经不更新了） |
| `data.bulletSport.home_list` | `array` | 主队 |
| `data.bulletSport.away_list` | `array` | 客队 |

来源：[赛事数据接口说明文档 2.10.3 情报资讯汇总](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
