def check_and_append(source_file, target_file):
    # 读取目标文件的所有行（包括换行符）
    with open(target_file, 'r') as f:
        target_lines = set(f.readlines())

    # 读取源文件的所有行（包括换行符）
    with open(source_file, 'r') as f:
        source_lines = f.readlines()

    # 找出源文件中不在目标文件中的行
    new_lines = [line for line in source_lines if line not in target_lines]

    # 如果有新内容，追加到目标文件
    if new_lines:
        with open(target_file, 'a') as f:
            f.writelines(new_lines)
        print(f"成功添加了 {len(new_lines)} 行新内容到 {target_file}")
    else:
        print("没有发现新内容。")

# 示例用法
if __name__ == "__main__":
    source = "cn_dicts_cell/hotwords.dict.yaml"  # 源文件名
    target = "cn_dicts_cell/temphotwords.dict.yaml"  # 目标文件名
    check_and_append(source, target)