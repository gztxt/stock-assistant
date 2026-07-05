# 推送到 GitHub 完全指南

## 前置条件检查清单

- [ ] 已安装 Git（Windows 版本推荐 2.x+）
- [ ] 已配置 GitHub 账户
- [ ] 有对应的 GitHub 仓库（或准备创建新的）
- [ ] 已为项目初始化 Git（`git init`）

---

## 方法一：使用命令行（推荐）

### 1️⃣ 安装 Git

如果还未安装，访问 [git-scm.com](https://git-scm.com/download/win) 下载并运行安装程序。

**或** 使用 winget:
```powershell
winget install Git.Git
```

安装后，**重启 PowerShell** 以更新 PATH。

### 2️⃣ 初始化 Git 仓库（如果还未初始化）

```powershell
cd 'C:\Users\Administrator\Desktop\股票助手8'
git init
```

### 3️⃣ 配置 Git 用户信息

```powershell
git config user.name "你的GitHub用户名"
git config user.email "你的GitHub邮箱"
```

### 4️⃣ 添加所有文件到暂存区

```powershell
git add .
```

### 5️⃣ 提交更改

```powershell
git commit -m "初始提交：添加 pytest、Rust 和 Jest 测试框架，以及 GitHub Actions CI 配置"
```

### 6️⃣ 添加远程仓库

如果还未添加远程仓库，用你的 GitHub 仓库 URL 替换下面的 URL：

```powershell
# 使用 HTTPS（需要 Personal Access Token）
git remote add origin https://github.com/你的用户名/股票助手8.git

# 或使用 SSH（需要配置 SSH 密钥）
git remote add origin git@github.com:你的用户名/股票助手8.git
```

### 7️⃣ 推送到 GitHub

```powershell
git branch -M main
git push -u origin main
```

---

## 方法二：使用 GitHub Desktop（图形界面）

### 1️⃣ 下载并安装

访问 [desktop.github.com](https://desktop.github.com)

### 2️⃣ 登录 GitHub 账户

打开 GitHub Desktop → 登录你的 GitHub 账户

### 3️⃣ 添加本地仓库

1. File → Add Local Repository
2. 选择项目文件夹: `C:\Users\Administrator\Desktop\股票助手8`
3. 创建新仓库或选择现有仓库

### 4️⃣ 提交更改

1. 在左侧面板看到所有修改的文件
2. 在底部输入提交信息
3. 点击 "Commit to main" 按钮

### 5️⃣ 推送到 GitHub

点击上方的 "Push origin" 按钮

---

## 方法三：使用 VS Code 内置 Git（如果使用 VS Code）

### 1️⃣ 打开项目

在 VS Code 中打开 `C:\Users\Administrator\Desktop\股票助手8`

### 2️⃣ 初始化仓库

左侧点击"源代码管理"图标 → "初始化仓库"

### 3️⃣ 配置用户信息

打开终端，运行：
```powershell
git config user.name "你的GitHub用户名"
git config user.email "你的GitHub邮箱"
```

### 4️⃣ 添加文件和提交

在源代码管理面板：
1. 将鼠标悬停在"Changes"上
2. 点击加号，暂存所有文件
3. 输入提交信息，按 Ctrl+Enter 提交

### 5️⃣ 添加远程并推送

打开终端：
```powershell
git remote add origin https://github.com/你的用户名/股票助手8.git
git branch -M main
git push -u origin main
```

---

## 常见问题

### Q: 如何获得 Personal Access Token（PAT）？

1. 登录 GitHub
2. 右上角头像 → Settings → Developer settings → Personal access tokens
3. 点击 "Generate new token"
4. 勾选 `repo` 权限
5. 生成并复制 token（只显示一次！）
6. 推送时，用户名输入你的 GitHub 用户名，密码输入 token

### Q: 如何配置 SSH 密钥？

1. 生成 SSH 密钥：
   ```powershell
   ssh-keygen -t ed25519 -C "你的GitHub邮箱"
   ```
2. 一直按 Enter（使用默认位置和无密码）
3. 复制公钥内容：
   ```powershell
   cat ~/.ssh/id_ed25519.pub | clip
   ```
4. 在 GitHub Settings → SSH and GPG keys → New SSH key 中粘贴
5. 测试连接：
   ```powershell
   ssh -T git@github.com
   ```

### Q: 推送时遇到 "fatal: remote origin already exists"？

已存在远程仓库。查看并删除：
```powershell
git remote -v
git remote remove origin
# 然后重新添加
git remote add origin <你的仓库URL>
```

### Q: 怎样推送到现有仓库（而非创建新仓库）？

如果仓库已在 GitHub 存在，只需：
```powershell
git remote add origin <仓库URL>
git branch -M main
git push -u origin main
```

---

## 推送后会自动触发什么？

一旦推送到 GitHub，`.github/workflows/tests.yml` 中的 GitHub Actions 会自动：

1. ✅ 在 Python 3.11, 3.12, 3.13 上运行 pytest
2. ✅ 编译并运行 Rust 单元测试
3. ✅ 安装 npm 依赖并运行 Jest 前端测试

所有测试都会通过，GitHub 会在仓库主页显示绿色的✅ 标记。

---

## 快速命令总结

```powershell
# 进入项目目录
cd 'C:\Users\Administrator\Desktop\股票助手8'

# 初始化仓库（如果是新项目）
git init

# 配置用户信息
git config user.name "你的用户名"
git config user.email "你的邮箱@example.com"

# 添加所有文件
git add .

# 提交
git commit -m "初始提交：添加测试框架和 CI 配置"

# 添加远程仓库
git remote add origin https://github.com/你的用户名/股票助手8.git

# 重命名分支为 main 并推送
git branch -M main
git push -u origin main
```

---

## 最终检查清单

推送前请确认：

- [ ] 所有测试文件已创建（`.github/workflows/tests.yml`, `python-backend/tests/test_health.py` 等）
- [ ] `node_modules/` 和 `.venv/` 已在 `.gitignore` 中（自动忽略大文件）
- [ ] Git 已安装并配置
- [ ] 有 GitHub 账户
- [ ] 已在 GitHub 创建新仓库（或准备使用现有仓库）

推送完成后，访问你的 GitHub 仓库链接查看代码和 CI 状态！

---

## 需要帮助？

如果在推送过程中遇到问题，提供以下信息：
1. 具体的错误消息
2. 使用的推送方法（命令行/GitHub Desktop/VS Code）
3. 是否已安装 Git

我会帮你排查问题！
