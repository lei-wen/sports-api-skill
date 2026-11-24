---
name: sports-api-odds-betfair-profit
description: 查询指定竞猜比赛的必发交易盈亏、成交量、成交价及胜平负各方向的盈亏指数。
---

# 必发交易盈亏

使用红火赛事数据的 `POST /api/v1/matchoddsbetfair`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | integer | 必填 | 竞猜比赛 ID，使用竞猜赛程返回的 `match_id2` |

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/matchoddsbetfair match_id2=2688874
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

用 `totalAmount` 和 `totalLoss` 展示总成交量与盈亏。字段前缀 `left`、`middle`、`right` 对应主胜、平局、客胜，分别整理成交量（`Amount`）、盈亏（`Loss`）、成交价（`Price`）和成交占比（`Per`）。源示例中的数值可能以字符串返回，保留盈亏符号。

### 响应字段映射

对应《赛事数据接口说明文档》2.3.8「必发交易盈亏」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.gameId` | `integer`；示例 string | 赛事ID |
| `data.totalAmount` | `number`；示例 string | 必发总成交量 |
| `data.totalLoss` | `number`；示例 string | 总盈亏/总赔付额 |
| `data.amountOrder` | `number`；示例 string | 成交量排序（按方向排序结果） |
| `data.lossOrder` | `number`；示例 string | 盈亏排序 |
| `data.left` | `number`；示例 string | 主胜方向盈亏指数 |
| `data.leftAmount` | `number`；示例 string | 主胜方向成交量 |
| `data.leftLoss` | `number`；示例 string | 主胜方向盈亏 |
| `data.leftHc` | `number`；示例 string | 主胜方向对应盘口（handicap） |
| `data.leftPer` | `number`；示例 string | 主胜方向成交量占比 |
| `data.leftPrice` | `number`；示例 string | 主胜方向当前成交价（必发赔率） |
| `data.middle` | `number`；示例 string | 平局方向盈亏指数 |
| `data.middleAmount` | `number`；示例 string | 平局方向成交量 |
| `data.middleLoss` | `number`；示例 string | 平局方向盈亏 |
| `data.middleHc` | `number`；示例 string | 平局方向盘口 |
| `data.middlePer` | `number`；示例 string | 平局方向成交量占比 |
| `data.middlePrice` | `number`；示例 string | 平局方向当前成交价 |
| `data.right` | `number`；示例 string | 客胜方向盈亏指数 |
| `data.rightAmount` | `number`；示例 string | 客胜方向成交量 |
| `data.rightLoss` | `number`；示例 string | 客胜方向盈亏 |
| `data.rightHc` | `number`；示例 string | 客胜方向盘口 |
| `data.rightPer` | `number`；示例 string | 客胜方向成交量占比 |
| `data.rightPrice` | `number`；示例 string | 客胜方向当前成交价 |
| `data.bankerWinItem` | `string` | 庄家盈利项 |
| `data.bankerLossItem` | `string` | 庄家亏损项 |
| `data.avgLeftProbability` | `number`；示例 string | 主胜平均概率 |
| `data.avgMiddleProbability` | `number`；示例 string | 平局平均概率 |
| `data.avgRightProbability` | `number`；示例 string | 客胜平均概率 |
| `data.matchId` | `integer`；示例 string | 赛事ID |

来源：[赛事数据接口说明文档 2.3.8 必发交易盈亏](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
