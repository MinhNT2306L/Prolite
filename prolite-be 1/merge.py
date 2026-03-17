import os

# Cấu hình đuôi file như bạn đang dùng
EXTENSIONS = ('.ts', '.json')

# Tên file đầu ra
OUTPUT_FILE = "src.txt"

# SỬA LỖI ĐƯỜNG DẪN: Tự động lấy thư mục chứa chính file merge.py này
PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))

# Bổ sung thêm các thư mục ảo hóa phổ biến vào danh sách chặn
IGNORE_DIRS = {'target', '.git', '.idea', 'node_modules', 'dist', 'build', 'venv', '.venv', 'env'}

def merge_code_files():
    print(f"Đang quét thư mục: {PROJECT_DIR}")
    print(f"Đang tìm các file có đuôi: {EXTENSIONS} ...\n")
    
    count = 0 # Biến đếm số lượng file
    
    with open(OUTPUT_FILE, "w", encoding="utf-8") as outfile:
        for root, dirs, files in os.walk(PROJECT_DIR):
            
            # Chặn không cho quét vào thư mục rác
            dirs[:] = [d for d in dirs if d not in IGNORE_DIRS]
                
            for file in files:
                if file == OUTPUT_FILE:
                    continue

                if file.endswith(EXTENSIONS):
                    file_path = os.path.join(root, file)
                    count += 1
                    
                    # IN RA MÀN HÌNH ĐỂ KHÔNG BỊ "ĐƠ"
                    print(f"[{count}] Đang đọc: {file}")
                    
                    outfile.write(f"\n{'='*50}\n")
                    outfile.write(f"FILE: {file_path}\n")
                    outfile.write(f"{'='*50}\n\n")
                    
                    try:
                        with open(file_path, "r", encoding="utf-8", errors="ignore") as infile:
                            outfile.write(infile.read())
                            outfile.write("\n")
                    except Exception as e:
                        print(f"  -> LỖI ĐỌC FILE: {e}")
                        outfile.write(f"[LỖI ĐỌC FILE: {e}]\n")
                        
    print(f"\nHOÀN THÀNH! Đã gộp thành công {count} file.")
    print(f"File lưu tại: {os.path.join(PROJECT_DIR, OUTPUT_FILE)}")

if __name__ == "__main__":
    merge_code_files()