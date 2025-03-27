#!/bin/bash
    curl -LO https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram
    tee rime_ice.schema.custom.yaml >/dev/null <<EOF
    patch:
      "grammar/language": wanxiang-lts-zh-hans.gram
      "grammar/collocation_max_length": 5
      "grammar/collocation_min_length": 2
      "translator/contextual_suggestions": true
      "translator/max_homophones": 7
      "translator/max_homographs": 7
EOF