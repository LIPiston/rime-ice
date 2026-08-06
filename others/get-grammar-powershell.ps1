# encoding: utf-8
param(
    [string]$Schema = "rime_ice"
)

$ErrorActionPreference = "Stop"
$CustomFile = "$Schema.custom.yaml"

function Show-ModelMenu {
    Write-Host "请选择要安装的语法模型："
    Write-Host "1. 万象通用版（GitHub 官方源，推荐）"
    Write-Host "2. 现代汉语常用语库 / 华宇（GitHub 官方源）"
    Write-Host "3. 万象通用版（镜像加速源）"
    Write-Host "4. 现代汉语常用语库 / 华宇（镜像加速源）"
}

function Get-ModelChoice {
    Show-ModelMenu
    $choice = Read-Host "请输入数字 (1-4，默认 1)"
    if ([string]::IsNullOrWhiteSpace($choice)) {
        $choice = "1"
    }

    switch ($choice) {
        "1" {
            return [pscustomobject]@{
                Name = "万象通用版"
                Url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram"
                Filename = "wanxiang-lts-zh-hans.gram"
            }
        }
        "2" {
            return [pscustomobject]@{
                Name = "现代汉语常用语库 / 华宇"
                Url = "https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram"
                Filename = "zh-hans-t-huayu-v7-bgw.gram"
            }
        }
        "3" {
            return [pscustomobject]@{
                Name = "万象通用版（镜像）"
                Url = "https://github.moeyy.xyz/https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram"
                Filename = "wanxiang-lts-zh-hans.gram"
            }
        }
        "4" {
            return [pscustomobject]@{
                Name = "现代汉语常用语库 / 华宇（镜像）"
                Url = "https://github.moeyy.xyz/https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram"
                Filename = "zh-hans-t-huayu-v7-bgw.gram"
            }
        }
        default {
            throw "无效输入，脚本退出"
        }
    }
}

function Backup-IfExists {
    param([string]$Path)

    if (Test-Path -LiteralPath $Path) {
        $backup = "$Path.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Copy-Item -LiteralPath $Path -Destination $backup -Force
        Write-Host "已备份现有配置：$backup"
    }
}

$model = Get-ModelChoice
$tmpFile = "$($model.Filename).download"
Remove-Item -LiteralPath $tmpFile -ErrorAction SilentlyContinue

Write-Host "正在下载：$($model.Name)"
Write-Host $model.Url
try {
    Invoke-WebRequest -Uri $model.Url -OutFile $tmpFile -ErrorAction Stop
    Move-Item -LiteralPath $tmpFile -Destination $model.Filename -Force
    Write-Host "下载完成：$($model.Filename)"
}
catch {
    Remove-Item -LiteralPath $tmpFile -ErrorAction SilentlyContinue
    Write-Error "下载失败，请检查网络连接或 URL 有效性。$($_.Exception.Message)"
    exit 1
}

$language = [System.IO.Path]::GetFileNameWithoutExtension($model.Filename)
Backup-IfExists -Path $CustomFile

$yaml = @"
# encoding: utf-8
# 由 others/get-grammar-powershell.ps1 生成。
# 重新运行脚本会先备份旧文件，再覆盖此文件。
patch:
  grammar:
    language: $language
    collocation_max_length: 6
    collocation_min_length: 3
    collocation_penalty: -14
    non_collocation_penalty: -6
    weak_collocation_penalty: -100
    rear_penalty: -20
  translator/contextual_suggestions: false
  translator/max_homophones: 8
  translator/max_homographs: 8
"@

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $CustomFile), $yaml, $utf8NoBom)

Write-Host "已写入：$CustomFile"
Write-Host ""
Write-Host "配置完成。请重新部署 Rime 后生效。"
Write-Host "如需给双拼方案安装，可传入方案名，例如："
Write-Host "  powershell -ExecutionPolicy Bypass -File others/get-grammar-powershell.ps1 double_pinyin_flypy"
