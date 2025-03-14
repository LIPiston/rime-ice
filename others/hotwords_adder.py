import os

def check_and_append(source_file, target_file):
    try:
        # 确保目标文件所在目录存在
        target_dir = os.path.dirname(target_file)
        if target_dir and not os.path.exists(target_dir):
            os.makedirs(target_dir)
            print(f"已创建目录：{target_dir}")

        # 读取目标文件内容（如果存在）
        if os.path.exists(target_file):
            with open(target_file, 'r', encoding='utf-8') as f:
                target_lines = set(f.readlines())
        else:
            target_lines = set()
            print(f"目标文件不存在，即将创建：{target_file}")

        # 校验源文件是否存在
        if not os.path.exists(source_file):
            raise FileNotFoundError(f"源文件不存在：{source_file}")

        # 读取源文件内容
        with open(source_file, 'r', encoding='utf-8') as f:
            source_lines = f.readlines()

        # 过滤已存在的行
        new_lines = [line for line in source_lines if line not in target_lines]

        # 追加新内容
        if new_lines:
            with open(target_file, 'a', encoding='utf-8') as f:
                f.writelines(new_lines)
            print(f"成功添加 {len(new_lines)} 行新内容到 {target_file}")
            return True
        else:
            print("没有需要添加的新内容")
            return False

    except Exception as e:
        print(f"操作失败：{str(e)}")
        return False

if __name__ == "__main__":
    source = "cn_dicts_cell/temphotwords.dict.yaml"
    target = "cn_dicts_cell/hotwords.dict.yaml"
    
    # 执行核心逻辑
    success = check_and_append(source, target)
    
    # 根据执行结果退出程序
    exit(0 if success else 1)