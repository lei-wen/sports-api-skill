---
name: sports-api-danchang-prize-list
description: 查询北京单场赛果和期次列表。
---

# 北京单场赛果和期次列表

## 请求参数

全部参数可省略。字符串 `lottery_no` 指定北单期号，默认取期次列表第一项。整数 `page` 默认 1，`page_size` 默认 10。

## 调用示例

在总技能根目录运行以下命令。共用脚本从环境变量读取鉴权信息，以 POST 发送表单参数。

```bash
scripts/request.sh /api/v1/danchangprizelist lottery_no=126115 page=1 page_size=10
```

## 响应处理

业务码 `errcode` 为 0 时读取数据。从 `data.lottery_no_list` 读取可选期次，从 `data.result_list` 读取总数 `total` 和以期号为键的比赛数组。按 `is_prize` 判断是否开奖，再按玩法读取场次 `list` 中的 `lottery_result` 和 `odds`。

### 响应字段映射

对应《赛事数据接口说明文档》2.1.7「赛果开奖（北京单场）」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.lottery_no_list` | `array` | 可选择的期号列表 |
| `data.result_list` | `object` | 开奖结果列表，按期号分组 |
| `data.result_list.total` | `integer` | 场次总数 |
| `data.result_list[{期次}]` | `array<object>` | 该期比赛场次列表，key 为期号 |
| `data.result_list[{期次}][].lottery_no` | `integer`；示例 string | 期号，如 126112 |
| `data.result_list[{期次}][].serial_no` | `integer`；示例 string | 场次序号 |
| `data.result_list[{期次}][].match_id` | `integer`；示例 string | 比赛ID |
| `data.result_list[{期次}][].match_id2` | `integer`；示例 string | 比赛ID 2 |
| `data.result_list[{期次}][].match_time` | `string` | 比赛开赛时间 |
| `data.result_list[{期次}][].bet_time` | `string` | 投注截止时间 |
| `data.result_list[{期次}][].bet_date` | `string` | 投注日期 |
| `data.result_list[{期次}][].league_name` | `string` | 联赛名称 |
| `data.result_list[{期次}][].host_name_s` | `string` | 主队简称 |
| `data.result_list[{期次}][].guest_name_s` | `string` | 客队简称 |
| `data.result_list[{期次}][].host_name_l` | `string` | 主队全称 |
| `data.result_list[{期次}][].guest_name_l` | `string` | 客队全称 |
| `data.result_list[{期次}][].host_goals` | `integer`；示例 string | 主队全场进球数 |
| `data.result_list[{期次}][].guest_goals` | `integer`；示例 string | 客队全场进球数 |
| `data.result_list[{期次}][].half_host_goals` | `integer`；示例 string | 主队半场进球数 |
| `data.result_list[{期次}][].half_guest_goals` | `integer`；示例 string | 客队半场进球数 |
| `data.result_list[{期次}][].sale_status` | `integer`；示例 string | 销售状态：1=在售 |
| `data.result_list[{期次}][].is_prize` | `integer`；示例 string | 是否已开奖：1=已开奖 |
| `data.result_list[{期次}][].reversion` | `integer`；示例 string | 反转/顺延标识，0=正常 |
| `data.result_list[{期次}][].neutral_ground` | `integer`；示例 string | 是否中立场：0=否 |
| `data.result_list[{期次}][].create_time` | `string` | 创建时间 |
| `data.result_list[{期次}][].update_time` | `string` | 更新时间 |
| `data.result_list[{期次}][].match_end_time` | `string` | 比赛实际结束时间 |
| `data.result_list[{期次}][].expect_prize_time` | `string` | 预计开奖时间 |
| `data.result_list[{期次}][].actual_prize_time` | `string` | 实际开奖时间 |
| `data.result_list[{期次}][].event_id` | `string` | 事件唯一标识（md5） |
| `data.result_list[{期次}][].sport_type` | `integer`；示例 string | 种类型：201=足球（对应竞足） |
| `data.result_list[{期次}][].is_disable` | `integer`；示例 string | 是否禁用：0=正常 |
| `data.result_list[{期次}][].is_close` | `integer`；示例 string | 是否封盘：0=未封盘 |
| `data.result_list[{期次}][].is_hot` | `integer`；示例 string | 是否热门：0=非热门 |
| `data.result_list[{期次}][].stop_prize` | `integer`；示例 string | 是否停止开奖：0=正常 |
| `data.result_list[{期次}][].list` | `object` | 各玩法赔率及开奖结果，key 为玩法代码 |
| `data.result_list[{期次}][].list[{玩法代码}]` | `object` | 玩法代码标识 |
| `data.result_list[{期次}][].list[{玩法代码}].bet_id` | `integer`；示例 string | 比赛表主键id |
| `data.result_list[{期次}][].list[{玩法代码}].is_single` | `integer`；示例 string | 是否支持单关：1=支持 |
| `data.result_list[{期次}][].list[{玩法代码}].boundary` | `integer`；示例 string | 盘口边界值（让球数/盘口线），0=平手盘，-1=受让1球 |
| `data.result_list[{期次}][].list[{玩法代码}].odds` | `number`；示例 string | 该玩法赔率 |
| `data.result_list[{期次}][].list[{玩法代码}].lottery_result` | `integer`；示例 string | 彩果 |
| `data.result_list[{期次}][].league_color` | `array` | 联赛主题色 |
| `data.result_list[{期次}][].sort` | `integer` | 场次排序序号 |
