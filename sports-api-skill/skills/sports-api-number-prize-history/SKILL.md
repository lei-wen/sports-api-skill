---
name: sports-api-number-prize-history
description: 查询指定数字彩彩种最近 15 期的开奖历史，适用于双色球、大乐透、快乐8、七星彩、福彩3D、排列三和排列五。
---

# 数字彩历史开奖

使用红火赛事数据的 `POST /api/v1/shuziprizelistbytype`。表单字段用 `multipart/form-data` 发送。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `lottery_type` | string | 必填 | 数字彩类型 ID，大小写以列表响应中的代码为准 |

源文档未列枚举表，以下代码来自 2.1.5 最新开奖列表的响应示例。查询未列出的彩种时先确认接口方提供的代码。

| 彩种 | 代码 |
|---|---|
| 双色球 | `SSQ` |
| 大乐透 | `SuperLotto` |
| 快乐8 | `KL8` |
| 体彩七星彩 | `NP7` |
| 福彩3D | `3D` |
| 排列三 | `P3` |
| 排列五 | `P5` |

接口固定返回最近 15 期。用户指定日期或期次时，在这 15 期内筛选，并说明可查询的范围。

## 调用示例

从总 Skill 根目录执行。命令由脚本从环境变量读取凭据。

```bash
scripts/request.sh /api/v1/shuziprizelistbytype lottery_type=SSQ
```

## 响应处理

先检查 HTTP 状态，再确认业务 `errcode` 为 `0`。错误时返回业务码和 `msg`。

开奖记录位于 `data.list`，用 `lottery_type`、`lottery_no`、`schedule_date` 和 `lottery_result` 区分彩种、期次、开奖日期和开奖号码。按原样保留开奖号码和前导零。需要奖级明细时读取 `prize_list`，源示例按奖级编号键控，包含 `prize_level_name`、`prize` 和 `hit_num`。

来源：[赛事数据接口说明文档 2.1.6 数字彩历史开奖](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
