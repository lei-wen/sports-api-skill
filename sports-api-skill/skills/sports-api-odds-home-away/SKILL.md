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

来源：[赛事数据接口说明文档 2.3.6 主客对比](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
