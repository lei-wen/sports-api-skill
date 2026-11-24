---
name: sports-api-pick-distribution
description: 调用赛事数据服务的“选号分布”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 选号分布

调用红火赛事数据服务的“选号分布”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/matchInfoPopularity`
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
| `match_id2` | integer | 必填 | 比赛 ID2 |
| `jc_type` | string | 必填 | jczq（竞彩足球）或 dc（北京单场） |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/matchInfoPopularity" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'match_id2=<value>' \
  --form 'jc_type=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.4.3「选号分布」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

玩法代码及选项代码随玩法变化；样例 `ratio` 为小数，应按接口原值读取。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.match_id2` | `string` | 比赛ID2 |
| `data.host_name_s` | `string` | 主队名 |
| `data.guest_name_s` | `string` | 客队名 |
| `data.trade_options_play_list` | `array`；示例 object | 竞彩全玩法模拟选号分布，参考【3.2 竞猜玩法说明】 |
| `data.trade_options_play_list[{玩法代码}].list[{选项代码}].ratio` | `integer`；示例 number | 该选项的人气占比 |
| `data.match_play_list` | `array`；示例 object | 竞彩全玩法比赛赛果，参考【3.2 竞猜玩法说明】 |
| `data.match_id` | 示例 string | 内部比赛 ID |
| `data.match_time` | 示例 string | 比赛时间 |
| `data.bet_time` | 示例 string | 投注截止时间 |
| `data.total_popularity_index` | 示例 integer | 总人气指数 |
| `data.historical_highest_popularity_index` | 示例 integer | 历史最高人气指数 |
| `data.current_popularity_rank` | 示例 integer | 当前人气排名 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
