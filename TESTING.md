# Testing Guide

本项目包含三部分的自动化测试：Python 后端、Rust、和前端。

## 快速开始

### 1. Python 后端测试

**前置条件**: Python 3.11+，推荐使用虚拟环境

```bash
# 激活虚拟环境（如有）
# Windows: .\.venv\Scripts\Activate.ps1
# Linux/Mac: source .venv/bin/activate

# 安装测试依赖
pip install -r python-backend/requirements-dev.txt

# 运行测试
pytest -v python-backend
```

**测试位置**: `python-backend/tests/test_health.py`

**说明**: 使用 FastAPI 的 `TestClient` 对 `/health` 端点进行单元测试。

---

### 2. Rust 测试

**前置条件**: Rust toolchain（使用 [rustup](https://rustup.rs/) 安装）

```bash
# Windows: 访问 https://win.rustup.rs 下载并运行 rustup-init.exe
# Linux/Mac: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 运行测试
cd src-tauri/rust_tests
cargo test --verbose
```

**测试位置**: `src-tauri/rust_tests/src/lib.rs`

**说明**: 包含 `add` 函数的基础单元测试（演示用）。

---

### 3. 前端测试（Jest）

**前置条件**: Node.js 18+（使用 [nodejs.org](https://nodejs.org) 安装）

```bash
# 安装前端依赖
cd frontend
npm install

# 运行测试
npm test

# 运行测试并生成覆盖率报告
npm test -- --coverage
```

**测试位置**: `frontend/js/__tests__/api.test.js`

**说明**: 检查 `health` 函数是否正确导出。

---

## 在 CI 中运行所有测试

本项目使用 GitHub Actions 自动运行测试。配置文件位于 `.github/workflows/tests.yml`。

每次 push 或 PR 到 `main` 或 `develop` 分支时，CI 会并行运行：
- Python 测试（Python 3.11, 3.12, 3.13）
- Rust 测试
- 前端测试（Jest with coverage）

## 项目结构

```
.
├── .github/workflows/tests.yml          # GitHub Actions CI 配置
├── python-backend/
│   ├── main.py                          # FastAPI 应用
│   ├── requirements.txt                 # 生产依赖
│   ├── requirements-dev.txt             # 开发 & 测试依赖
│   └── tests/
│       └── test_health.py               # pytest 测试
├── src-tauri/
│   └── rust_tests/
│       ├── Cargo.toml                   # Rust crate 配置
│       └── src/lib.rs                   # Rust 单元测试
└── frontend/
    ├── package.json                     # Node 依赖 & 脚本
    ├── js/
    │   ├── api.js                       # API 模块
    │   └── __tests__/
    │       └── api.test.js              # Jest 测试
    └── index.html
```

## 常见问题

**Q: pytest 找不到模块？**
A: 确保已激活虚拟环境，且在项目根目录运行命令。

**Q: cargo 找不到？**
A: 安装 Rust toolchain（rustup），并确保 `~/.cargo/bin` 在 `PATH` 中。

**Q: npm install 很慢？**
A: 使用 `npm config set registry https://registry.npmmirror.com`（China 镜像）加速。

## 贡献

提交 PR 前请确保所有本地测试通过：

```bash
# Python
pytest -v python-backend

# Rust
cd src-tauri/rust_tests && cargo test --verbose

# 前端
cd frontend && npm test
```

GitHub Actions 会自动验证所有变更。
