---
name: sports-api-odds-europe-trend
description: 查询指定竞猜比赛的欧指走势，包括欧赔概率、初终赔概率变化、赔率升降公司数和公司风险分布。
---

# 欧指走势

使用红火赛事数据的 `POST /api/v1/matchoddseurope`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | integer | 必填 | 竞猜比赛 ID，使用竞猜赛程返回的 `match_id2` |

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/matchoddseurope match_id2=2688874
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

从 `data.oddsProb` 读取胜平负概率及其变化。按文档，`changeProb1/2/3` 是概率，`prob1/2/3` 是终赔概率减初赔概率。用 `oddsChangeStats` 汇总赔率升降公司数，用 `compRiskStats` 汇总公司风险分布。后缀 `1/2/3` 对应主胜、平局、客胜。

### 响应字段映射

对应《赛事数据接口说明文档》2.3.5「欧指走势」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.compRiskStats` | `object` | 公司风险统计（各方向博彩公司数量分布） |
| `data.compRiskStats.odds1` | `integer` | 主胜方向公司数 |
| `data.compRiskStats.odds2` | `integer` | 平局方向公司数 |
| `data.compRiskStats.odds3` | `integer` | 客胜方向公司数 |
| `data.oddsProb` | `object` | 欧赔概率及概率变化 |
| `data.oddsProb.changeProb1` | `number` | 主胜概率 |
| `data.oddsProb.changeProb2` | `number` | 平局概率 |
| `data.oddsProb.changeProb3` | `number` | 客胜概率 |
| `data.oddsProb.prob1` | `number`；示例 string | 主胜概率变化值（终赔概率 − 初赔概率） |
| `data.oddsProb.prob2` | `number`；示例 string | 平局概率变化值 |
| `data.oddsProb.prob3` | `number`；示例 string | 客胜概率变化值 |
| `data.oddsChangeStats` | `object` | 赔率升降的公司数量统计 |
| `data.oddsChangeStats.ascBookmakerStats` | `object` | 赔率上升的公司数 |
| `data.oddsChangeStats.ascBookmakerStats.odds1` | `integer` | 主胜赔率上升的公司数 |
| `data.oddsChangeStats.ascBookmakerStats.odds2` | `integer` | 平局赔率上升的公司数 |
| `data.oddsChangeStats.ascBookmakerStats.odds3` | `integer` | 客胜赔率上升的公司数 |
| `data.oddsChangeStats.descBookmakerStats` | `object` | 赔率下降的公司数 |
| `data.oddsChangeStats.descBookmakerStats.odds1` | `integer` | 主胜赔率下降的公司数 |
| `data.oddsChangeStats.descBookmakerStats.odds2` | `integer` | 平局赔率下降的公司数 |
| `data.oddsChangeStats.descBookmakerStats.odds3` | `integer` | 客胜赔率下降的公司数 |

来源：[赛事数据接口说明文档 2.3.5 欧指走势](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
