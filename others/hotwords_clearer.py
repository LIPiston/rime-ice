import datetime
import sys

def has_valid_timestamp(line, time_format):
    """检查行末是否有有效时间戳"""
    if '#' not in line:
        return False
    parts = line.rsplit('#', 1)
    time_str = parts[-1].strip()
    try:
        datetime.datetime.strptime(time_str, time_format)
        return True
    except ValueError:
        return False

def process_file(file_path, time_format, expire_days, file_encoding='utf-8'):
    try:
        current_time = datetime.datetime.now()
        expire_time = current_time - datetime.timedelta(days=expire_days)

        # 读取文件内容
        with open(file_path, 'r', encoding=file_encoding) as f:
            all_lines = f.readlines()

        # 分割为头部和内容
        header = all_lines[:6]
        process_lines = all_lines[6:]

        # 处理数据行
        kept_lines = []
        for line in process_lines:
            original_line = line.rstrip()
            
            # 跳过无有效时间戳的行
            if not has_valid_timestamp(original_line, time_format):
                print(f"保留无时间戳行：{original_line}")
                kept_lines.append(original_line + '\n')
                continue
            
            # 过期检查
            parts = original_line.rsplit('#', 1)
            if len(parts) == 2:
                data_part, time_str = parts[0].strip(), parts[1].strip()
                try:
                    line_time = datetime.datetime.strptime(time_str, time_format)
                    if line_time < expire_time:
                        print(f"删除过期数据：{data_part}")
                        continue
                except ValueError:
                    print(f"保留时间格式错误行：{original_line}")
            
            kept_lines.append(original_line + '\n')

        # 合并并写回文件
        with open(file_path, 'w', encoding=file_encoding) as f:
            f.writelines(header + kept_lines)

    except Exception as e:
        print(f"处理失败：{str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    # 配置区 ------------------------------------------------
    FILE_PATH = 'cn_dicts_cell/hotwords.dict.yaml'  # 文件路径
    TIME_FORMAT = "%Y-%m-%d %H:%M:%S"    # 时间格式必须与文件一致
    EXPIRE_DAYS = 126                     # 保留天数
    FILE_ENCODING = 'utf-8'              # 文件编码（gbk/utf-8等）
    # ------------------------------------------------------

    process_file(FILE_PATH, TIME_FORMAT, EXPIRE_DAYS, FILE_ENCODING)
    print("清理旧词完成！")
