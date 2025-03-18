#!/bin/bash
     curl -LO https://github.com/boomker/rime-fast-xhup/releases/download/v1.0.0/zh-hans-t-huayu-v7-bgw.gram
     tee rime_ice.schema.custom.yaml >/dev/null <<EOF
     patch:
       "grammar/language": zh-hans-t-huayu-v7-bgw
       "grammar/collocation_max_length": 5
       "grammar/collocation_min_length": 2
       "translator/contextual_suggestions": true
       "translator/max_homophones": 7
       "translator/max_homographs": 7
     EOF