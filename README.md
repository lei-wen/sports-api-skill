# 红火体育赛事数据 Skill

`sports-api-skill` 是红火体育赛事数据接口的统一 Codex Skill。它根据用户的自然语言意图，在 44 个子 Skill 中选择最匹配的接口，检查必填参数，在参数不足或意图有歧义时先向用户提问，然后调用对应 API。

仓库中的 Skill 可以整体安装；无需逐个安装 44 个子 Skill。

接口说明来源：[赛事数据接口说明文档](https://jnjr8fzspd.feishu.cn/wiki/KugUwOiMziGWqQkNPngcttsTnoe)。源文档当前标记为草稿，本仓库保留其参数命名和大小写。

## 能力范围

| 分组 | 能力 |
|---|---|
| 赛事数据 | 竞猜赛程、玩法选项、赛果开奖、按比赛 ID 查询赛果 |
| 比赛详情 | 战绩、阵容、排名、直播、别名与翻译 |
| 指数 | 胜平负、让球、凯利、总进球、比分、半全场及指数详情 |
| 情报内参 | 密报、内参、选号分布、交易数据对比 |
| 分析预测 | 专家推荐、推荐详情、牛单推荐、牛单详情 |
| 世界杯 | 赛季、赛事介绍、近期赛程、晋级图、积分、赛程、球队榜、球员榜 |
| 女篮世界杯 | 赛季、赛事资料、近期赛程、晋级图、积分、赛程、球队榜、球员榜 |
| 球队资料库 | 球队赛程、转会、资料、球员、主页、统计、转会年份 |

完整意图路由见 [`sports-api-skill/references/routes.md`](sports-api-skill/references/routes.md)。每个接口的 URL、参数类型、必填规则、枚举值和 curl 模板位于对应的 [`sports-api-skill/skills/`](sports-api-skill/skills/) 子目录。

## 让 Agent 自动安装

在已提供 `$skill-installer` 的 Codex 中发送：

```text
使用 $skill-installer 从 GitHub 仓库 lei-wen/sports-api-skill 的 master 分支安装路径 sports-api-skill。
```

安装器应执行等价于以下参数的安装：

```text
--repo lei-wen/sports-api-skill --ref master --path sports-api-skill
```

它会安装到：

```text
${CODEX_HOME:-$HOME/.codex}/skills/sports-api-skill
```

安装完成后，新建一个 Codex 任务或重启 Codex，使技能索引刷新。

### 手动安装

适用于尚未安装同名 Skill 的环境：

```bash
git clone --depth 1 --branch master \
  https://github.com/lei-wen/sports-api-skill.git

mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R sports-api-skill/sports-api-skill \
  "${CODEX_HOME:-$HOME/.codex}/skills/sports-api-skill"
```

验证总 Skill 和 44 个子 Skill：

```bash
test -f "${CODEX_HOME:-$HOME/.codex}/skills/sports-api-skill/SKILL.md"
find "${CODEX_HOME:-$HOME/.codex}/skills/sports-api-skill/skills" \
  -mindepth 1 -maxdepth 1 -type d | wc -l
```

预期目录数量为 `44`。如果目标目录已经存在，先备份现有配置，再由使用者明确决定是否更新；安装脚本不应擅自覆盖。

## 请求头与本地凭据

所有已定义接口都使用以下请求头：

| 环境变量 | HTTP 请求头 | 是否必填 | 说明 |
|---|---|---|---|
| `SPORTS_API_APP_ID` | `app-id` | 是 | 合作方 ID |
| `SPORTS_API_APP_SECRET` | `app-secret` | 是 | 合作方密钥 |
| `SPORTS_API_BASE_URL` | — | 否 | API 基础地址；默认使用生产环境 |

生产环境：

```text
https://apic.17honghuoyun.com
```

推荐把变量配置在本机 shell 环境中，不要写入 Skill 或 Git 仓库：

```bash
export SPORTS_API_APP_ID='你的合作方ID'
export SPORTS_API_APP_SECRET='你的合作方密钥'
export SPORTS_API_BASE_URL='https://apic.17honghuoyun.com'
```

macOS 使用 zsh 时，可将配置加入 `~/.zprofile`，然后彻底退出并重新启动 Codex。不要把真实密钥发到聊天中。

只验证变量是否存在而不显示内容：

```bash
test -n "$SPORTS_API_APP_ID" && echo 'SPORTS_API_APP_ID 已配置'
test -n "$SPORTS_API_APP_SECRET" && echo 'SPORTS_API_APP_SECRET 已配置'
```

仓库提供 [`.env.example`](.env.example) 作为变量名称参考，但 Skill 不会自动加载 `.env`。运行 Codex 的进程必须实际继承这些环境变量。

## 请求格式

当前文档中的已定义接口均使用：

- HTTP 方法：`POST`
- 请求体：`multipart/form-data`
- 参数传递：curl 使用 `--form`

示例——查询竞彩足球赛程：

```bash
curl --fail-with-body --request POST \
  "${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}/api/v1/matchlist" \
  --header "app-id: $SPORTS_API_APP_ID" \
  --header "app-secret: $SPORTS_API_APP_SECRET" \
  --form 'jc_type=jczq'
```

`jc_type` 可选值：

| 值 | 含义 |
|---|---|
| `jczq` | 竞彩足球 |
| `basket` | 竞彩篮球 |
| `ToTo` | 传统足彩 14 场 |
| `NineToTo` | 传统足彩任选 9 |

其他接口的请求参数不要凭接口名称猜测。Agent 应先读取所选子 Skill 的 `SKILL.md`，再检查必填项和枚举值。例如：

- 比赛详情通常需要 `match_id2` 和 `lottery_id`。
- 球队资料通常需要 `teamId`，部分接口还需要 `seasonId`。
- 世界杯接口可能需要 `tournamentId` 或 `seasonId`。
- 指数详情还需要 `odds_type` 和 `book_maker_id`。

## 响应与错误码

通用响应结构：

```json
{
  "errcode": 0,
  "msg": "success",
  "data": {}
}
```

只有 `errcode` 为 `0` 才表示业务成功。

| 错误码 | 含义 | 建议 |
|---|---|---|
| `10001` | 参数缺失或无效 | 检查子 Skill 中的参数名、类型和必填规则 |
| `10002` | 认证失败 | 检查 `SPORTS_API_APP_ID` 与 `SPORTS_API_APP_SECRET` |
| `10003` | 无权限访问 | 检查出口 IP 是否已加入允许列表 |

## 使用方式

统一从总 Skill 调用：

```text
使用 $sports-api-skill 查询竞彩足球赛程。
```

```text
使用 $sports-api-skill 查询 teamId=123 的球队资料。
```

```text
使用 $sports-api-skill 查询比赛 2802500 的历史战绩，竞彩足球。
```

当“赛程”“详情”“榜单”或“赛果”等意图不唯一时，总 Skill 会列出候选能力。缺少必填参数时，它会集中补问，而不是猜测 ID 或参数。

## 仓库结构

```text
sports-api-skill/
├── README.md
├── LICENSE
├── .env.example
└── sports-api-skill/
    ├── SKILL.md
    ├── agents/openai.yaml
    ├── references/routes.md
    └── skills/
        └── 44 个接口子 Skill/
```

## 已知文档缺口

源接口文档中的“牛单推荐”和“牛单详情”只有章节标题，没有请求 URL 或参数。因此相应子 Skill 只负责报告文档缺口，不会猜测接口或复用专家推荐接口。

## 安全约定

- 仓库和 Skill 不包含真实 `app-id`、`app-secret` 或接口响应数据。
- Agent 不应回显凭据，也不应把凭据写入命令、日志、生成文件或版本控制。
- 调用接口前先检查参数；调用后同时检查 HTTP 状态和业务 `errcode`。
- 原始接口说明为草稿，接口更新后应同步修改相应子 Skill。

## License

[Apache License 2.0](LICENSE)
