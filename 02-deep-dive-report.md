# Lab 02 — Deliverable 02: Deep-Dive Report
**Học viên:** Đỗ Lý Hoàng Nam  
**Đơn vị:** Vin Smart Future (Vingroup)  
**Nhánh:** `DoLyHoangNam_2A202603777`  
**Bài toán lựa chọn:** **[VinFast] Phân loại & Điều phối Khiếu nại Bảo hành Xe điện (VinFast Smart Warranty Triage Co-pilot)**  

---

## 🏛️ 1. Bối cảnh & Lý do lựa chọn bài toán

Trong quá trình chuyển đổi số toàn diện tại **Vin Smart Future**, nhóm kỹ sư chúng tôi đã phối hợp với Khối Dịch vụ Hậu mãi & CSKH của **VinFast** để khảo sát quy trình tiếp nhận và xử lý bảo hành cho các dòng xe điện thông minh (VF3, VF5, VF6, VF7, VF8, VF9).

Nhóm quyết định lựa chọn **Bài toán #1: Phân loại & xử lý khiếu nại bảo hành** để thực hiện phân tích sâu (Deep-Dive) vì các lý do chiến lược:
1. **Tác động trực tiếp đến danh tiếng thương hiệu:** Tốc độ và độ chính xác trong phản hồi sự cố xe điện ảnh hưởng sống còn đến niềm tin của người tiêu dùng đối với xe điện VinFast.
2. **Điểm nghẽn thủ công nghiêm trọng:** CSKH phải tra cứu phân mảnh giữa nhiều hệ thống (CRM Salesforce, DMS xưởng, Telematics log), mất 25–40 phút/ticket, dẫn đến 18% khiếu nại leo thang do trễ SLA.
3. **Độ sẵn sàng của AI cao (High AI Fit):** Đây là bài toán kết hợp lý tưởng giữa trích xuất thực thể, phân loại văn bản tiếng Việt phức tạp và sinh nháp văn bản có kiểm soát (Human-in-the-loop).

---

# 🏗️ Phase 3 — DEEP-DIVE

## 3.1. Current-State Workflow Mapping (Quy trình hiện tại)

Quy trình tiếp nhận và phân loại khiếu nại bảo hành hiện tại của chuyên viên CSKH VinFast:

```text
┌────────────────┐     ┌────────────────┐     ┌────────────────┐     ┌────────────────┐     ┌────────────────┐
│ Bước 1         │     │ Bước 2 🔴      │     │ Bước 3 🔴      │     │ Bước 4 🔄      │     │ Bước 5         │
│ Tiếp nhận      │     │ Tra cứu thông  │     │ Phân tích mô tả│     │ Gán xưởng DV   │     │ Soạn phản hồi  │
│ khiếu nại      │ ──> │ tin xe & pin   │ ──> │ & gán loại lỗi │ ──> │ & check phụ tùng│ ──> │ & hẹn lịch tiếp│
│ qua App/Hotline│     │ chéo CRM/DMS   │     │ phần cứng/mềm  │     │ khả dụng       │     │ nhận với khách │
│                │     │                │     │                │     │                │     │                │
│ Ai: CSKH       │     │ Ai: CSKH       │     │ Ai: CSKH       │     │ Ai: CSKH + Xưởng│    │ Ai: CSKH       │
│ ⏱ 3 phút       │     │ ⏱ 10 phút 🔴   │     │ ⏱ 15 phút 🔴   │     │ ⏱ 7 phút 🔄     │     │ ⏱ 5 phút       │
│ In: Raw text   │     │ In: VIN, SĐT   │     │ In: Lịch sử xe │     │ In: Loại lỗi   │     │ In: Lịch hẹn   │
│ Out: Ticket thô│     │ Out: Spec & Log│     │ Out: Nhãn lỗi  │     │ Out: ID Xưởng  │     │ Out: Email/SMS │
└────────────────┘     └────────────────┘     └────────────────┘     └────────────────┘     └────────────────┘

🔴 Bottleneck: Bước 2 & Bước 3 (Mất 25 phút đọc mô tả dài, tra cứu chéo CRM/DMS và phán đoán mã lỗi).
🔄 Handoff: Bước 4 (Chuyển giao thông tin giữa tổng đài CSKH và Xưởng dịch vụ ủy quyền).
⏱ Tổng thời gian xử lý thủ công: 40 phút / ticket.
```

