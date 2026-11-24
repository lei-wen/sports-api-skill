---
name: sports-api-odds-betfair-detail
description: 查询指定竞猜比赛的必发交易明细，包括近 10 笔大额交易、最新买卖盘和近 6 小时的成交走势。
---

# 必发交易明细

使用红火赛事数据的 `POST /api/v1/matchoddsbetfairdetail`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | integer | 必填 | 竞猜比赛 ID，使用竞猜赛程返回的 `match_id2` |

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/matchoddsbetfairdetail match_id2=2688874
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

用 `bigAmounts` 展示按时间倒序的近 10 笔大额交易，方向代码 `3/1/0` 通常对应主胜、平局、客胜，反主客时以接口口径为准。`leftDetails`、`middleDetails`、`rightDetails` 分别是三个方向的近 6 小时走势。用对应的 `Buy`、`Sell`、`BuyQuoted` 和 `SellQuoted` 字段区分买卖价格与挂单量。

### 响应字段映射

对应《赛事数据接口说明文档》2.3.9「必发交易明细」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.bigAmounts` | `array` | 近10笔大额交易，按时间倒序 |
| `data.bigAmounts[].amount` | `integer`；示例 string | 交易金额 |
| `data.bigAmounts[].optionTypeId` | `integer`；示例 string | 方向："3"主胜 / "1"平局 / "0"客胜（reverse 时主客值对调） |
| `data.bigAmounts[].percent` | `string` | 交易占比，带 % 后缀 |
| `data.bigAmounts[].tradeType` | `string` | 交易属性 |
| `data.bigAmounts[].updateTime` | `string` | 交易时间 |
| `data.leftBuy` | `number` | 主胜方向最新买入价 |
| `data.leftBuyQuoted` | `integer` | 主胜方向最新买入量 |
| `data.leftSell` | `number` | 主胜方向最新卖出价 |
| `data.leftSellQuoted` | `integer` | 主胜方向最新卖出量 |
| `data.leftAmount` | `integer` | 主胜方向最新交易金额 |
| `data.leftPer` | `number` | 主胜方向最新交易占比 |
| `data.middleBuy` | `number` | 平局方向最新买入价 |
| `data.middleBuyQuoted` | `integer` | 平局方向最新买入量 |
| `data.middleSell` | `number` | 平局方向最新卖出价 |
| `data.middleSellQuoted` | `integer` | 平局方向最新卖出量 |
| `data.middleAmount` | `integer` | 平局方向最新交易金额 |
| `data.middlePer` | `number` | 平局方向最新交易占比 |
| `data.rightBuy` | `number` | 客胜方向最新买入价 |
| `data.rightBuyQuoted` | `integer` | 客胜方向最新买入量 |
| `data.rightSell` | `number` | 客胜方向最新卖出价 |
| `data.rightSellQuoted` | `integer` | 客胜方向最新卖出量 |
| `data.rightAmount` | `integer` | 客胜方向最新交易金额 |
| `data.rightPer` | `number` | 客胜方向最新交易占比 |
| `data.leftDetails` | `array` | 主胜方向近6小时交易走势 |
| `data.leftDetails[].amount` | `number`；示例 string | 交易金额 |
| `data.leftDetails[].odds` | `number`；示例 string | 最新成交价 |
| `data.middleDetails` | `array` | 平局方向走势 |
| `data.middleDetails[].amount` | `number`；示例 string | 交易金额 |
| `data.middleDetails[].odds` | `number`；示例 string | 最新成交价 |
| `data.rightDetails` | `array` | 客胜方向走势 |
| `data.rightDetails[].amount` | `number`；示例 string | 交易金额 |
| `data.rightDetails[].odds` | `number`；示例 string | 最新成交价 |

来源：[赛事数据接口说明文档 2.3.9 必发交易明细](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
