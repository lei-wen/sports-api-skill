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

来源：[赛事数据接口说明文档 2.3.8 必发交易盈亏](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
