# 雾凇拼音

[![License: GPL 3.0](https://img.shields.io/badge/License-GPL--3.0--only-34ad9b)](https://www.gnu.org/licenses/gpl-3.0.txt)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/LIPiston/rime-ice/NightlyBuildWeekly.yml)](https://github.com/LIPiston/rime-ice/actions/workflows/NightlyBuildWeekly.yml)
![GitHub Repo stars](https://img.shields.io/github/stars/LIPiston/rime-ice)


![demo](./others/demo.webp)

功能齐全，词库体验良好，长期更新修订。修改自LIPiston

<br>

[Rime Input Method Engine / 中州韵输入法引擎](https://rime.im/) 是一个跨平台的输入法算法框架。

这里是 Rime 的一份配置仓库，用户需要下载各平台对应的前端，并将此配置应用到配置目录。

雾凇拼音提供了一套开箱即用的完整配置，包含输入方案（全拼、常见双拼）、长期维护的开源词库及各项扩展功能。

详细介绍：[Rime 配置：雾凇拼音](https://dvel.me/posts/rime-ice/)

[常见问题](https://github.com/iDvel/rime-ice/issues/133)

[更新日志](./others/CHANGELOG.md)

<br>

## 基本套路

- 简体 | 全拼 | 双拼
- 主要功能
    -   轻量的英文输入，支持中英混输
    -   [优化英文输入体验](https://dvel.me/posts/make-rime-en-better/)
    -   拆字反查（<kbd>uU</kbd>+拼音），拆字辅码（拼音+<kbd>`</kbd>+拆字辅码）
    -   自整理的 Emoji
    -   以词定字（左右中括号：<kbd>[</kbd>、<kbd>]</kbd>）
    -   长词优先
    -   Unicode（<kbd>U</kbd>+Unicode 码位）
    -   数字、人民币大写（<kbd>R</kbd>+数字）
    -   日期、时间、星期（详见方案 `/date_translator` 节点）
    -   农历（转写：<kbd>N</kbd>+八位数字；获取当前农历：全拼<kbd>nl</kbd>，双拼<kbd>lunar</kbd>）
    -   简易计算器（<kbd>cC</kbd>+算式）
    -   常见错音错字提示
    -   置顶候选项（详见方案 `/pin_cand_filter` 节点）
    -   所有标点符号直接上屏
    -   特殊符号、字符输入（全拼<kbd>v</kbd>+首字母缩写；双拼<kbd>V</kbd>+首字母缩写）
    -   拼音纠错（模糊音）
    -   更多默认未启用的功能请参考 `lua/` 及方案注释
    -   默认翻页键是 `-` `=`
- 简体字表、词库
    -   [通用规范汉字表](https://github.com/iDvel/The-Table-of-General-Standard-Chinese-Characters)（by 中华人民共和国教育部）8K 常用汉字
    -   [Unihan 字库](https://www.unicode.org/Public/)（by Unicode lnc | [UNICODE LICENSE V3](https://www.unicode.org/license.txt)）40K 大字库， **默认未启用**
    -   [现代汉语常用词表](https://zh.wikipedia.org/wiki/%E7%8E%B0%E4%BB%A3%E6%B1%89%E8%AF%AD%E5%B8%B8%E7%94%A8%E8%AF%8D%E8%A1%A8)（by 中国国家语言文字工作委员会）
    -   [华宇野风词库](http://bbs.pinyin.thunisoft.com/forum.php?mod=viewthread&tid=30049)（by 野风）
    -   [简化字八股文](https://github.com/rime/rime-essay-simp)（by rime | [LGPL](https://github.com/rime/rime-essay-simp/blob/master/LICENSE)）
    -   [清华大学开源词库](https://github.com/thunlp/THUOCL)（by THUNLP | [MIT](https://github.com/thunlp/THUOCL/blob/master/LICENSE)）
    -   [腾讯词向量](https://ai.tencent.com/ailab/nlp/en/download.html)（@Huandeep [整理](https://github.com/iDvel/rime-ice/issues/24) | by Tencent AI Lab | [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)）
    - 一大坨搜狗细胞词库（从 rime-frost 里面掏过来的）
- 词库修订
    - 校对大量异形词、错别字、错误注音
    - 全词库完成注音
    - 同义多音字注音
    - 参考
      -   《现代汉语词典》
      -   《同义词词林》
      -   《新华成语大词典》
      -   [校对标准论坛](http://www.jiaodui.com/bbs/)
- Rime、Squirrel、Weasel 常用配置项的详尽注释

<br>

## 长期维护词库

因为没有找到一份比较好的词库，干脆自己维护一个。综合了几个不错的词库，精心调教了很多。

主要维护的词库：
LIPiston：主要有这些词库

``` txt
├── cn_dicts
│   ├── 41448.dict.yaml
│   ├── 8105.dict.yaml
│   ├── base.dict.yaml
│   ├── ext.dict.yaml
│   ├── others.dict.yaml
│   └── tencent.dict.yaml
├── cn_dicts_cell
│   ├── animal.dict.yaml
│   ├── chess2.dict.yaml
│   ├── chess.dict.yaml
│   ├── composite.dict.yaml
│   ├── computer.dict.yaml
│   ├── exthot.dict.yaml
│   ├── food.dict.yaml
│   ├── game.dict.yaml
│   ├── geography.dict.yaml
│   ├── history.dict.yaml
│   ├── hot_words.dict.yaml
│   ├── idiom.dict.yaml
│   ├── industry_product.dict.yaml
│   ├── inputmethod.dict.yaml
│   ├── literature.dict.yaml
│   ├── media.dict.yaml
│   ├── medication.dict.yaml
│   ├── music.dict.yaml
│   ├── name2.dict.yaml
│   ├── name.dict.yaml
│   ├── place.dict.yaml
│   ├── shulihua.dict.yaml
│   └── sport.dict.yaml
└── en_dicts
    ├── cn_en_abc.txt
    ├── cn_en_double_pinyin.txt
    ├── cn_en_flypy.txt
    ├── cn_en_mspy.txt
    ├── cn_en_sogou.txt
    ├── cn_en.txt
    ├── cn_en_ziguang.txt
    ├── en.dict.yaml
    └── en_ext.dict.yaml

```

维护内容主要是异形词、错别字的校对，错误注音的修正，缺失的常用词汇的增添，词频的调整。

欢迎在词库方面提 issue [#666](https://github.com/iDvel/rime-ice/issues/666) ，我会及时更新修正。

<br>

## 使用说明

### 选择和安装 RIME 前端

要使用雾凇拼音默认提供的所有功能，请保证
- 您的 RIME 前端提供的 librime 版本 ≥ 1.8.5 且
- 含有 librime-lua 依赖

以下是主流平台上的一些 RIME 前端安装建议。部分信息具有时效性，请以当下具体情况为准：

| 系统    | RIME 前端                                                    | 雾凇拼音版本要求                  | 备注                                                         |
| ------- | ------------------------------------------------------------ | --------------------------------- | ------------------------------------------------------------ |
| Android | [fcitx5-android](https://github.com/fcitx5-android/fcitx5-android/releases) + plugin.rime（小企鹅输入法） | ≥ 0.0.8                           | 暂不支持九宫格                                               |
| Android | [Trime](https://github.com/osfans/trime)（同文输入法）       | ≥ 3.2.11                          |                                                              |
| iOS     | [Hamster](https://apps.apple.com/cn/app/%E4%BB%93%E8%BE%93%E5%85%A5%E6%B3%95/id6446617683)（仓输入法） | N/A                               | 闭源；有内购                                                 |
| Linux   | ibus + [ibus-rime](https://github.com/rime/ibus-rime)        | librime ≥ 1.8.5 且装有 librime-lua | 部分发行版需手动安装 librime-lua                             |
| Linux   | fcitx5 + [fcitx5-rime](https://github.com/fcitx/fcitx5-rime) | librime ≥ 1.8.5 且装有 librime-lua | 部分发行版需手动安装 librime-lua                             |
| macOS   | [Squirrel](https://github.com/rime/squirrel)（鼠须管）       | ≥ 1.0.0                           | 0.16.0 - 0.18.0 版本请参考[🔗](https://github.com/iDvel/rime-ice/issues/1062) |
| macOS   | [fcitx5-macos](https://github.com/fcitx-contrib/fcitx5-macos) | N/A                               | 支持[卷轴模式](https://github.com/iDvel/rime-ice/issues/941) |
| Windows | [Weasel](https://github.com/rime/weasel)（小狼毫）           | ≥ 0.15.0                            | 0.14.3 可手动更新 [rime.dll](https://github.com/iDvel/rime-ice/issues/197)（但不支持彩色 emoji）<br />Weasel 当下有兼容性问题，建议安装其他输入法备用 |

Linux 依赖问题的具体解释请参考 [#840](https://github.com/iDvel/rime-ice/issues/840)。

雾凇拼音的部分配置可能要求更高的 librime 或者客户端版本，这些功能已在具体配置文件中注明。

以下安装方式，选择其一 （由于是fork所以只能以下两个）：

- [手动安装](#手动安装)
- [Git 安装](#git-安装)


### 手动安装

您可以将仓库打包下载，将所有文件复制粘贴到 RIME 前端的配置目录，重新部署。

只需要使用或者更新词库的话，可以手动粘贴覆盖 `cn_dicts` `en_dicts` `cn_dicts_cell` `opencc` 四个文件夹。

> [!NOTE]
> 雾凇拼音中多个文件可能与其他方案同名冲突，如果是新手想一键安装，建议备份原先配置，**清空配置目录**再导入。

> [!NOTE]
>
> 单独使用词库注意事项：`rime_ice.dict.yaml` 下面包含了大写字母，这和配置有些许绑定，可以直接删除，详细说明：[#356](https://github.com/iDvel/rime-ice/issues/356)

您也可以前往 [Release](https://github.com/LIPiston/rime-ice/releases) 界面，下载特定版本的词典文件（具体描述见 Release 说明），覆盖配置目录的对应文件。

### Git 安装

您如果熟悉 git 常用操作，可以使用 git clone 命令将本仓库克隆到对应前端的用户目录。由于本库提交历史较多且更改频繁，添加 `--depth` 参数可以显著减少传输体积。

```bash
git clone https://github.com/LIPiston/rime-ice.git Rime --depth 1

# 更新
cd Rime
git pull
```

通过 checkout 命令，您也可以实现更新部分文件的效果。

## 感谢 ❤️

特别感谢上文已经提及的词库、词典的作者、贡献者及整理者；特别感谢以及下列词库、方案、脚本的作者及贡献者（提及的均为 GitHub id）：

- @mozillazg 开发的汉字转拼音工具和数据库（MIT）
- [melt_eng](https://github.com/tumuyan/rime-melt)（@tumuyan | [Apache 2.0](https://github.com/tumuyan/rime-melt/blob/master/LICENSE)） ：提供了部分（约 1000 条）英文词汇以及原始英文方案参考；
- [部件拆字方案](https://github.com/mirtlecn/rime-radical-pinyin)（@mirtlecn | [GPL 3.0](https://github.com/mirtlecn/rime-radical-pinyin/blob/master/LICENSE)）：提供的拆字反查和候选筛选插件；
- [长词优先插件](https://github.com/tumuyan/rime-melt/blob/master/lua/melt.lua)（@tumuyan | [Apache 2.0](https://github.com/tumuyan/rime-melt/blob/master/LICENSE)）
- [Unicode 插件](https://github.com/shewer/librime-lua-script/blob/main/lua/component/unicode.lua)（@shewer | [MIT](https://github.com/shewer/librime-lua-script/blob/main/lua/component/unicode.lua)）
- [数字、人民币大写插件](https://github.com/yanhuacuo/98wubi/blob/master/lua/number.lua)（@98wubi）
- [农历插件](https://github.com/boomker/rime-fast-xhup)（@boomker | [LGPL 3.0](https://github.com/boomker/rime-fast-xhup/blob/master/LICENSE)）
- 未能在此处详述的、在本库源码注释中提及的项目及作者给予的帮助和参考

感谢 [@Huandeep](https://github.com/Huandeep) 整理的多个词库。

感谢 [@Mirtle](https://github.com/mirtlecn) 完善的多个功能。

感谢所有贡献者。

<!-- 搜狗转 Rime：[lewangdev/scel2txt](https://github.com/lewangdev/scel2txt) -->

Thanks to JetBrains for the OSS development license.

[![JetBrains](https://resources.jetbrains.com/storage/products/company/brand/logos/jb_beam.svg)](https://jb.gg/OpenSourceSupport)

<br>

## 赞助 ☕

如果觉得项目不错，可以请 Dvel 吃个煎饼馃子。

<img src="./others/sponsor.webp" alt="请 Dvel 吃个煎饼馃子" width=600 />