---

## 3.2. Problem Statement (6-field) — Vin Smart Future Standard

| Trường thông tin | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Chuyên viên CSKH Hậu mãi (Call Center / App Support) phối hợp cùng Cố vấn Dịch vụ tại Xưởng bảo hành VinFast. |
| **2. Current Workflow** | Khi khách hàng gửi yêu cầu bảo hành/khiếu nại lỗi xe, CSKH đọc mô tả thô, đăng nhập thủ công vào CRM Salesforce và DMS xưởng để tra cứu số khung VIN, model xe và lịch sử sửa chữa; sau đó tự phán đoán phân loại nhóm lỗi (Pin cao áp, Động cơ, Hệ thống treo, Hệ thống thông tin giải trí/ADAS) rồi chọn xưởng tiếp nhận. Quy trình gồm 5 bước thủ công, mất trung bình 35–40 phút/ticket. |
| **3. Bottleneck** | **Bước 2 & Bước 3:** Nhân viên CSKH không có nền tảng chuyên sâu về kỹ thuật ô tô điện, phải mất nhiều thời gian hỏi lại khách hoặc tra cứu tài liệu kỹ thuật dài. Tỷ lệ phân loại nhầm xưởng dịch vụ (xưởng không có máy cân bằng pin hoặc kỹ thuật viên cao áp) lên tới 15%. |
| **4. Business Impact** | Với trung bình ~300 ticket khiếu nại/ngày trên cả nước, VinFast tiêu tốn hơn 180 giờ làm việc/ngày của đội ngũ CSKH. Tỷ lệ ticket vi phạm cam kết phản hồi (SLA > 24h) là 22%, kéo theo **18% khiếu nại bị leo thang (escalated complaints)** lên cấp quản lý, gây áp lực tâm lý cho nhân viên và ảnh hưởng tiêu cực đến hình ảnh thương hiệu VinFast. |
| **5. Success Metric** | 1. **Hiệu suất vận hành (Efficiency):** Giảm thời gian phân loại và điều phối từ 40 phút ──> **dưới 3 phút/ticket**.<br>2. **Độ chính xác (Quality):** Độ chính xác phân loại danh mục lỗi và xưởng dịch vụ đạt **≥ 92%**.<br>3. **Trải nghiệm khách hàng (Customer Trust):** Giảm tỷ lệ khiếu nại leo thang do chậm trễ SLA từ 18% ──> **dưới 3%**. |
| **6. Operational Boundary (Ranh giới vận hành)** | **Quyền hạn được phép:** AI được phép trích xuất thông tin có cấu trúc (VIN, model, triệu chứng), tự động gợi ý mã lỗi OBD dự đoán, gợi ý xưởng tiếp nhận phù hợp nhất và tự động sinh bản nháp phiếu điều phối kèm thư trả lời khách hàng.<br>**Ranh giới nghiêm ngặt (CẤM):**<br>- Tuyệt đối **CẤM** AI tự động phê duyệt bồi thường tài chính, cam kết thay pin mới miễn phí hoặc cam kết ngày giờ hoàn tất bảo hành khi chưa có biên bản kiểm định thực tế của Kỹ sư xưởng.<br>- Mọi văn bản do AI sinh ra bắt buộc phải mở đầu bằng nhãn `[DRAFT_ONLY]` và yêu cầu Chuyên viên CSKH kiểm duyệt (Human-in-the-loop) trước khi gửi đi. |

---

## 3.3. Future-State Flow & AI Fit

### Ma trận lựa chọn AI Fit (AI-Fit Matrix):
* Nhóm lựa chọn mô hình **LLM Feature kết hợp Rule-based Router** (không sử dụng Autonomous Multi-Agent):
  * **Lý do:** Khách hàng mô tả lỗi bằng ngôn ngữ tự nhiên không cấu trúc (rất đa dạng theo phương ngữ địa phương), LLM đóng vai trò vượt trội trong việc trích xuất thực thể và hiểu sắc thái. Tuy nhiên, việc gán xưởng bảo hành và tra cứu quy định bảo hành cần tuân thủ nghiêm ngặt các bảng quy tắc cố định (Rule-based) để tránh hallucination và đảm bảo tính pháp lý.

