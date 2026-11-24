---
name: sports-api-odds-home-away
description: 查询指定竞猜比赛主客队近 20 场的进球数、半场和全场胜平负、常见比分及面对强弱队的统计。
---

# 主客对比

使用红火赛事数据的 `POST /api/v1/matchoddsscore`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | integer | 必填 | 竞猜比赛 ID，使用竞猜赛程返回的 `match_id2` |

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/matchoddsscore match_id2=2688874
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

用 `goalsStats` 对比进球区间场次，用 `homeWdlStats` 和 `awayWdlStats` 分别整理半场和全场数据。`homeHStats` 和 `awayAStats` 在源示例中是比分记录数组，`homeWsStats` 和 `awayWsStats` 则按强弱对手分类。源文档字段表对 `drawCount` 与 `lossCount` 的中文注释与字段名互换。接口方确认前，用原字段名展示这两个值。

### 响应字段映射

对应《赛事数据接口说明文档》2.3.6「主客对比」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.goalsStats` | `array` | 进球数区间统计 |
| `data.goalsStats[].name` | `string` | 区间名 |
| `data.goalsStats[].unit` | `string` | 单位 |
| `data.goalsStats[].awayTeamValue` | `integer`；示例 string | 客队近20场单场进球落在该区间的场次数 |
| `data.goalsStats[].homeTeamValue` | `integer`；示例 string | 主队近20场单场进球落在该区间的场次数 |
| `data.homeWdlStats` | `object` | 主队近20场胜平负统计 |
| `data.homeWdlStats.fullStats` | `object` | 全场胜平负 |
| `data.homeWdlStats.fullStats.drawCount` | `integer`；示例 string | 全场负场次 |
| `data.homeWdlStats.fullStats.lossCount` | `integer`；示例 string | 全场平场次 |
| `data.homeWdlStats.fullStats.winCount` | `integer`；示例 string | 全场胜场次 |
| `data.homeWdlStats.halfStats` | `object` | 半场胜平负 |
| `data.homeWdlStats.halfStats.drawCount` | `integer`；示例 string | 半场负场次 |
| `data.homeWdlStats.halfStats.lossCount` | `integer`；示例 string | 半场平场次 |
| `data.homeWdlStats.halfStats.winCount` | `integer`；示例 string | 半场胜场次 |
| `data.awayWdlStats` | `object` | 客队近20场胜平负统计 |
| `data.awayWdlStats.fullStats` | `object` | 全场胜平负 |
| `data.awayWdlStats.fullStats.drawCount` | `integer`；示例 string | 全场负场次 |
| `data.awayWdlStats.fullStats.lossCount` | `integer`；示例 string | 全场平场次 |
| `data.awayWdlStats.fullStats.winCount` | `integer`；示例 string | 全场胜场次 |
| `data.awayWdlStats.halfStats` | `object` | 半场胜平负 |
| `data.awayWdlStats.halfStats.drawCount` | `integer`；示例 string | 半场负场次 |
| `data.awayWdlStats.halfStats.lossCount` | `integer`；示例 string | 半场平场次 |
| `data.awayWdlStats.halfStats.winCount` | `integer`；示例 string | 半场胜场次 |
| `data.homeHStats` | `object`；示例 array | 主队连续战绩纪录 Top3 |
| `data.homeHStats[].count` | `integer`；示例 string | 该纪录出现的次数/明细计数 |
| `data.homeHStats[].score` | `integer`；示例 string | 纪录值（如比分/连续状态描述） |
| `data.awayAStats` | `object`；示例 array | 客队连续战绩纪录 Top3 |
| `data.awayAStats[].count` | `integer`；示例 string | 该纪录出现的次数/明细计数 |
| `data.awayAStats[].score` | `integer`；示例 string | 纪录值（如比分/连续状态描述） |
| `data.homeWsStats` | `object` | 主队面对强/弱队战绩 Top3 |
| `data.homeWsStats.strongStats` | `array` | 面对强队战绩 |
| `data.homeWsStats.strongStats[].count` | `integer`；示例 string | 出现次数/明细计数 |
| `data.homeWsStats.strongStats[].score` | `integer`；示例 string | 纪录值 |
| `data.homeWsStats.weakStats` | `array` | 面对弱队战绩 |
| `data.homeWsStats.weakStats[].count` | `integer`；示例 string | 出现次数/明细计数 |
| `data.homeWsStats.weakStats[].score` | `integer`；示例 string | 纪录值 |
| `data.awayWsStats` | `object` | 客队面对强/弱队战绩 Top3 |
| `data.awayWsStats.strongStats` | `array` | 面对强队战绩 |
| `data.awayWsStats.strongStats[].count` | `integer`；示例 string | 出现次数/明细计数 |
| `data.awayWsStats.strongStats[].score` | `integer`；示例 string | 纪录值 |
| `data.awayWsStats.weakStats` | `array` | 面对弱队战绩 |
| `data.awayWsStats.weakStats[].count` | `integer`；示例 string | 出现次数/明细计数 |
| `data.awayWsStats.weakStats[].score` | `integer`；示例 string | 纪录值 |

来源：[赛事数据接口说明文档 2.3.6 主客对比](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
