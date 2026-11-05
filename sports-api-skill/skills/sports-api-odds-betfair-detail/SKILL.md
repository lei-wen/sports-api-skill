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

来源：[赛事数据接口说明文档 2.3.9 必发交易明细](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
