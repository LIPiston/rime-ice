iwr https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram -OutFile wanxiang-lts-zh-hans.gram
    @"
    patch:
      ""grammar/language"": zh-hans-t-huayu-v7-bgw
      ""grammar/collocation_max_length"": 5
      ""grammar/collocation_min_length"": 2
      ""translator/contextual_suggestions"": true
      ""translator/max_homophones"": 7
      ""translator/max_homographs"": 7
"@ | Out-File rime_ice.schema.custom.yaml -Encoding utf8