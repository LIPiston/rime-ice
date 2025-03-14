from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import tempfile
import os

# 配置路径（需要绝对路径）
download_path = r"/home/runner/work/rime-ice/rime-ice/"  # 替换为你的实际下载路径
# 动态生成唯一用户数据目录（GitHub Actions 兼容）
user_data_dir = os.path.join(tempfile.gettempdir(), f"chrome_profile_{os.getenv('GITHUB_RUN_ID', 'default')}")
os.makedirs(user_data_dir, exist_ok=True)

# Chrome选项配置
chrome_options = webdriver.ChromeOptions()
prefs = {
    "download.default_directory": download_path,
    "download.prompt_for_download": False,        # 禁用下载提示
    "download.directory_upgrade": True,
    "safebrowsing.enabled": True
}
chrome_options.add_experimental_option("prefs", prefs)
# 附加参数
chrome_options.add_argument("--no-sandbox")            # 禁用沙盒模式（解决权限问题）
chrome_options.add_argument("--disable-dev-shm-usage") # 解决共享内存不足问题
chrome_options.add_argument(f"--user-data-dir={user_data_dir}")  
chrome_options.add_argument("--headless")  # 必须启用无头模式

# 初始化浏览器驱动（需下载对应版本的ChromeDriver）
driver = webdriver.Chrome(options=chrome_options)  # 如果ChromeDriver不在PATH中，需指定executable_path参数


try:
    # 打开目标页面
    driver.get("https://pinyin.sogou.com/dict/detail/index/4")
    
    # 显式等待元素加载（最多等20秒）
    download_button = WebDriverWait(driver, 20).until(
        EC.presence_of_element_located((By.ID, "dict_4"))
    )
    
    # 点击下载按钮
    download_button.click()
    
    # 等待下载完成（根据文件大小调整等待时间）
    time.sleep(10)  # 简单等待，实际项目建议使用文件系统检测

finally:
    driver.quit()