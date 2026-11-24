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

### 响应字段映射

对应《赛事数据接口说明文档》2.1.5「数字彩开奖列表」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.list[].id` | `string` | id |
| `data.list[].lottery_type` | `string` | 彩种类型（例： SSQ/SuperLotto/KL8/NP7/3D/P3/P5 ） |
| `data.list[].lottery_no` | `string` | 期次号 |
| `data.list[].schedule_date` | `string` | 开奖日期 |
| `data.list[].start_time` | `string` | 期程（销售）开始时间 |
| `data.list[].end_time` | `string` | 期程（销售）截止时间 |
| `data.list[].prize_time` | `string` | 计划开奖时间 |
| `data.list[].status` | `string` | 期程状态（1 为正常） |
| `data.list[].prize_status` | `string` | 开奖状态：1 已开奖 |
| `data.list[].create_time` | `string` | 记录创建时间 |
| `data.list[].update_time` | `string` | 记录更新时间 |
| `data.list[].real_prize_time` | `string` | 实际开奖（开奖处理）时间 |
| `data.list[].itou_end_time` | `string` | 平台侧投注截止时间 |
| `data.list[].device_start_time` | `string` | 设备/终端开售时间 |
| `data.list[].stop_prize` | `string` | 暂停开奖标记：0 正常 |
| `data.list[].special_period` | `string` | 特殊期标记：0 普通期 |
| `data.list[].lottery_result` | `string` | 开奖号码 |
| `data.list[].sale` | `string` | 本期销售额（元） |
| `data.list[].pool_prize` | `string` | 奖池滚存金额（元） |
| `data.list[].prize_list` | `array`；示例 object | 奖级信息 |
| `data.list[].prize_list[{奖级编号}]` | `string`；示例 object | 奖级编号 |
| `data.list[].prize_list[{奖级编号}].prize` | `string` | 单注奖金（元），保留两位小数 |
| `data.list[].prize_list[{奖级编号}].hit_num` | `string` | 中奖注数 |
| `data.list[].prize_list[{奖级编号}].prize_level_name` | `string` | 奖级名称 |

来源：[赛事数据接口说明文档 2.1.5 数字彩开奖列表](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
