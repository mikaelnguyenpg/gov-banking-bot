# Gov Banking Chatbot

## Implementation Roadmap (How for Devs)

| Giai đoạn                        | Nội dung trọng tâm                                                                        | Công cụ/Tiêu chuẩn                    |
| -------------------------------- | ----------------------------------------------------------------------------------------- | ------------------------------------- |
| Giai đoạn 1: Sandbox             | Thử nghiệm trong môi trường kiểm soát của MAS (Regulatory Sandbox).                       | MAS Sandbox, Python, LangChain        |
| Giai đoạn 2: RAG & Knowledge     | Xây dựng cơ sở dữ liệu từ tài liệu nghiệp vụ, quy định.                                   | Pinecone/Weaviate, DeepEval (để test) |
| Giai đoạn 3: Guardrails          | Thiết lập "hàng rào" để chatbot không tư vấn tài chính sai lệch hoặc bị prompt injection. | NeMo Guardrails, LlamaGuard           |
| Giai đoạn 4: GovTech Integration | Kết nối với hệ sinh thái AIBots hoặc VICA của chính phủ.                                  | GovTech API, Singpass                 |

## Roadmap & Phasing (What/When for Stakeholders)

| Giai đoạn           | Thời gian | Mục tiêu chính                                                          |
| ------------------- | --------- | ----------------------------------------------------------------------- |
| Phase 1: Alpha      | 1-2 tháng | PoC nội bộ, chỉ trả lời các câu hỏi FAQ công khai.                      |
| Phase 2: Beta       | 3-4 tháng | Tích hợp Singpass, cho phép truy vấn dữ liệu cá nhân (read-only).       |
| Phase 3: Production | 6 tháng+  | Cho phép thực hiện giao dịch (transfer/payment) và mở rộng đa ngôn ngữ. |

## Base Architecture

```plaintext
/gov-banking-bot
├── /apps                # Các giao diện (Web, Mobile, Admin Dashboard)
├── /services            # Backend logic
│   ├── /ai-engine       # LangChain/LangGraph logic (Core của bạn)
│   ├── /api-gateway     # Điểm tiếp nhận request, Auth, Rate limit
│   └── /data-pipeline   # ETL chuyển đổi tài liệu thành Vector
├── /shared              # Code dùng chung (Models, Utils, Logging)
├── /configs             # Cấu hình cho từng môi trường (Sandbox, Prod)
├── /deployment          # Docker, Kubernetes, Terraform (NixOS/Ubuntu)
└── /tests               # Unit test, Integration test, E2E test
```

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
