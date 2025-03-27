# 保存为 configure_rime.ps1
Remove-Item -Path *.gram -ErrorAction SilentlyContinue
Remove-Item -Path rime_ice.schema.custom.yaml -ErrorAction SilentlyContinue

Write-Host "请选择下载方案："
Write-Host "1. 万象通用版（GitHub 官方源）"
Write-Host "2. 现代汉语常用语库（GitHub 官方源）"
Write-Host "3. 万象通用版（镜像加速源）"
Write-Host "4. 现代汉语常用语库（镜像加速源）"
$choice = Read-Host "请输入数字 (1-4)"

$url, $filename = $null

switch ($choice) {
    "1" {
        $url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram"
        $filename = "wanxiang-lts-zh-hans.gram"
    }
    "2" {
        $url = "https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram"
        $filename = "zh-hans-t-huayu-v7-bgw.gram"
    }
    "3" {
        $url = "https://github.moeyy.xyz/https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram"
        $filename = "wanxiang-lts-zh-hans.gram"
    }
    "4" {
        $url = "https://github.moeyy.xyz/https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram"
        $filename = "zh-hans-t-huayu-v7-bgw.gram"
    }
    default {
        Write-Host "无效输入，脚本退出"
        exit 1
    }
}

try {
    Invoke-WebRequest -Uri $url -OutFile $filename -ErrorAction Stop
    Write-Host "下载完成：$filename"
}
catch {
    Write-Host "下载失败，请检查网络连接或URL有效性"
    exit 1
}

@"
patch:
  "grammar/language": $filename
  "grammar/collocation_max_length": 5
  "grammar/collocation_min_length": 2
  "translator/contextual_suggestions": true
  "translator/max_homophones": 7
  "translator/max_homographs": 7
"@ | Set-Content rime_ice.schema.custom.yaml

Write-Host "配置完成！已创建 rime_ice.schema.custom.yaml"