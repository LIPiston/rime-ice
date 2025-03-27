#!/bin/bash
# 保存为 configure_rime.sh
rm -f *.gram rime_ice.schema.custom.yaml

echo "请选择下载方案："
echo "1. 万象通用版（GitHub 官方源）"
echo "2. 现代汉语常用语库（GitHub 官方源）"
echo "3. 万象通用版（镜像加速源）"
echo "4. 现代汉语常用语库（镜像加速源）"
read -p "请输入数字 (1-4): " choice

case $choice in
    1)
        url="https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram"
        filename="wanxiang-lts-zh-hans.gram"
        ;;
    2)
        url="https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram"
        filename="zh-hans-t-huayu-v7-bgw.gram"
        ;;
    3)
        url="https://github.moeyy.xyz/https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram"
        filename="wanxiang-lts-zh-hans.gram"
        ;;
    4)
        url="https://github.moeyy.xyz/https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram"
        filename="zh-hans-t-huayu-v7-bgw.gram"
        ;;
    *)
        echo "无效输入，脚本退出"
        exit 1
        ;;
esac

if ! curl -L -f -o "$filename" "$url"; then
    echo "下载失败，请检查网络连接或URL有效性"
    exit 1
fi
echo "下载完成：$filename"

cat > rime_ice.schema.custom.yaml <<EOF
patch:
  "grammar/language": $filename
  "grammar/collocation_max_length": 5
  "grammar/collocation_min_length": 2
  "translator/contextual_suggestions": true
  "translator/max_homophones": 7
  "translator/max_homographs": 7
EOF

echo "配置完成！已创建 rime_ice.schema.custom.yaml"