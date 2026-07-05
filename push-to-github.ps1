#!/usr/bin/env powershell
# GitHub 推送脚本
# 使用方式: .\push-to-github.ps1

param(
    [string]$GitHubUrl = "",
    [string]$CommitMessage = "初始提交：添加测试框架和 CI 配置"
)

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "GitHub 推送脚本" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

# 检查 Git
Write-Host "`n[1/5] 检查 Git 安装..."
try {
    $gitVersion = & git --version 2>&1
    Write-Host "✅ Git 已安装: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git 未安装或不在 PATH 中" -ForegroundColor Red
    Write-Host "请先安装 Git: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "或使用 winget: winget install Git.Git" -ForegroundColor Yellow
    exit 1
}

# 获取 GitHub URL
if (-not $GitHubUrl) {
    Write-Host "`n[2/5] 输入 GitHub 仓库 URL"
    Write-Host "格式示例: https://github.com/你的用户名/股票助手8.git" -ForegroundColor Gray
    $GitHubUrl = Read-Host "GitHub 仓库 URL"
}

if (-not $GitHubUrl) {
    Write-Host "❌ 未提供 GitHub URL" -ForegroundColor Red
    exit 1
}

Write-Host "✅ GitHub URL: $GitHubUrl" -ForegroundColor Green

# 配置 Git 用户信息
Write-Host "`n[3/5] 配置 Git 用户信息..."
$userName = & git config user.name
$userEmail = & git config user.email

if (-not $userName) {
    $userName = Read-Host "输入你的 GitHub 用户名"
    & git config user.name $userName
}
Write-Host "✅ 用户名: $userName" -ForegroundColor Green

if (-not $userEmail) {
    $userEmail = Read-Host "输入你的 GitHub 邮箱"
    & git config user.email $userEmail
}
Write-Host "✅ 邮箱: $userEmail" -ForegroundColor Green

# 初始化仓库（如果需要）
Write-Host "`n[4/5] 初始化/检查 Git 仓库..."
if (-not (Test-Path .git)) {
    Write-Host "  初始化新仓库..."
    & git init
}

# 检查远程仓库
$remoteExists = & git remote | Select-String origin
if (-not $remoteExists) {
    Write-Host "  添加远程仓库..."
    & git remote add origin $GitHubUrl
} else {
    Write-Host "  远程仓库已存在，检查 URL..."
    $currentUrl = & git remote get-url origin
    if ($currentUrl -ne $GitHubUrl) {
        Write-Host "  更新远程 URL..."
        & git remote set-url origin $GitHubUrl
    }
}
Write-Host "✅ Git 仓库已配置" -ForegroundColor Green

# 添加文件、提交和推送
Write-Host "`n[5/5] 提交并推送到 GitHub..."
Write-Host "  添加所有文件..."
& git add .
Write-Host "  创建提交..."
& git commit -m $CommitMessage
Write-Host "  重命名分支为 main..."
& git branch -M main
Write-Host "  推送到 GitHub..."
& git push -u origin main

Write-Host "`n======================================" -ForegroundColor Green
Write-Host "✅ 推送成功！" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host "`n仓库地址: $GitHubUrl" -ForegroundColor Cyan
Write-Host "GitHub Actions 会自动运行测试。" -ForegroundColor Cyan
Write-Host "访问你的仓库查看 CI 状态：" -ForegroundColor Cyan
$repoUrl = $GitHubUrl -replace '\.git$', ''
Write-Host $repoUrl -ForegroundColor Yellow
