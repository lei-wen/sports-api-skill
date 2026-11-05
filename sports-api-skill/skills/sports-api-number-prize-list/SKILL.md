---
name: sports-api-number-prize-list
description: 查询双色球、大乐透、快乐8、七星彩、福彩3D、排列三和排列五的最新数字彩开奖。
---

# 数字彩开奖列表

使用红火赛事数据的 `POST /api/v1/shuziprizelist`。请求不带表单字段，脚本发送 `Content-Length: 0`。

## 请求参数

无。查询某个彩种的最新开奖时，调用后按返回的 `lottery_type` 筛选。

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/shuziprizelist
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

开奖记录位于 `data.list`，用 `lottery_type`、`lottery_no`、`schedule_date` 和 `lottery_result` 区分彩种、期次、开奖日期和开奖号码。按原样保留开奖号码和前导零。需要奖级明细时读取 `prize_list`，源示例按奖级编号键控，包含 `prize_level_name`、`prize` 和 `hit_num`。

来源：[赛事数据接口说明文档 2.1.5 数字彩开奖列表](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
