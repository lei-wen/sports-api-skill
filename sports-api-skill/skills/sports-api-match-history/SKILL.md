---
name: sports-api-match-history
description: 调用赛事数据服务的“战绩”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 战绩

调用红火赛事数据服务的“战绩”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/soccerMatchDetailHistoryV1`
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
| `lottery_id` | integer | 必填 | 竞足类型为 90 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/soccerMatchDetailHistoryV1" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'match_id2=<value>' \
  --form 'lottery_id=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.2.1「战绩」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.historyMatches` | `array`；示例 object | 两队历史交锋 |
| `data.awayHistoryMatches` | `array`；示例 object | 客队历史战绩 |
| `data.homeHistoryMatches` | `array`；示例 object | 主队历史战绩 |
| `data.hxStats` | `object` | 主队近10场战绩 |
| `data.axStats` | `object` | 客队近10场战绩 |
| `data.hxStrongStats` | `object` | 主队对阵强队战绩 |
| `data.axStrongStats` | `object` | 客队对阵强队战绩 |
| `data.hxWeakStats` | `object` | 主队对阵弱队战绩 |
| `data.axWeakStats` | `object` | 客队对阵弱队战绩 |
| `data.hhxStats` | `object` | 主队主场战绩 |
| `data.aaxStats` | `object` | 客队客场战绩 |
| `data.homeRecentlyMatches` | `array`；示例 object | 主队近期赛程 |
| `data.awayRecentlyMatches` | `array`；示例 object | 客队近期赛程 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
