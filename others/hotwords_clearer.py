import os
import datetime

def read_dict(file_path):
    if not os.path.exists(file_path):
        return []
    with open(file_path, 'r', encoding='utf-8') as file:
        return file.readlines()

def write_dict(file_path, lines):
    with open(file_path, 'w', encoding='utf-8') as file:
        file.writelines(lines)

def is_expired(line, days=126):
    try:
        timestamp = line.strip().split()[-1]
        entry_date = datetime.datetime.strptime(timestamp, '%Y-%m-%d')
        return (datetime.datetime.now() - entry_date).days > days
    except:
        return True

def main():
    temp_file = './cn_dicts_cell/temphotwords.dict.yaml'
    hotwords_file = './cn_dicts_cell/hotwords.dict.yaml'

    temp_lines = read_dict(temp_file)
    hotwords_lines = read_dict(hotwords_file)

    hotwords_set = set(line.split()[0] for line in hotwords_lines if not is_expired(line))
    new_lines = []

    for line in temp_lines:
        word = line.split()[0]
        if word not in hotwords_set:
            new_line = f"{line.strip()} {datetime.datetime.now().strftime('%Y-%m-%d')}\n"
            new_lines.append(new_line)
            hotwords_set.add(word)

    hotwords_lines = [line for line in hotwords_lines if not is_expired(line)]
    hotwords_lines.extend(new_lines)

    write_dict(hotwords_file, hotwords_lines)

if __name__ == "__main__":
    main()