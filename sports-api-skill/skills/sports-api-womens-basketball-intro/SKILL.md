---
name: sports-api-womens-basketball-intro
description: 调用赛事数据服务的“女篮世界杯赛事资料”接口。适用于用户需要查询或集成该接口时；不要用于其他赛事提供商。
---

# 女篮世界杯赛事资料

调用红火赛事数据服务的“女篮世界杯赛事资料”接口。

## Endpoint

- 方法：`POST`
- 路径：`/api/v1/basetournamentbball`
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
| `tournamentId` | integer | 必填 | 赛事 ID；女篮世界杯为 2351 |

## 调用模板

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/basetournamentbball" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'tournamentId=<value>'
```

数组参数的具体编码方式应遵循调用方 HTTP 客户端和服务端约定；若服务端拒绝，先对照源文档示例，不要静默改成 JSON 请求体。

## 响应处理

响应通用结构为 `{"errcode": 0, "msg": "success", "data": ...}`。只有 `errcode` 为 `0` 才视为业务成功。常见错误：`10001` 参数缺失或无效；`10002` 认证失败；`10003` 无权限或出口 IP 未放行。

### 响应字段映射

对应《赛事数据接口说明文档》2.7.2「赛事资料」。类型沿用字段表；有明确差异时同时标注示例类型。路径中的 `[]` 表示数组元素，`[{…}]` 表示动态键。

| 响应字段路径 | 文档类型 | 字段说明 |
|---|---|---|
| `data` | 示例 object | 接口业务数据 |
| `data.backgroundColor` | `string`；示例可为 null | 背景颜色 |
| `data.createTime` | `string` | 创建时间 |
| `data.crewGender` | `integer`；示例可为 null | 参赛者性别 |
| `data.crewType` | `integer`；示例可为 null | 参赛者类型 |
| `data.crewYouth` | `integer`；示例可为 null | 参赛者是否是青年 |
| `data.descChs` | `string`；示例可为 null | 中文描述 |
| `data.descEng` | `string`；示例可为 null | 英文描述 |
| `data.enableState` | `integer` | 启用状态 |
| `data.id` | `integer` | 唯一编号 |
| `data.iocCode` | `string`；示例可为 null | 奥林匹克 |
| `data.isoCode` | `string`；示例可为 null | 国际标准 |
| `data.logo` | `string` | logo图片 |
| `data.nameChs` | `string` | 中文全称 |
| `data.nameChsAbbr` | `string` | 中文简称 |
| `data.nameEng` | `string` | 英文全称 |
| `data.nameEngAbbr` | `string` | 英文简称 |
| `data.operateState` | `integer` | 维护状态 |
| `data.operateTime` | `string`；示例可为 null | 操作时间 |
| `data.regionId` | `integer` | 区域 |
| `data.regionName` | `string`；示例可为 null | 区域名称 |
| `data.signature` | `string`；示例可为 null | 签名编号 |
| `data.source` | `integer` | 数据来源 |
| `data.sportId` | `integer` | 运动 |
| `data.sportName` | `string` | 运动名称 |
| `data.textColor` | `string`；示例可为 null | 文字颜色 |
| `data.tournamentLevel` | `integer`；示例可为 null | 赛事级别 |
| `data.tournamentSort` | `integer`；示例可为 null | 赛事排序 |
| `data.tournamentType` | `integer` | 赛事类型 |
| `data.updateTime` | `string` | 更新时间 |
| `data.website` | `string`；示例可为 null | 官方网址 |

来源：[https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)
