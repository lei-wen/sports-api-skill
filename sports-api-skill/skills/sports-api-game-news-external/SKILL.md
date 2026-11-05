---
name: sports-api-game-news-external
description: 按一个或多个竞猜比赛 ID 查询外网赛事资讯、文章原文和中文内容。
---

# 外网资讯

使用红火赛事数据的 `POST /api/v1/getnewslist`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `matchid2_list` | array | 必填 | 比赛 ID 列表，至少一个竞猜赛程返回的 `match_id2` |

每个 ID 用一个 `matchid2_list[]` 表单字段。单个 ID 同样保留方括号。

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/getnewslist \
  'matchid2_list[]=2688874' \
  'matchid2_list[]=2681389'
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

`data` 是文章列表。按 `gameId` 分组，使用 `titleChs`、`summaryChs`、`contentChs` 及对应原文整理资讯，保留 `site` 和 `url`。仅在 `publishTime` 有值时展示发布时间。将文章中的预测归于原来源。

来源：[赛事数据接口说明文档 2.10.2 外网资讯](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
