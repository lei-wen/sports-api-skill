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

### 响应字段映射

对应《赛事数据接口说明文档》2.4.4「密报列表」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.list` | `object`；示例 array | 情报列表 |
| `data.list[].inner_ref` | `object`；示例 array | 独家报料 |
| `data.list[].trace_analysis` | `array` | 猛料追踪 |
| `data.list[].selected_news` | `object`；示例 array | 精选密报 |
| `data.list[].inner_ref_num` | `integer` | 内参密报数量 |
| `data.list[].home_team_name` | `string` | 主队名称 |
| `data.list[].away_team_name` | `string` | 客队名称 |
| `data.list[].home_team_img` | `string` | 主队图标 |
| `data.list[].away_team_img` | `string` | 客队图标 |
| `data.list[].lottery_no` | `integer`；示例 string | 竞彩编号 |
| `data.list[].serial_no` | `string` | 赛事编号 |
| `data.list[].injury_analysis` | `string` | 伤情解读 |
| `data.list[].home_injury` | `array` | 主队伤停预览 |
| `data.list[].away_injury` | `array` | 客队伤停预览 |
| `data.list[].match_forecast` | `string` | 海外专家团 - 赛事预测 |
| `data.list[].home_news` | `string` | 海外专家团 - 主队新闻 |
| `data.list[].away_news` | `string` | 海外专家团 - 客队新闻 |
| `data.list[].match_data` | `string` | 海外专家团 - 赛事数据 |
| `data.list[].result_forecast` | `string` | 海外专家团 - 比分参考 |
| `data.list[].com_refer` | `object` | 综合分析 |
| `data.list[].report_update_time` | `string` | 情报更新时间 |
| `data.list[].analysis_update_time` | `string` | 分析更新时间 |
| `data.list[].update_time` | `string` | 更新时间 |
| `data.list[].info_img` | `string` | 独家报料吸引力图片 |
| `data.list[].normal_img` | `string` | 普通情报吸引力图片 |
| `data.list[].review_info` | `object` | 复盘信息 |
| `data.list[].match_id2` | `integer` | 比赛ID |
| `data.list[].match_status` | `string` | 比赛状态： / N - 未开赛 / L - 进行中 / F - 已结束 |
| `data.list[].is_jczq` | `integer` | 是否是竞足 |
| `data.list[].is_jclq` | `integer` | 是否是竞篮 |
| `data.list[].is_dc` | `integer` | 是否是单场 |
| `data.list[].is_zc` | `integer` | 是否是足彩 |
