---
name: sports-api-player-games
description: 调用赛事数据服务的“球员赛程”接口。适用于查询指定球员的赛程、比赛记录或继续翻页；不要用于球队赛程或其他赛事提供商。
---

# 球员赛程

调用红火赛事数据服务的“球员赛程”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseplayergame`
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
| `pageSize` | integer | 选填 | 每页数量，默认 `10` |
| `id` | string | 选填 | 数据 ID；第一次请求不传，后续翻页传上次返回结果的 `id` |

## 调用模板

首次请求只发送 `playerId`，用户指定分页大小时再添加 `pageSize`；继续翻页时添加上次响应返回的 `id`：

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseplayergame" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'playerId=<value>' \
  --form 'pageSize=<value>' \
  --form 'id=<value>'
```

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

来源：[赛事数据接口说明文档 2.9.2](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
