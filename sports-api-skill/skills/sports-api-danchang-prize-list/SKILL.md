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
