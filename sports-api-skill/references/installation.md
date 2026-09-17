# 安装与运行环境

本 Skill 遵循 Agent Skills 开放格式。安装时必须复制完整的 `sports-api-skill/` 目录，不能只复制入口 `SKILL.md`，否则总 Skill 无法读取路由表和 49 个接口指南。

## 安装位置

| 宿主 | 用户级目录 | 项目级目录 | 调用方式 |
|---|---|---|---|
| Codex | `${CODEX_HOME:-$HOME/.codex}/skills/sports-api-skill` | 由当前 Codex 版本及项目配置决定 | `$sports-api-skill` 或自然语言 |
| Claude Code | `~/.claude/skills/sports-api-skill` | `.claude/skills/sports-api-skill` | `/sports-api-skill` 或自然语言 |
| GitHub Copilot | `~/.copilot/skills/sports-api-skill` 或 `~/.agents/skills/sports-api-skill` | `.github/skills/sports-api-skill`、`.claude/skills/sports-api-skill` 或 `.agents/skills/sports-api-skill` | 自然语言 |
| 其他兼容 Agent Skills 的客户端 | 客户端声明的用户级 Skill 根目录 | `.agents/skills/sports-api-skill`（如果客户端支持） | 按客户端规则 |

仓库根目录的 `scripts/install.sh` 可完成用户级安装，也可以接收一个明确的 Skill 根目录作为第二个参数。安装完成后，按宿主要求刷新 Skill 索引或开启新会话。

不支持 Agent Skills 的 Agent 不能直接“安装”本目录。此时需要把 `SKILL.md` 作为系统/开发者指令加载，并让 Agent 能读取全部附带文件；或者把赛事接口另行封装成该 Agent 支持的 CLI、MCP Server 或函数工具。

## 凭据

本地运行前，在启动 Agent 的同一进程环境中设置：

```bash
export SPORTS_API_APP_ID='你的合作方ID'
export SPORTS_API_APP_SECRET='你的合作方密钥'
export SPORTS_API_BASE_URL='https://apic.17honghuoyun.com'
```

`.env` 不会被本 Skill 自动加载。桌面应用必须在继承这些变量的环境中启动；云端 Agent 必须在平台的 Secrets 或 Environment Variables 中单独配置。本机 shell 配置不会自动同步到云端。

调用还需要：

- 允许访问 `https://apic.17honghuoyun.com`；
- 如果服务端启用了 IP 白名单，将 Agent 的实际出口 IP 加入允许列表；
- Bash 与 curl。没有这两个程序时，宿主需要提供等价的 HTTPS 和 `multipart/form-data` 客户端。

不要把真实凭据写入仓库、Skill、聊天消息、命令参数或长期日志。

## 快速验证

只检查变量是否存在，不输出变量值：

```bash
test -n "$SPORTS_API_APP_ID" && echo 'SPORTS_API_APP_ID 已配置'
test -n "$SPORTS_API_APP_SECRET" && echo 'SPORTS_API_APP_SECRET 已配置'
```

查询竞彩足球赛程：

```bash
scripts/request.sh /api/v1/matchlist jc_type=jczq
```

返回 JSON 后还要检查业务字段 `errcode`；只有 `0` 表示成功。
