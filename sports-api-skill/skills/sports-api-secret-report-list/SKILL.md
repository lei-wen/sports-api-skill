---
name: sports-api-secret-report-list
description: 查询按彩种、分页或更新时间查询密报列表。
---

# 按彩种、分页或更新时间查询密报列表

## 请求参数

必填字符串 `lottery_type`：竞彩足球 `jczq`、竞彩篮球 `jclq`、传统足彩 `zc`、北京单场 `dc`。可选整数 `page` 和 `page_size` 控制分页；可选字符串 `update_time` 筛选该时间之后更新的内容，格式见示例。

## 调用示例

在总技能根目录运行以下命令。共用脚本从环境变量读取鉴权信息，以 POST 发送表单参数。

```bash
scripts/request.sh /api/v1/matchReportList lottery_type=jczq page=1 page_size=10 'update_time=2026-11-11 12:00:00'
```

## 响应处理

业务码 `errcode` 为 0 时读取数据。响应示例的 `data.list` 是比赛数组。按 `match_id2`、主客队和 `update_time` 整理每场的独家报料、伤停或精选密报。`match_status` 的 N、L、F 分别表示未开赛、进行中、已结束。
