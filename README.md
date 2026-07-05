# Stock Assistant - 智能选股桌面应用

[![Tauri](https://img.shields.io/badge/Tauri-Rust-orange)](https://tauri.app)
[![Python](https://img.shields.io/badge/Python-FastAPI-blue)](https://fastapi.tiangolo.com)

Tauri + Rust + Python FastAPI 构建的智能选股桌面应用，目标 UI 水平对标同花顺 / 东方财富 / TradingView 桌面端。

## 功能规划

- **Tauri 桌面壳** — 跨平台原生窗口，低内存占用
- **Rust 后端** — 高性能数据处理
- **Python FastAPI** — AI 预测模型服务
- **金融终端级 UI** — 1400x900 默认窗口，五区域布局
- **深浅色主题** — 长时间盯盘不累眼
- **AI 预测模块** — 为机器学习预测设计的界面结构

## UI 设计

五区域布局:

```
+----------------------------------------------------+
| 顶部菜单栏 (固定，高 56px)                         |
+----------+-----------------------------------------+
| 左侧栏   |                                         |
| 260px    |   主内容区 (自适应)                      |
|          | +------------------+------------------+ |
|          | | 热门板块区       | AI预测区          | |
|          | | Region 4         | Region 5          | |
|          | +------------------+------------------+ |
+----------+-----------------------------------------+
| 底部状态栏 (高 28px)                               |
+----------------------------------------------------+
```

视觉规范:

| 项目 | 值 |
|------|-----|
| 默认窗口 | 1400 x 900 |
| 最小窗口 | 1200 x 800 |
| 主色 | #2563EB (金融蓝) |
| 字体 | Inter + 思源黑体 |
| 深色背景 | #0f172a / #020617 |

## 技术栈

- 桌面框架: Tauri (Rust)
- 前端: HTML + CSS + JavaScript
- 后端: Python FastAPI
- AI 预测: (待集成)

## 项目结构

```
stock-assistant/
  src-tauri/           # Tauri Rust 核心
  python-backend/      # FastAPI AI 服务
  frontend/            # 前端 UI
  run_health_check.py  # 健康检查
```

## 快速开始

```bash
cd python-backend
pip install -r requirements.txt
uvicorn main:app --reload

cd frontend
npm install
npm run dev

cargo tauri dev
```

## 更新日志

### v1.0.0 (2025-12)
- 项目初始化，Tauri + Rust + FastAPI 架构搭建
- 金融终端级 UI 设计定稿
- 五区域布局、深浅色主题

---

*原仓库: gp -> 于 2026-07-05 迁移至 stock-assistant*
