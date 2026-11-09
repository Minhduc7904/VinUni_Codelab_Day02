# Lab 02 — Deliverable 02: Deep-Dive Report
**Học viên:** Đỗ Lý Hoàng Nam  
**Đơn vị:** Vin Smart Future (Vingroup)  
**Nhánh:** `DoLyHoangNam_2A202603777`  
**Bài toán lựa chọn:** **[VinFast] Phân loại & Phân luồng Khiếu nại Bảo hành Xe điện (VinFast Smart Warranty Triage Co-pilot)**  

---

## 🏛️ 1. Bối cảnh & Lý do lựa chọn bài toán

Trong bối cảnh hợp nhất công nghệ tại **Vin Smart Future**, chúng tôi nghiên cứu bài toán tối ưu hóa quy trình tiếp nhận và phân loại khiếu nại bảo hành cho các dòng xe điện thông minh VinFast (VF5, VF6, VF7, VF8, VF9).

### Lý do lựa chọn bài toán:
1. **Trải nghiệm khách hàng sống còn:** Trong ngành ô tô điện, thời gian phản hồi khi xe gặp trục trặc là yếu tố then chốt giữ chân người dùng. Khiếu nại bị tắc nghẽn sẽ trực tiếp làm suy giảm uy tín thương hiệu xe điện quốc gia.
2. **Điểm nghẽn thủ công rõ rệt:** Chuyên viên CSKH hiện phải tra cứu chéo qua nhiều công cụ rời rạc (CRM Salesforce, DMS xưởng, log viễn thông pin), tốn trung bình **40 phút / ticket**, dẫn đến **18% khiếu nại bị leo thang (escalated)** do vi phạm thời gian cam kết (SLA).
3. **Phù hợp với giải pháp AI thực tế (High AI Fit):** Ngôn ngữ mô tả lỗi bằng tiếng Việt của khách hàng rất đa dạng, giàu sắc thái và không có cấu trúc cố định. LLM kết hợp với Rule-based Router là công cụ hoàn hảo để xử lý văn bản, trích xuất thực thể và dự thảo phản hồi dưới sự giám sát của con người (Human-in-the-loop).

---

# 🏗️ Phase 3 — DEEP-DIVE

## 3.1. Current-State Workflow Mapping (Quy trình hiện tại)

Quy trình tiếp nhận và xử lý khiếu nại bảo hành xe điện hiện tại gồm 5 bước thủ công:

```text
┌────────────────┐     ┌────────────────┐     ┌────────────────┐     ┌────────────────┐     ┌────────────────┐
│ Bước 1         │     │ Bước 2 🔴      │     │ Bước 3 🔴      │     │ Bước 4 🔄      │     │ Bước 5         │
│ Tiếp nhận      │     │ Tra cứu thông  │     │ Phân tích mô tả│     │ Gán xưởng DV   │     │ Soạn phản hồi  │
│ khiếu nại      │ ──> │ tin xe & pin   │ ──> │ triệu chứng lỗi│ ──> │ & check phụ tùng│ ──> │ & hẹn lịch tiếp│
│ qua App/Hotline│     │ chéo CRM/DMS   │     │ phần cứng/mềm  │     │ khả dụng       │     │ nhận với khách │
│                │     │                │     │                │     │                │     │                │
│ Ai: CSKH       │     │ Ai: CSKH       │     │ Ai: CSKH       │     │ Ai: CSKH + Xưởng│    │ Ai: CSKH       │
│ ⏱ 3 phút       │     │ ⏱ 10 phút 🔴   │     │ ⏱ 15 phút 🔴   │     │ ⏱ 7 phút 🔄     │     │ ⏱ 5 phút       │
│ In: Khách gọi  │     │ In: VIN, SĐT   │     │ In: Lịch sử xe │     │ In: Loại lỗi   │     │ In: Lịch hẹn   │
│ Out: Ticket thô│     │ Out: Spec & Log│     │ Out: Nhãn lỗi  │     │ Out: ID Xưởng  │     │ Out: SMS/Email │
└────────────────┘     └────────────────┘     └────────────────┘     └────────────────┘     └────────────────┘

🔴 = Bottlenecks: Bước 2 (10 min) & Bước 3 (15 min) tiêu tốn tới 25 phút đọc mô tả dài, tra cứu chéo CRM/DMS.
🔄 = Handoff: Bước 4 (7 min) là điểm chuyển giao giữa tổng đài CSKH và Xưởng trưởng xưởng dịch vụ.
⏱ Tổng thời gian xử lý thủ công: 3 + 10 + 15 + 7 + 5 = 40 phút / ticket.
```

---

## 3.2. Problem Statement (6-field) — Vin Smart Future Standard

