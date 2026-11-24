---
name: sports-api-odds-score-detail
description: 调用赛事数据服务的“指数详情（总进球数、比分、半全场）”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 指数详情（总进球数、比分、半全场）

调用红火赛事数据服务的“指数详情（总进球数、比分、半全场）”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/matchoddsdetail5`
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
| `match_id2` | string | 必填 | 外部/映射比赛 ID |
| `lottery_id` | integer | 必填 | 竞足 90、竞篮 91、足彩 10 |
| `odds_type` | integer | 必填 | 8 总进球、9 半全场、10 比分 |
| `book_maker_id` | integer | 必填 | 公司 ID；1000 表示竞彩官方 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/matchoddsdetail5" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'match_id2=<value>' \
  --form 'lottery_id=<value>' \
  --form 'odds_type=<value>' \
  --form 'book_maker_id=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.3.4「指数详情（总进球数、比分、半全场）」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

示例包含 `oddsAiToBaseBo1`、`oddsAiToBaseBo2` 和 `oddsAiToBaseBo3`。各分支中同名字段按所属对象读取。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.oddsAiToBaseBo1` | `object` | 指数变化数组 |
| `data.oddsAiToBaseBo1.oddDetails` | `array` | 时间序列明细 |
| `data.oddsAiToBaseBo1.oddDetails[].oddsItems` | `array` | 该时间点下的选项列表 |
| `data.oddsAiToBaseBo1.oddDetails[].oddsItems[].change` | `int` | 该选项相对上一时间点的变动方向（1/-1/0） |
| `data.oddsAiToBaseBo1.oddDetails[].oddsItems[].code` | `string`；示例 integer | 玩法项编码：总进球 90030~90037；比分 9005xx/90050/90051/90053；半全场 90040x/90041x/90043x |
| `data.oddsAiToBaseBo1.oddDetails[].oddsItems[].name` | `string` | 玩法项名称（如 0/1/…/7+ 、 1-0 、 胜负 ） |
| `data.oddsAiToBaseBo1.oddDetails[].oddsItems[].odds` | `string` | 赔率 |
| `data.oddsAiToBaseBo1.oddDetails[].bookmakerId` | `string` | 公司机构ID |
| `data.oddsAiToBaseBo1.oddDetails[].handicap` | `string` | 盘口 |
| `data.oddsAiToBaseBo2` | `object` | 指数变化数组2 |
| `data.oddsAiToBaseBo3` | `object` | 指数变化数组3 |
| `data.oddsAiToBaseBo1.bookmakerId` | 示例 string | 第一组指数对应的公司 ID |
| `data.oddsAiToBaseBo2.bookmakerId` | 示例 string | 第二组指数对应的公司 ID |
| `data.oddsAiToBaseBo3.bookmakerId` | 示例 string | 第三组指数对应的公司 ID |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
