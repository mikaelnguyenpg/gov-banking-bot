# Gov Banking Chatbot

## Usage

### 1. CLI Command để Init Project

```bash
# 1. Tạo thư mục dự án
mkdir gov-banking-bot && cd gov-banking-bot

# 2. Khởi tạo Git (Quan trọng vì Flakes yêu cầu file phải được track bởi Git)
git init

# 3. Tạo cấu trúc thư mục tối giản
mkdir -p services/ai-engine configs tests data/raw

# 4. Khởi tạo file flake.nix mặc định
nix flake init

# 5. Edit: flake.nix

# 6. Add + Edit: .gitignore

# 7. Khởi tạo sample .env
echo "OPENAI_API_KEY=your_api_key_here" > .env.example

# 7. Track các file này bằng Git
git add .
```

### 2. CLI Command để Init Project Dev Env

```bash
# Xóa các file rác bị lỗi, CHỈ chạy khi `nix develop` bị lỗi trước đó
# rm .python-version
# Khởi tạo Dev Env cho Project
nix develop
```

**Quy trình trên máy mới (Ubuntu/Mac/NixOS):**

```bash
git clone <repo>
cd gov-banking-bot
nix develop
```
