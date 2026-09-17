---
name: sports-api-player-stats
description: 调用赛事数据服务的“球员统计数据”接口。适用于查询指定球员的统计或分析数据；不要用于球员能力或其他赛事提供商。
---

# 球员统计数据

调用红火赛事数据服务的“球员统计数据”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/baseplayeranaly`
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
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/baseplayeranaly" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'playerId=<value>'
```

## 响应处理

成功响应的 `data` 包含杯赛等统计数据；源文档列出 `cup` 数组及 `aerialAvg` 场均争顶等字段。响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`，只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

来源：[赛事数据接口说明文档 2.9.5](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
