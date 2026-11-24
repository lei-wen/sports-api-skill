---
name: sports-api-secret-report
description: 调用赛事数据服务的“密报”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 密报

调用红火赛事数据服务的“密报”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/matchReportInfo`
- 生产环境：`https://apic.17honghuoyun.com`
- 请求体：文档示例使用 `multipart/form-data`，用 curl 的 `--form` 传参。

## 鉴权与本地配置

从环境变量读取凭据，绝不把真实密钥写入 Skill、命令历史、源码或输出：

- `SPORTS_API_APP_ID` -> 请求头 `app-id`
- `SPORTS_API_APP_SECRET` -> 请求头 `app-secret`
- `SPORTS_API_BASE_URL` -> 可选；未设置时使用生产环境

调用前检查两个凭据变量非空；缺失时停止并请用户配置。不要输出或回显完整凭据。

## 请求参数

| 参数 | 类型 | 要求 | 说明 |
|---|---|---|---|
| `match_id2` | integer | 必填 | 比赛 ID |
| `lottery_id` | integer | 必填 | 竞足 90、竞篮 91、足彩 10、北京单场 45 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/matchReportInfo" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'match_id2=<value>' \
  --form 'lottery_id=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.4.1「密报」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.inner_ref` | `array` | 独家报料 |
| `data.inner_ref[].belong_team` | `integer` | 立场： / 0 - 中立，1 - 主队，2 - 客队 |
| `data.inner_ref[].title` | `string` | 标题 |
| `data.inner_ref[].content` | `string` | 内容 |
| `data.inner_ref[].is_pay` | `string` | 是否付费： / 0 - 否， 1 - 是 |
| `data.inner_ref[].publish_time` | `string` | 发布时间 |
| `data.inner_ref[].tag_info` | `object` | 标签 |
| `data.inner_ref[].tag_info.name` | `string` | 标签名称 |
| `data.inner_ref[].tag_info.color` | `string` | 颜色 |
| `data.inner_ref[].odds_info` | `object` | 盘口变化 |
| `data.inner_ref[].odds_info.initial_left` | `string` | 初始赔率：胜 |
| `data.inner_ref[].odds_info.initial_middle` | `string` | 初始赔率：平 |
| `data.inner_ref[].odds_info.initial_right` | `string` | 初始赔率：负 |
| `data.inner_ref[].odds_info.current_left` | `string` | 即时赔率：胜 |
| `data.inner_ref[].odds_info.current_middle` | `string` | 即时赔率：平 |
| `data.inner_ref[].odds_info.current_right` | `string` | 即时赔率：负 |
| `data.inner_ref[].show_img` | `string` | 配图信息 |
| `data.trace_analysis` | `array` | 猛料追踪：格式参考 inner_ref 字段 |
| `data.selected_news` | `array` | 精选密报：格式参考 inner_ref 字段 |
| `data.home_team_name` | `string` | 主队名称 |
| `data.away_team_name` | `string` | 客队名称 |
| `data.home_team_img` | `string` | 主队图标 |
| `data.away_team_img` | `string` | 客队图标 |
| `data.lottery_no` | `string` | 竞彩编号 |
| `data.injury_analysis` | `string` | 伤停解读 |
| `data.home_injury` | `array` | 主队伤停预览 |
| `data.home_injury[].player_name` | `string` | 球员名字 |
| `data.home_injury[].position` | `string` | 球场位置 |
| `data.home_injury[].match_stats` | `string` | 比赛场次 |
| `data.home_injury[].player_role` | `string` | 场上定位 |
| `data.home_injury[].reason` | `string` | 伤停原因 |
| `data.away_injury` | `array` | 客队伤停预览：格式参考 home_injury 字段 |
| `data.match_forecast` | `string` | 海外专家团 - 赛事预测 |
| `data.home_news` | `string` | 海外专家团 - 主队新闻 |
| `data.away_news` | `string` | 海外专家团 - 客队新闻 |
| `data.match_data` | `string` | 海外专家团 - 赛事数据 |
| `data.result_forecast` | `object` | 海外专家团 - 比分参考 |
| `data.com_refer` | `object` | 专家预测 - 比分参考 |
| `data.com_refer.text` | `string` | 预测理由 |
| `data.com_refer.score` | `array` | 比分 |
| `data.com_refer.goals` | `array` | 总进球 |
| `data.com_refer.half_full` | `array` | 半全场 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