### Sơ đồ quy trình tương lai (Future-State Flow):

```text
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│ Bước 1          │       │ Bước 2          │       │ Bước 3          │       │ Bước 4          │
│ Khách gửi mô tả │ ────> │ 🔵 AI Trích xuất│ ────> │ 🔵 AI Phân loại │ ────> │ 🟢 CSKH Kiểm tra│
│ khiếu nại qua   │       │ VIN, Model &    │       │ lỗi & Draft thư │       │ & Click phê     │
│ App/Hotline     │       │ triệu chứng lỗi │       │ hẹn lịch xưởng  │       │ duyệt (HITL)    │
└─────────────────┘       └─────────────────┘       └─────────────────┘       └─────────────────┘
                                                                                       │
                                                                                       ▼
                                                                              ┌─────────────────┐
                                                                              │ ↩️ Fallback      │
                                                                              │ Confidence < 80%│
                                                                              │ Chuyển về queue │
                                                                              │ Kỹ sư thủ công  │
                                                                              └─────────────────┘
```

* 🔵 **AI Step (LLM):** Đọc nội dung khiếu nại tiếng Việt, bóc tách thực thể (Mã xe, lỗi nghi ngờ: *Pin/Sạc, Động cơ, Hệ thống treo, Phần mềm infotainment...*), chấm điểm độ khẩn cấp (P1/P2/P3) và sinh bản nháp phản hồi chuẩn mực có tag `[DRAFT_ONLY]`.
* 🟢 **Human Step (HITL):** Chuyên viên CSKH chỉ mất 30–60 giây đọc lướt bản tóm tắt và ấn xác nhận để chuyển ticket đến Xưởng dịch vụ.
* ↩️ **Fallback Plan:** Nếu điểm tự tin của mô hình (Confidence Score) dưới 80% hoặc phát hiện khiếu nại có nguy cơ tranh chấp pháp lý/tai nạn nghiêm trọng, hệ thống tự động gắn cờ `CRITICAL_REVIEW` và chuyển thẳng về hàng đợi của Trưởng bộ phận Kỹ thuật kiểm tra thủ công.

---

# 🏁 Phase 5 — EVALUATE: Đánh giá độ sẵn sàng & Quyết định

### 1. AI Readiness Checklist:
* [x] **Dữ liệu mẫu/logs sạch:** VinFast có sẵn hơn 50.000 log lịch sử bảo hành và sửa chữa xe trên CRM Salesforce và DMS để làm dữ liệu Few-shot mẫu và tinh chỉnh prompt.
* [x] **Kiểm soát rủi ro an toàn:** Rủi ro sai sót hoàn toàn được kiểm soát nhờ cơ chế Human-in-the-loop (CSKH duyệt) và ranh giới cấm không cho AI tự duyệt bồi thường tài chính.
* [x] **Độ sẵn sàng của Stakeholders:** Cả Ban giám đốc Dịch vụ Hậu mãi và đội ngũ CSKH đều rất ủng hộ dự án vì mục tiêu trực tiếp giảm tải 70% công việc bàn giấy lặp lại.

### 2. Quyết định của Vin Smart Future:
**[x] GO (Bắt đầu phát triển bản mẫu thử nghiệm Prototype)**

### 3. Justification (Lý giải kỹ thuật & chi phí):
* **Chi phí & Thời gian triển khai:** Sử dụng API Gemini 2.5 Flash giúp tối ưu hóa chi phí token cực thấp (~0.001 USD/ticket), tốc độ phản hồi dưới 2 giây. Thời gian xây dựng PoC chỉ mất 2-3 tuần.
* **Tỷ suất sinh lời (ROI):** Tiết kiệm ước tính ~120 giờ làm việc/ngày trên toàn hệ thống CSKH, giảm chi phí nhân sự gián tiếp và ngăn chặn nguy cơ rò rỉ khách hàng trị giá hàng tỷ đồng do trải nghiệm dịch vụ hậu mãi chậm trễ.
