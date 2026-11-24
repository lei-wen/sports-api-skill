---
name: sports-api-odds-asia-trend
description: 查询指定竞猜比赛的亚指走势，包括升降盘、水位变化、主客队赢盘率及同盘口历史统计。
---

# 亚指走势

使用红火赛事数据的 `POST /api/v1/matchoddsasia`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | integer | 必填 | 竞猜比赛 ID，使用竞猜赛程返回的 `match_id2` |

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/matchoddsasia match_id2=2688874
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

用 `homePercent` 和 `awayPercent` 展示主客队赢盘率，用 `homeOddsHandicapTrend` 和 `awayOddsHandicapTrend` 区分近期与历史同盘口记录。升降盘及高低水的公司数位于 `oddsChangeStats`。源示例中的数值可能以字符串返回，保留原单位。

### 响应字段映射

对应《赛事数据接口说明文档》2.3.7「亚指走势」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.awayPercent` | `number`；示例 string | 客队赢盘占比（百分比数值） |
| `data.homePercent` | `number`；示例 string | 主队赢盘占比（百分比数值） |
| `data.awayOddsHandicapTrend` | `object` | 客队盘口走势统计 |
| `data.awayOddsHandicapTrend.draw` | `integer`；示例 string | 近期平盘场次 |
| `data.awayOddsHandicapTrend.historyDraw` | `integer`；示例 string | 历史同盘口平盘场次 |
| `data.awayOddsHandicapTrend.historyLoss` | `integer`；示例 string | 历史同盘口输盘场次 |
| `data.awayOddsHandicapTrend.historyWin` | `integer`；示例 string | 历史同盘口赢盘场次 |
| `data.awayOddsHandicapTrend.loss` | `integer`；示例 string | 近期输盘场次 |
| `data.awayOddsHandicapTrend.win` | `integer`；示例 string | 近期赢盘场次 |
| `data.homeOddsHandicapTrend` | `object` | 主队盘口走势统计 |
| `data.homeOddsHandicapTrend.draw` | `integer`；示例 string | 近期平盘场次 |
| `data.homeOddsHandicapTrend.historyDraw` | `integer`；示例 string | 历史同盘口平盘场次 |
| `data.homeOddsHandicapTrend.historyLoss` | `integer`；示例 string | 历史同盘口输盘场次 |
| `data.homeOddsHandicapTrend.historyWin` | `integer`；示例 string | 历史同盘口赢盘场次 |
| `data.homeOddsHandicapTrend.loss` | `integer`；示例 string | 近期输盘场次 |
| `data.homeOddsHandicapTrend.win` | `integer`；示例 string | 近期赢盘场次 |
| `data.oddsChangeStats` | `object` | 亚盘指数变化公司数统计 |
| `data.oddsChangeStats.ascHcapBookmakerCount` | `integer` | 升盘的公司数 |
| `data.oddsChangeStats.descHcapBookmakerCount` | `integer` | 降盘的公司数 |
| `data.oddsChangeStats.highBookmakerCount` | `integer` | 高水（水位升高）公司数 |
| `data.oddsChangeStats.lowBookmakerCount` | `integer` | 低水（水位降低）公司数 |

来源：[赛事数据接口说明文档 2.3.7 亚指走势](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
