---
name: sports-api-game-news-report
description: 按单个竞猜比赛 ID 查询综合情报、伤停、主客队情报和外网资讯汇总。
---

# 情报资讯汇总

使用红火赛事数据的 `POST /api/v1/getnewsreport`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | integer | 必填 | 竞猜比赛 ID，使用竞猜赛程返回的 `match_id2` |

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/getnewsreport match_id2=2688874
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

从 `data.reportList` 读取内参、精选密报及伤停，从 `data.SoccerMatchTeamInfo` 区分主客队和中立情报。源示例的 `data.info` 是资讯数组，字段表标作对象，按实际结构读取。引用资讯时保留来源与时间。源文档注明 `bulletSport` 已停止更新，若使用该字段须标明时效。

来源：[赛事数据接口说明文档 2.10.3 情报资讯汇总](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
