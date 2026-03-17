<div align="center">
  <h1>🚀 PROLITE</h1>
  <p><i>A Modern Lightweight Social & Chat Application</i></p>
</div>

---

## 📖 1. Summary

**Prolite** là một ứng dụng mạng xã hội và nhắn tin thu nhỏ (mini social-chat app) được thiết kế tối ưu hóa tốc độ và hiệu suất. Hệ thống cung cấp đầy đủ các tính năng tương tác từ kết bạn, đăng bài, bình luận đến trò chuyện theo thời gian thực.

**Tech Stack:**
* **Framework API:** [Hono.js](https://hono.dev/)
* **Database & Auth:** [Supabase](https://supabase.com/) (PostgreSQL)
* **Runtime / Deploy:** [Cloudflare Workers](https://workers.cloudflare.com/)
* **Ngôn ngữ:** TypeScript

## 🔄 2. Screen flow

Luồng trải nghiệm của người dùng được thiết kế mạch lạc và tập trung vào tương tác:

* **👋 Onboarding:** `Màn hình Đăng nhập (Login)` ➔ `Đăng ký (Register)`
* **🏠 Main Hub:** `Bảng tin (Newsfeed / Posts)` ⟷ `Thông báo (Notifications)`
* **💬 Chat Flow:** `Danh sách Hội thoại (Conversations)` ➔ `Phòng Chat (Messages)`
* **👥 Tương tác:** `Trang cá nhân (Profile)` ⟷ `Quản lý Bạn bè (Friends / Requests)`

## 🌐 3. Web deploy

Dự án sử dụng kiến trúc Serverless (không máy chủ) hiện đại để tối ưu chi phí và khả năng mở rộng (scale):
* **Backend API:** Triển khai trực tiếp lên **Cloudflare Workers** (chạy trên môi trường Edge), giúp API phản hồi cực nhanh ở mọi vị trí địa lý.
* **Cơ sở dữ liệu:** Vận hành và bảo mật trực tiếp thông qua nền tảng đám mây của **Supabase**.
* **Frontend:** *(Bạn có thể điền nền tảng bạn dùng cho Frontend vào đây, ví dụ: Vercel, Netlify, hoặc Cloudflare Pages).*

## 🗄️ 4. Database

Hệ cơ sở dữ liệu quan hệ (PostgreSQL) được chuẩn hóa chặt chẽ với các thực thể (Tables) cốt lõi sau:
* `users`: Lưu trữ thông tin định danh (email, username, avatar, bio).
* `posts` & `post_images`: Quản lý nội dung bài viết và hình ảnh đính kèm.
* `comments` & `likes`: Lưu vết các tương tác của người dùng trên mạng xã hội.
* `friendships`: Quản lý trạng thái kết bạn (pending, accepted).
* `conversations` & `messages`: Vận hành luồng tin nhắn cá nhân và nhóm.
* `notifications`: Hệ thống thông báo tập trung.

## 💻 5. Installation

Các bước để thiết lập và chạy Backend trên môi trường local của bạn:

**Bước 1: Cài đặt thư viện**
Mở terminal tại thư mục dự án `prolite-be` và cài đặt các dependencies:
```bash
npm install
```

**Bước 2: Cấu hình biến môi trường**
Tạo một file có tên `.dev.vars` (chuẩn của Cloudflare Workers) ở thư mục gốc và khai báo các thông tin từ dự án Supabase của bạn:
```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
JWT_SECRET=your_super_secret_jwt_string
```

**Bước 3: Khởi chạy dự án (Local)**
Sử dụng lệnh khởi động đã được thiết lập sẵn thông qua Wrangler:
```bash
npm run dev
```
API của bạn sẽ bắt đầu lắng nghe tại `http://localhost:8787`.

**Bước 4: Triển khai (Deploy)**
Khi đã hoàn thiện code và muốn đưa Backend lên môi trường Production của Cloudflare, bạn chỉ cần chạy lệnh:
```bash
npm run deploy
```