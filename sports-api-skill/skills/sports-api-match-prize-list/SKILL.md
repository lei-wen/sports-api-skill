---
name: sports-api-match-prize-list
description: 调用赛事数据服务的“赛果开奖”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 赛果开奖

调用红火赛事数据服务的“赛果开奖”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/matchprizelist`
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
| `jc_type` | string | 必填 | jczq、basket、ToTo 或 NineToTo |
| `date_list` | array | 条件必填 | 竞彩足球/篮球时传比赛日期列表，例如 2026-04-27 |
| `lottery_no` | string | 条件必填 | 传统足彩时传期次号，例如 26078 |

## 调用模板

从总 Skill 根目录执行，按彩种选择对应参数。

```bash
scripts/request.sh /api/v1/matchprizelist jc_type=jczq 'date_list[]=2026-04-27'
scripts/request.sh /api/v1/matchprizelist jc_type=ToTo lottery_no=26075
```

竞彩足球和竞彩篮球每个日期传一个 `date_list[]` 表单字段。传统足彩仅传对应的 `lottery_no`。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
