# LIPiston/rime-ice 
![alt text](others/demo-lipiston.png)

LIPiston 修改的 rime-ice  

原本的[readme](README-original.md)

默认翻页键是退格键前面的`- =`

## 修改清单  

- 来自 [cpd](https://github.com/wuhgit/CustomPinyinDictionary) 的大词库
- 萌娘百科词库
- 自动更新的 搜狗热词
- 自动更新的 Minecraft词库
- 添加了好几个配色（懒得做演示了）

## HOW-TO-USE

如果你需要使用一整个由 LIPiston 修改的 rime-ice，就需要将一整个`full.zip`解压导入到用户文件夹（其实最好是删完整个用户文件夹然后导入一整个`full.zip`，因为我的rime-ice跟原本的rime-ice有点冲突）

### 用户文件夹路径

- Weasel: `%APPDATA%\Rime`
- Squirrel: `~/Library/Rime`
- iBus: `~/.config/ibus/rime`
- Fcitx5: `~/.local/share/fcitx5/rime/`

### 语言模型 / 语法模型

语法模型可以让长句候选更自然。默认推荐使用[万象语法模型](https://github.com/amzxyz/RIME-LMDG/releases/tag/LTS)，也可以选择[现代汉语常用语库 / 华宇语言模型](https://github.com/boomker/rime-fast-xhup/releases/tag/v1.0.0)。

在 Rime 用户文件夹运行脚本，下载 `.gram` 并生成对应的 `<方案名>.custom.yaml`，然后重新部署 Rime。

Unix-like / Git Bash：

```bash
curl -sL https://raw.githubusercontent.com/LIPiston/rime-ice/main/others/get-grammar-bash.sh | bash
```

脚本会从当前终端读取选项，因此可直接使用上面的命令；不要将额外输入再管道给 `bash`。

Windows PowerShell：

```powershell
irm https://raw.githubusercontent.com/LIPiston/rime-ice/main/others/get-grammar-powershell.ps1 | iex
```

默认会配置 `rime_ice.custom.yaml`。如果要给双拼方案配置，可以传入方案名：

```bash
bash others/get-grammar-bash.sh double_pinyin_flypy
```

```powershell
powershell -ExecutionPolicy Bypass -File others/get-grammar-powershell.ps1 double_pinyin_flypy
```

脚本会询问是否启用拼音纠错（如 `ign` → `ing`）。Fcitx5-Android 用户建议选择开启；其他平台可按需开启，不会默认强制开启。

脚本生成的配置会覆盖对应的 `<方案名>.custom.yaml`，并先创建 `.bak.时间戳` 备份。生成的配置默认使用更稳的模型参数。开启拼音纠错后会额外写入 `"translator/enable_correction": true`：

```yaml
patch:
  # 启用拼音纠错（如 ign → ing），Fcitx5-Android 用户建议开启
  "translator/enable_correction": true
  grammar:
    language: wanxiang-lts-zh-hans
    collocation_max_length: 6
    collocation_min_length: 3
    collocation_penalty: -14
    non_collocation_penalty: -6
    weak_collocation_penalty: -100
    rear_penalty: -20
  translator/contextual_suggestions: false
  translator/max_homophones: 8
  translator/max_homographs: 8
```

Fcitx5-Android 用户如果没有运行脚本，也可以把下面这段补丁加到对应方案的 `<方案名>.custom.yaml`：

```yaml
patch:
  # 启用拼音纠错（如 ign → ing），建议保持 true
  "translator/enable_correction": true
```
