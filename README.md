# LIPiston/rime-ice 
![alt text](others/demo-lipiston.png)

LIPiston 修改的 rime-ice  

原本的[readme](README-original.md)

默认翻页键是退格键前面的`- =`

## 修改清单  

- 来自 [rime-frost](https://github.com/gaboolic/rime-frost) 的`cn_dicts_cell`大词库
- 来自 [cpd](https://github.com/wuhgit/CustomPinyinDictionary) 的大词库
- 萌娘百科词库
- 自动更新的 Minecraft词库
- 自动更新的 搜狗热词
- 添加了好几个配色（懒得做演示了）

## HOW-TO-USE

如果你需要使用一整个由 LIPiston 修改的 rime-ice，就需要将一整个`full.zip`解压导入到用户文件夹（其实最好是删完整个用户文件夹然后导入一整个`full.zip`，因为我的rime-ice跟原本的rime-ice有点冲突）

### 用户文件夹路径

- Weasel: `%APPDATA%\Rime`
- Squirrel: `~/Library/Rime`
- iBus: `~/.config/ibus/rime`
- Fcitx: `~/.config/fcitx/rime`
- Fcitx5: `~/.local/share/fcitx5/rime/`

如果是仅使用词库的话，就下载 releases 的词库 zip，导入到你的 rime 即可。

### 语言模型相关

这里推荐使用[华宇语言模型-来自飞鹤快拼](https://github.com/boomker/rime-fast-xhup/releases/tag/v1.0.0)  
当然你也可以使用[万象语言模型](https://github.com/amzxyz/RIME-LMDG/releases/tag/LTS)

**快速启用方法**  
在用户文件夹运行下方命令后重新部署 rime 即可。

Unix-like平台：  
```bash
curl -sL https://raw.githubusercontent.com/lipiston/rime-ice/main/others/get-grammar-bash.sh | bash
```

Windows平台：  
```PowerShell
irm https://raw.githubusercontent.com/lipiston/rime-ice/main/others/get-grammar-powershell.ps1 | iex
```

### 注意事项

1. **备份**：在进行任何操作之前，请确保备份您的现有配置文件。
2. **兼容性**：由于修改内容较多，可能会与原版 rime-ice 存在兼容性问题。
3. **更新**：定期检查更新，以获取最新的词库和功能改进。

希望这些信息对你有所帮助！
