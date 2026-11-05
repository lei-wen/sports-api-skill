---
name: sports-api-match-prize-by-id
description: 调用赛事数据服务的“赛果开奖（按比赛ID查询）”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 赛果开奖（按比赛ID查询）

调用红火赛事数据服务的“赛果开奖（按比赛ID查询）”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/matchprizelistbyid`
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
| `jc_type` | string | 必填 | jczq 或 basket |
| `matchid2_list` | array | 必填 | 比赛 ID 列表；使用竞猜赛程返回的 match_id2 |

## 调用模板

从总 Skill 根目录执行。每个比赛 ID 传一个 `matchid2_list[]` 表单字段，单个 ID 也保留方括号。按参数表同时传入 `jc_type`。

```bash
scripts/request.sh /api/v1/matchprizelistbyid jc_type=jczq \
  'matchid2_list[]=2589463' 'matchid2_list[]=2681389'
```

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
