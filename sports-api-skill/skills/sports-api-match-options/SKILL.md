---
name: sports-api-match-options
description: 调用赛事数据服务的“玩法选项”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 玩法选项

调用红火赛事数据服务的“玩法选项”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/matchoptions`
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
| `serial_no` | string | 必填 | 场次序号 |
| `bet_id` | integer | 必填 | 玩法对应的 bet_id |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/matchoptions" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'serial_no=<value>' \
  --form 'bet_id=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.1.2「玩法选项」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data[{场次序号}]` | `object` | serial_no 场次序号（分组key） |
| `data[{场次序号}].serial_no` | `string` | 场次序号 |
| `data[{场次序号}].match_id` | `string` | 内部比赛ID |
| `data[{场次序号}].match_id2` | `string` | 外部/映射比赛ID |
| `data[{场次序号}].match_time` | `string` | 比赛时间 |
| `data[{场次序号}].bet_time` | `string` | 体彩官方投注截止时间 |
| `data[{场次序号}].bet_date` | `string` | 体彩官方投注日期 |
| `data[{场次序号}].league_name` | `string` | 赛事名称 |
| `data[{场次序号}].host_name_s` | `string` | 主队简称 |
| `data[{场次序号}].guest_name_s` | `string` | 客队简称 |
| `data[{场次序号}].host_name_l` | `string` | 主队全称 |
| `data[{场次序号}].guest_name_l` | `string` | 客队全称 |
| `data[{场次序号}].host_goals` | `string` | 主队全场比分（ -1 通常表示未完场/未知） |
| `data[{场次序号}].guest_goals` | `string` | 客队全场比分（ -1 通常表示未完场/未知） |
| `data[{场次序号}].half_host_goals` | `string` | 主队半场比分（ -1 通常表示未完场/未知） |
| `data[{场次序号}].half_guest_goals` | `string` | 主队半场比分（ -1 通常表示未完场/未知） |
| `data[{场次序号}].sale_status` | `string` | 体彩官方销售状态 1-开售 非1-停售 |
| `data[{场次序号}].is_prize` | `string` | 开奖状态 1-开奖 非1-未开奖 |
| `data[{场次序号}].reversion` | `string` | 是否主客反转(1=反) |
| `data[{场次序号}].neutral_ground` | `string` | 是否中立场（1 中立场，0 非中立） |
| `data[{场次序号}].create_time` | `string` | 记录创建时间 |
| `data[{场次序号}].update_time` | `string` | 记录更新时间 |
| `data[{场次序号}].match_end_time` | `string` | 比赛结束时间 |
| `data[{场次序号}].expect_prize_time` | `string` | 预计开奖时间 |
| `data[{场次序号}].actual_prize_time` | `string` | 实际开奖时间（未开奖时可能为 0000-00-00 00:00:00 ） |
| `data[{场次序号}].event_id` | `string` | 事件/场次唯一标识（数据源生成的hash类ID，用于归并/追踪） |
| `data[{场次序号}].sport_type` | `string` | 运动类型编码（例： 201 ，一般表示足球） |
| `data[{场次序号}].is_disable` | `string` | 是否隐藏(1=隐藏) |
| `data[{场次序号}].is_close` | `string` | 是否停止受注(1=不受注) |
| `data[{场次序号}].is_hot` | `string` | 热门比赛标识(1=热) |
| `data[{场次序号}].stop_prize` | `string` | 是否暂不开奖(1=暂不开奖) |
| `data[{场次序号}].list` | `array`；示例 object | 游戏玩法选项： / SportteryNWDL - 胜平负 / SportteryWDL - 让球胜平负 |
| `data[{场次序号}].list[{玩法代码}].is_single` | `string` | 是否支持单场 1-单关 0-非单关 |
| `data[{场次序号}].list[{玩法代码}].odds` | `string`；示例 object | 体彩官方返奖赔率 / 对应关系详见附录3.2 |
| `data[{场次序号}].list[{玩法代码}].bet_id` | `string` | 该玩法对应的 bet_id（同一场比赛不同玩法 bet_id 不同） |
| `data[{场次序号}].list[{玩法代码}].boundary` | `string` | 让球/分差（让球胜平负等玩法使用；采集时会去掉 + 号，可能为 -1/1/1.5 等） |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
