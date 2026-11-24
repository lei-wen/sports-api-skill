---
name: sports-api-player-ability
description: 调用赛事数据服务的“球员能力”接口。适用于查询指定球员的综合能力、能力值或能力指标；不要用于球员统计或其他赛事提供商。
---

# 球员能力

调用红火赛事数据服务的“球员能力”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseplayerability`
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
| `playerId` | integer | 必填 | 球员 ID |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseplayerability" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'playerId=<value>'
```

## 响应处理

成功响应的 `data` 包含球员能力数据；源文档列出 `abilityMetrics` 能力指标数组及 `overall` 综合能力等字段。响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`，只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.9.3「球员能力」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

示例的 `abilityMetrics` 元素用 `key`、`keyEng` 和 `value` 表示能力指标。字段表在该数组下也列出球员 ID、姓名和综合能力，示例将这些球员字段放在 `data` 下。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.abilityMetrics` | `array[object (Value)]` | 各项能力值 |
| `data.abilityMetrics[].overall` | `integer` | 综合能力（字段表列于能力指标下；示例仅在 data 直接返回此字段） |
| `data.abilityMetrics[].playerId` | `integer` | 球员id（字段表列于能力指标下；示例仅在 data 直接返回此字段） |
| `data.abilityMetrics[].playerName` | `string` | 球员名称（字段表列于能力指标下；示例仅在 data 直接返回此字段） |
| `data.overall` | `integer` | 综合能力 |
| `data.playerId` | `integer` | 球员id |
| `data.playerName` | `string` | 球员名称 |
| `data.positionMetrics` | `array[object (Value)]` | 不同位置能力值 |
| `data.positionMetrics[].key` | `string` | 指标名称 |
| `data.positionMetrics[].keyEng` | `string` | 指标名称（英文） |
| `data.positionMetrics[].value` | `string` | 指标值 |
| `data.potential` | `integer` | 潜力 |
| `data.profile` | `array[object (Value)]` | 资料 |
| `data.profile[].key` | `string` | 指标名称 |
| `data.profile[].keyEng` | `string` | 指标名称（英文） |
| `data.profile[].value` | `string` | 指标值 |
| `data.radarList` | `array[object (Value)]` | 雷达图 |
| `data.radarList[].key` | `string` | 指标名称 |
| `data.radarList[].keyEng` | `string` | 指标名称（英文） |
| `data.radarList[].value` | `string` | 指标值 |
| `data.abilityMetrics[].key` | 示例 string | 指标名称 |
| `data.abilityMetrics[].keyEng` | 示例 string | 指标英文名称 |
| `data.abilityMetrics[].value` | 示例 string | 指标值 |

来源：[赛事数据接口说明文档 2.9.3](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
