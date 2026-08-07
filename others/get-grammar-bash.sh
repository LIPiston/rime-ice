#!/usr/bin/env bash
set -euo pipefail

SCHEMA="${1:-rime_ice}"
CUSTOM_FILE="${SCHEMA}.custom.yaml"

MODEL_NAME=""
URL=""
FILENAME=""
ENABLE_CORRECTION="false"

print_menu() {
  cat <<'MENU'
请选择要安装的语法模型：
1. 万象通用版（GitHub 官方源，推荐）
2. 现代汉语常用语库 / 华宇（GitHub 官方源）
3. 万象通用版（镜像加速源）
4. 现代汉语常用语库 / 华宇（镜像加速源）
MENU
}

choose_model() {
  print_menu
  if ! read -r -p "请输入数字 (1-4，默认 1): " choice </dev/tty; then
    echo "无法读取终端输入。请在交互式终端中运行脚本。" >&2
    exit 1
  fi
  choice="${choice:-1}"

  case "$choice" in
    1)
      MODEL_NAME="万象通用版"
      URL="https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram"
      FILENAME="wanxiang-lts-zh-hans.gram"
      ;;
    2)
      MODEL_NAME="现代汉语常用语库 / 华宇"
      URL="https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram"
      FILENAME="zh-hans-t-huayu-v7-bgw.gram"
      ;;
    3)
      MODEL_NAME="万象通用版（镜像）"
      URL="https://github.moeyy.xyz/https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram"
      FILENAME="wanxiang-lts-zh-hans.gram"
      ;;
    4)
      MODEL_NAME="现代汉语常用语库 / 华宇（镜像）"
      URL="https://github.moeyy.xyz/https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram"
      FILENAME="zh-hans-t-huayu-v7-bgw.gram"
      ;;
    *)
      echo "无效输入，脚本退出" >&2
      exit 1
      ;;
  esac
}

choose_correction() {
  if ! read -r -p "是否启用拼音纠错（如 ign → ing，Fcitx5-Android 用户建议开启）？[y/N]: " enable_correction </dev/tty; then
    echo "无法读取终端输入。请在交互式终端中运行脚本。" >&2
    exit 1
  fi
  case "${enable_correction:-N}" in
    y|Y|yes|YES|Yes)
      ENABLE_CORRECTION="true"
      ;;
    n|N|no|NO|No)
      ENABLE_CORRECTION="false"
      ;;
    *)
      echo "无效输入，脚本退出" >&2
      exit 1
      ;;
  esac
}

backup_if_exists() {
  local file="$1"
  if [[ -f "$file" ]]; then
    local backup="${file}.bak.$(date +%Y%m%d%H%M%S)"
    cp "$file" "$backup"
    echo "已备份现有配置：$backup"
  fi
}

download_model() {
  local tmp_file="${FILENAME}.download"
  rm -f "$tmp_file"
  echo "正在下载：$MODEL_NAME"
  echo "$URL"
  if ! curl -L -f --retry 3 --retry-delay 2 -o "$tmp_file" "$URL"; then
    rm -f "$tmp_file"
    echo "下载失败，请检查网络连接或 URL 有效性" >&2
    exit 1
  fi
  mv -f "$tmp_file" "$FILENAME"
  echo "下载完成：$FILENAME"
}

write_custom_yaml() {
  local language="${FILENAME%.gram}"
  backup_if_exists "$CUSTOM_FILE"

  cat > "$CUSTOM_FILE" <<EOF
# encoding: utf-8
# 由 others/get-grammar-bash.sh 生成。
# 重新运行脚本会先备份旧文件，再覆盖此文件。
patch:
EOF

  if [[ "$ENABLE_CORRECTION" == "true" ]]; then
    cat >> "$CUSTOM_FILE" <<EOF
  # 启用拼音纠错（如 ign → ing），Fcitx5-Android 用户建议保持 true
  "translator/enable_correction": true
EOF
  fi

  cat >> "$CUSTOM_FILE" <<EOF
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
EOF

  echo "已写入：$CUSTOM_FILE"
}

choose_model
choose_correction
download_model
write_custom_yaml

cat <<EOF

配置完成。请重新部署 Rime 后生效。
如需给双拼方案安装，可传入方案名，例如：
  bash others/get-grammar-bash.sh double_pinyin_flypy
EOF
