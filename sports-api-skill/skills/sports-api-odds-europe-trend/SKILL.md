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

来源：[赛事数据接口说明文档 2.3.5 欧指走势](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
