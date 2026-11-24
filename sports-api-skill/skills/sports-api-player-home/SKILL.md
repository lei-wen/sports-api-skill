---
name: sports-api-player-home
description: 调用赛事数据服务的“球员主页”接口。适用于用户需要查询或集成该接口时；不要用于球队主页或其他赛事提供商。
---

# 球员主页

调用红火赛事数据服务的“球员主页”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseplayerhome`
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
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseplayerhome" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'playerId=<value>'
```

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.9.1「球员主页」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.age` | `integer` | 年龄 |
| `data.avatar` | `string` | 头像 |
| `data.foot` | `string` | 惯用脚 |
| `data.height` | `integer` | 身高(cm) |
| `data.nameChs` | `string` | 中文名称 |
| `data.nameEng` | `string` | 英文名称 |
| `data.nationality` | `string` | 国籍 |
| `data.playerId` | `integer` | 球员id |
| `data.playerWorth` | `string` | 身价 |
| `data.position` | `string` | 位置 |
| `data.regionLogo` | `string` | 国家或区域logo |
| `data.shirtNumber` | `string` | 球衣号码 |
| `data.teamName` | `string` | 所在球队 |
| `data.weight` | `integer` | 体重(kg) |

来源：[赛事数据接口说明文档 2.9.1](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
