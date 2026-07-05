# Stock Assistant

Tauri + Rust + Python + FastAPI desktop stock assistant template.
目标 UI 水平

类似 同花顺 / 东方财富 / TradingView 桌面端

信息密度高但不乱

深浅色可切换

长时间盯盘不累

为 AI 预测“让位”的界面结构

🧩 一、最终 UI 总体设计（上线级）
1️⃣ 窗口与布局规范（非常重要）
项	数值
默认窗口	1400 × 900
最小窗口	1200 × 800
DPI	自动适配
字体	Inter + 思源黑体
主色	#2563EB（金融蓝）
成功	#16A34A
风险	#DC2626
2️⃣ 五区域最终结构（上线版）
┌──────────────────────────────────────────────┐
│ 顶部菜单栏（固定，高 56px）                 │
├──────────┬───────────────────────────────────┤
│ 左侧栏   │                                   │
│ 260px    │   主内容区（自适应）               │
│          │ ┌──────────────┬────────────────┐ │
│          │ │ 热门板块区   │ AI预测区       │ │
│          │ │ Region 4     │ Region 5        │ │
│          │ └──────────────┴────────────────┘ │
├──────────┴───────────────────────────────────┤
│ 底部状态栏（高 28px）                        │
└──────────────────────────────────────────────┘

🎨 二、UI 视觉体系（直接可用）
2.1 全局 CSS 变量（上线级）
:root {
  --bg-main: #0f172a;
  --bg-panel: #020617;
  --bg-hover: #1e293b;

  --text-main: #e5e7eb;
  --text-sub: #94a3b8;

  --primary: #2563eb;
  --success: #16a34a;
  --danger: #dc2626;
  --warning: #f59e0b;

  --border: #1e293b;
  --radius: 10px;
  --shadow: 0 8px 24px rgba(0,0,0,.35);
}


💡 这是金融类桌面软件的“耐看色域”，不是网页炫技色。

2.2 字体与排版规则
body {
  font-family: Inter, "Source Han Sans SC", system-ui;
  font-size: 14px;
  color: var(--text-main);
  background: var(--bg-main);
}

用途	字号
板块名	15px semibold
股票名	14px
数值	13px monospace
辅助	12px
🧭 三、顶部菜单栏（产品级）
<header class="topbar">
  <div class="logo">🚀 StockAI</div>
  <nav>
    <button class="active">市场</button>
    <button>AI管理</button>
    <button>历史</button>
    <button>设置</button>
  </nav>
  <div class="topbar-right">
    <span class="status online">● 已连接</span>
  </div>
</header>

.topbar {
  height: 56px;
  background: #020617;
  display: flex;
  align-items: center;
  padding: 0 16px;
  border-bottom: 1px solid var(--border);
}


✔ 说明

按钮不是 tab，是“模式切换器”

当前模式高亮

设置 / AI / 历史 会触发 区域 4+5 合并

📚 四、左侧筛选栏（高信息密度）
<aside class="sidebar">
  <section>
    <h4>行业板块</h4>
    <button>人工智能</button>
    <button>新能源</button>
    <button>半导体</button>
  </section>

  <section>
    <h4>技术指标</h4>
    <label><input type="checkbox"> MACD</label>
    <label><input type="checkbox"> RSI</label>
    <label><input type="checkbox"> BOLL</label>
  </section>
</aside>

.sidebar {
  width: 260px;
  background: var(--bg-panel);
  border-right: 1px solid var(--border);
}


✔ 行业 + 指标 始终可见
✔ 设置页 / AI 页 不隐藏左栏（专业软件风格）

📈 五、区域 4：热门板块（金融级表格）
<table class="sector-table">
  <tr>
    <th>板块</th>
    <th>涨幅</th>
    <th>成交额</th>
  </tr>
  <tr>
    <td>人工智能</td>
    <td class="up">+3.21%</td>
    <td>124.3亿</td>
  </tr>
</table>

.sector-table tr:hover {
  background: var(--bg-hover);
}
.up { color: var(--success); }
.down { color: var(--danger); }


✔ 不做大卡片（浪费空间）
✔ 表格才是交易软件正确选择

🤖 六、区域 5：AI 预测（核心卖点）
<div class="ai-list">
  <div class="ai-row">
    <div>
      <strong>宁德时代</strong>
      <span>300750</span>
    </div>
    <div class="predict up">+6.42%</div>
    <div class="confidence">置信度 83%</div>
  </div>
</div>

.ai-row {
  display: grid;
  grid-template-columns: 1fr 80px 90px;
  padding: 10px;
  border-bottom: 1px solid var(--border);
}


✔ 一眼能看到

预测方向

幅度

可信度

⚙️ 七、设置 / AI 管理 / 历史（合并视图）
function showMergedView(type) {
  mergeRegion4And5();
  loadPage(type);
}

设置页布局
[ 数据设置 ]
[ 显示设置 ]
[ 提醒规则 ]

AI 管理页
模型名称 | 准确率 | 状态 | 操作
LSTM     | 63.2%  | 就绪 | 训练

📌 八、这是"能上线"的原因

✔ 信息密度高
✔ 不依赖花哨动画
✔ 长时间使用不累
✔ 可横向扩展
✔ 类专业金融软件认知

---

## 🧪 测试

本项目包含自动化测试框架：

- **Python 后端**: pytest + FastAPI TestClient（`python-backend/tests/test_health.py`）
- **Rust**: Cargo 单元测试（`src-tauri/rust_tests/src/lib.rs`）
- **前端**: Jest（`frontend/js/__tests__/api.test.js`）

### 快速运行所有测试

```bash
# Python
pip install -r python-backend/requirements-dev.txt
pytest -v python-backend

# Rust（需要 rustup）
cd src-tauri/rust_tests && cargo test --verbose

# 前端（需要 Node.js）
cd frontend && npm install && npm test
```

详见 [`TESTING.md`](TESTING.md)。

### CI/CD

本项目使用 GitHub Actions 自动运行所有测试（`.github/workflows/tests.yml`）。每次 push 或 PR 到 `main`/`develop` 分支时会自动触发。

---

## 📝 项目架构

```
stock-assistant/
├── .github/workflows/tests.yml          # GitHub Actions CI
├── python-backend/                      # FastAPI 服务
│   ├── main.py
│   ├── requirements.txt
│   ├── requirements-dev.txt
│   └── tests/
├── src-tauri/
│   └── rust_tests/                      # Rust 测试 crate
├── frontend/                            # 前端应用
│   ├── package.json
│   ├── js/
│   │   ├── api.js
│   │   └── __tests__/
│   └── index.html
└── README.md
```

---

## 🚀 快速开始

1. **Python 后端**: `cd python-backend && python main.py`（需要 uvicorn）
2. **前端**: 在浏览器打开 `frontend/index.html` 或启动本地服务器
3. **Rust**: 编译 `src-tauri/` 或在 `src-tauri/rust_tests/` 运行 `cargo test`

---

## 📄 License

MIT