| Trường thông tin | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Chuyên viên CSKH Hậu mãi (Call Center / App Support) phối hợp cùng Cố vấn Dịch vụ tại Xưởng bảo hành VinFast. |
| **2. Current Workflow** | Khi khách hàng gửi yêu cầu bảo hành/khiếu nại, CSKH đọc mô tả, tra cứu số khung VIN, model xe và lịch sử sửa chữa trên CRM và DMS; tự phán đoán phân loại nhóm triệu chứng (Pin cao áp, Động cơ, Hệ thống treo, Phần mềm điều khiển/ADAS), tra cứu xưởng ủy quyền phù hợp và soạn tin nhắn hẹn lịch. Quy trình gồm 5 bước tuần tự, mất trung bình **40 phút / ticket**. |
| **3. Bottleneck** | **Bước 2 & Bước 3 (chiếm 25 phút):** CSKH không có chuyên môn sâu về kỹ thuật ô tô điện, mất nhiều thời gian đọc văn bản tiếng Việt dài dòng của khách và tra cứu đối chiếu. Tỷ lệ phân loại nhầm xưởng dịch vụ (xưởng thiếu thiết bị chuyên dụng hoặc kỹ thuật viên cao áp) ước tính khoảng 15% *[Giả định]* . |
| **4. Business Impact** | Quy mô ước tính ~300 ticket khiếu nại/ngày trên toàn hệ thống *[Giả định quy mô vận hành]*. Với 40 phút/ticket, tổng thời gian xử lý tiêu tốn **300 × 40 phút = 12.000 phút = 200 giờ làm việc/ngày** của đội ngũ CSKH. Tỷ lệ chậm SLA phản hồi dẫn đến **18% khiếu nại bị leo thang (escalated complaints)**, gây áp lực nhân sự và ảnh hưởng tiêu cực đến hình ảnh thương hiệu xe điện VinFast. |
| **5. Success Metric** | 1. **Hiệu suất vận hành (Efficiency):** Giảm thời gian phân loại và xử lý ticket từ 40 phút ──> **dưới 3 phút/ticket** (cắt giảm **92.5%** thời gian xử lý thủ công ban đầu).<br>2. **Độ chính xác (Quality):** Độ chính xác phân loại danh mục triệu chứng và xưởng dịch vụ đạt **≥ 92%**.<br>3. **Trải nghiệm khách hàng (Trust):** Giảm tỷ lệ khiếu nại leo thang do chậm SLA từ 18% ──> **dưới 3%**.<br>*(Ghi chú: Toàn bộ mục tiêu metric là [Giả định thiết kế KPI dự án])* |
| **6. Operational Boundary (Ranh giới vận hành)** | **Quyền hạn được phép:**<br>- Trích xuất thông tin có cấu trúc (VIN, model, triệu chứng mô tả).<br>- Phân loại nhóm lỗi sơ bộ (Hardware, Software, Infotainment, Battery symptoms).<br>- Gợi ý xưởng dịch vụ ủy quyền phù hợp dựa trên bảng quy tắc khoảng cách và năng lực xưởng.<br>- Soạn bản nháp (draft) phiếu chuyển việc và thư phúc đáp khách hàng có tiền tố `[DRAFT_ONLY]`.<br><br>**Ranh giới nghiêm ngặt (TUYỆT ĐỐI CẤM):**<br>- **CẤM** AI tự động phê duyệt bồi thường tài chính, hứa hẹn đổi pin mới miễn phí hoặc cam kết thời hạn bảo hành khi chưa có biên bản giám định thực tế của Kỹ sư xưởng.<br>- **CẤM** AI tự phỏng đoán hay gán mã lỗi OBD chính thức (mã lỗi kỹ thuật bắt buộc phải đọc bằng thiết bị chẩn đoán chuyên dụng tại xưởng).<br>- **CẤM** AI tự động gửi tin nhắn/email cho khách hàng mà chưa có nút click duyệt của Chuyên viên CSKH (Bắt buộc Human-in-the-loop).<br>- **TIỀN LỌC AN TOÀN NGUY CẤP (Pre-LLM Guardrail):** Nếu nội dung chứa từ khóa nguy cơ cháy nổ / tai nạn (`khói`, `cháy`, `mùi khét`, `mất phanh`, `nổ pin`, `rò điện`), hệ thống **NGẮT LẬP TỨC KHÔNG CHO LLM XỬ LÝ**, chuyển thẳng sang đường dây nóng Đội Cứu hộ Khẩn cấp 24/7. |

---

## 3.3. Future-State Flow & AI Fit

### Ma trận lựa chọn AI Fit (AI-Fit Matrix):
* Nhóm lựa chọn mô hình **LLM Feature kết hợp Rule-based Router** (không dùng Autonomous Multi-Agent):
  * **Lý do kỹ thuật:** Khách hàng mô tả lỗi bằng ngôn ngữ tự nhiên không cấu trúc (rất đa dạng theo phương ngữ địa phương), LLM đóng vai trò xuất sắc trong việc đọc hiểu ngữ cảnh và trích xuất thực thể. Tuy nhiên, việc định tuyến xưởng bảo hành và chính sách bảo hành phải tuân thủ nghiêm ngặt các bảng quy tắc cố định (Rule-based) để loại bỏ hoàn toàn rủi ro hallucination.

### Sơ đồ quy trình tương lai (Future-State Flow):

