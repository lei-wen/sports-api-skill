---
name: sports-api-game-news-external
description: 按一个或多个竞猜比赛 ID 查询外网赛事资讯、文章原文和中文内容。
---

# 外网资讯

使用红火赛事数据的 `POST /api/v1/getnewslist`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `matchid2_list` | array | 必填 | 比赛 ID 列表，至少一个竞猜赛程返回的 `match_id2` |

每个 ID 用一个 `matchid2_list[]` 表单字段。单个 ID 同样保留方括号。

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/getnewslist \
  'matchid2_list[]=2688874' \
  'matchid2_list[]=2681389'
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

`data` 是文章列表。按 `gameId` 分组，使用 `titleChs`、`summaryChs`、`contentChs` 及对应原文整理资讯，保留 `site` 和 `url`。仅在 `publishTime` 有值时展示发布时间。将文章中的预测归于原来源。

### 响应字段映射

对应《赛事数据接口说明文档》2.10.2「外网资讯」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 array | 接口业务数据 |
| `data[].id` | `string` | id |
| `data[].infoId` | `string` | 文章id |
| `data[].gameId` | `integer` | 比赛id |
| `data[].issueId` | `string` | 期次 |
| `data[].issueNum` | `string` | 场次 |
| `data[].gameTime` | `string` | 比赛时间 |
| `data[].title` | `string` | 标题 |
| `data[].titleChs` | `string` | 标题（中文） |
| `data[].content` | `string` | 文章内容 |
| `data[].contentChs` | `string` | 文章内容（中文） |
| `data[].category` | `string`；示例可为 null | 分类 |
| `data[].tournamentName` | `string` | 赛事名称 |
| `data[].homeTeamName` | `string` | 主队名称 |
| `data[].awayTeamName` | `string` | 客队名称 |
| `data[].publishTime` | `string`；示例可为 null | 文章发布时间 |
| `data[].authorName` | `string` | 文章作者名称 |
| `data[].summary` | `string` | 文章摘要 |
| `data[].summaryChs` | `string` | 文章摘要（中文） |
| `data[].possibleLineup` | `string` | 预计首发内容 |
| `data[].possibleLineupChs` | `string` | 计首发内容（中文） |
| `data[].teamNews` | `string` | 团队新闻 |
| `data[].teamNewsChs` | `string` | 团队新闻（中文） |
| `data[].recommend` | `string` | 推荐 |
| `data[].recommendChs` | `string` | 推荐（中文） |
| `data[].prediction` | `string` | 预测 |
| `data[].predictionChs` | `string` | 预测（中文） |
| `data[].dataAnalysis` | `string` | 数据分析 |
| `data[].dataAnalysisChs` | `string` | 数据分析（中文） |
| `data[].url` | `string` | 文章链接 |
| `data[].site` | `string` | 来源网站 |
| `data[].enableState` | `integer` | 启用状态 |
| `data[].createTime` | `string` | 创建时间 |
| `data[].updateTime` | `string` | 更新时间 |

来源：[赛事数据接口说明文档 2.10.2 外网资讯](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