```text
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│ Bước 1          │       │ Bước 2          │       │ Bước 3          │       │ Bước 4          │
│ Khách gửi mô tả │ ────> │ 🔴 Pre-LLM      │ ────> │ 🔵 LLM Trích    │ ────> │ 🟢 CSKH Kiểm tra│
│ khiếu nại qua   │       │ Keyword Filter  │       │ xuất & Draft thư│       │ & Click duyệt   │
│ App/Hotline     │       │ (Cháy/Khói/Phanh│       │ hẹn có nhãn tag │       │ gửi xưởng (HITL)│
└─────────────────┘       └─────────────────┘       │ [DRAFT_ONLY]    │       └─────────────────┘
                                   │                └─────────────────┘                │
                                   ▼ Cảnh báo đỏ                       ▼ Schema lỗi    ▼ Từ chối
                          ┌─────────────────┐               ┌─────────────────────────────┐
                          │ 🚨 Emergency    │               │ ↩️ Fallback Queue           │
                          │ Chuyển thẳng    │               │ Chuyển về Kỹ sư trưởng xưởng│
                          │ Đội Cứu hộ 24/7 │               │ kiểm tra thủ công như cũ    │
                          └─────────────────┘               └─────────────────────────────┘
```

* 🔴 **Pre-LLM Safety Filter (Rule-based):** Quét từ khóa an toàn nguy cấp trước khi gửi payload tới LLM.
* 🔵 **AI Step (LLM):** Bóc tách thực thể (Số VIN 17 ký tự, Model xe, Nhóm triệu chứng nghi ngờ: *Infotainment, Điều hòa, Sạc pin, Khung gầm*), sinh bản nháp phản hồi mở đầu bằng tiền tố `[DRAFT_ONLY]`.
* 🟢 **Human Step (HITL):** Chuyên viên CSKH chỉ mất 30–60 giây đọc lướt bản tóm tắt và ấn xác nhận để chuyển ticket đến Xưởng dịch vụ.
* ↩️ **Fallback Plan:** Không dựa vào độ tự tin tự khai của LLM (self-reported confidence), mà kiểm tra bằng **Schema Validation** (Pydantic): Nếu số VIN không đủ 17 ký tự, hoặc thiếu trường thông tin cốt lõi, ticket lập tức rơi vào hàng đợi `Manual Triage Queue` để Kỹ sư dịch vụ xử lý thủ công.

---

# 🏁 Phase 5 — EVALUATE: Đánh giá độ sẵn sàng & Quyết định

### 1. AI Readiness Checklist:
* [x] **Dữ liệu mẫu/logs:** Có khả năng trích xuất 500 ticket lịch sử đã ẩn danh hóa thông tin cá nhân (PII) để phục vụ Prompt Engineering và Benchmark kiểm thử *[Giả định kế hoạch chuẩn bị dữ liệu]*.
* [x] **Kiểm soát rủi ro an toàn:** Rủi ro được kiểm soát đa tầng nhờ: (1) Pre-LLM filter bắt cháy nổ; (2) Ranh giới cấm AI tự duyệt tài chính; (3) Human-in-the-loop bắt buộc ở khâu gửi tin.
* [x] **Độ sẵn sàng của Stakeholders:** CSKH và Xưởng dịch vụ có nhu cầu giảm tải rõ rệt đối với các lỗi phần mềm thường gặp.

### 2. Quyết định của Vin Smart Future:
**[x] GO CÓ ĐIỀU KIỆN (Conditional GO — Giai đoạn Pilot Phạm vi hẹp)**

### 3. Justification (Lý giải kỹ thuật & chi phí dựa trên bằng chứng và giả định):
* **Phạm vi Pilot hẹp an toàn (Scope Boundaries):** Không triển khai đại trà ngay lập tức. Trong giai đoạn 1 (4 tuần), dự án chỉ thí điểm tại **01 Xưởng Dịch vụ VinFast Hà Nội** và **chỉ áp dụng cho nhóm lỗi Phần mềm Điều khiển & Tiện ích (Infotainment/HVAC) trên dòng xe VF8**. Nhóm lỗi Pin cao áp và Hệ thống truyền động tiếp tục xử lý theo quy trình kỹ thuật truyền thống.
* **Chi phí vận hành mô hình (Model Cost):** Sử dụng API **Gemini 2.5 Flash** với chi phí ước tính khoảng **~0.001 USD / ticket** *[Giả định giá API Google AI Studio hiện hành]*. Với 300 ticket/ngày, chi phí API chỉ khoảng 0.30 USD/ngày (~7.500 VNĐ/ngày), hoàn toàn không đáng kể so với lợi ích tiết kiệm thời gian.
* **Tỷ suất ROI kỳ vọng:** Tiết kiệm ước tính ~180 giờ làm việc/ngày cho khối CSKH nếu triển khai toàn diện, giảm tỷ lệ ticket trễ hẹn và nâng cao chỉ số hài lòng khách hàng (CSAT).
* **Kế hoạch tích lũy dữ liệu:** Sau 4 tuần pilot, nhóm sẽ đo lường độ chính xác phân loại thực tế dựa trên đánh giá của Kỹ thuật viên xưởng trước khi quyết định mở rộng quy mô.
