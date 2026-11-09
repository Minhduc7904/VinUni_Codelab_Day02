# Lab 02 — Deliverable 02: Deep-Dive Report
**Học viên:** Đỗ Lý Hoàng Nam  
**Đơn vị:** Vin Smart Future (Vingroup)  
**Nhánh:** `DoLyHoangNam_2A202603777`  
**Bài toán lựa chọn:** **[VinFast] Phân loại & Phân luồng Khiếu nại Bảo hành Xe điện (VinFast Smart Warranty Triage Co-pilot)**  

---

## 🏛️ 1. Bối cảnh & Lý do lựa chọn bài toán

Trong khuôn khổ sáng kiến công nghệ tại **Vin Smart Future**, chúng tôi nghiên cứu bài toán tối ưu hóa quy trình tiếp nhận và phân loại khiếu nại bảo hành cho các dòng xe điện thông minh VinFast (VF5, VF6, VF7, VF8, VF9).

> **📌 [Bản ghi Điều chỉnh & Minh bạch hóa Số liệu (Data Transparency Changelog)]:**  
> Trong các bản thảo ban đầu của nhóm, các số liệu vận hành có sự dao động (25–40 phút, 180 giờ/ngày, giảm 70% thời gian). Sau quá trình rà soát mô hình toán học và tiếp thu phản biện kỹ thuật, nhóm đã chuẩn hóa toàn bộ các biến số theo một mô hình nhất quán:
> - Thời gian xử lý thủ công chuẩn: **40 phút / ticket** (chi tiết tại mục 3.1).
> - Quy mô vận hành giả lập: **300 ticket / ngày**.
> - Tổng thời gian tiêu tốn: $300 \times 40\text{ phút} = 12.000\text{ phút} = \mathbf{200}\text{ giờ làm việc/ngày}$.
> - Mục tiêu cắt giảm xuống dưới 3 phút/ticket tương đương mức tối ưu $\mathbf{\approx 92.5\%}$ thời gian xử lý thủ công.
> *(Toàn bộ các số liệu này được xây dựng theo phương pháp [Mô phỏng Giả định Nghiên cứu / Simulated Desk Research], chưa phải dữ liệu đo đạc nội bộ từ cơ sở dữ liệu sản xuất của VinFast).*

---

# 🏗️ Phase 3 — DEEP-DIVE

## 3.1. Current-State Workflow Mapping (Quy trình hiện tại)

Quy trình tiếp nhận và phân loại khiếu nại bảo hành xe điện hiện tại gồm 5 bước tuần tự hoàn toàn thủ công:

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

🔴 = Bottlenecks: Bước 2 (10 min) & Bước 3 (15 min) ngốn tới 25 phút đọc văn bản dài, tra cứu chéo hệ thống phân mảnh.
🔄 = Handoff: Bước 4 (7 min) là điểm chuyển giao giữa tổng đài CSKH và Xưởng dịch vụ ủy quyền.
⏱ Tổng thời gian vận hành thủ công: 3 + 10 + 15 + 7 + 5 = 40 phút / ticket.
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
| **6. Operational Boundary (Ranh giới vận hành)** | **Quyền hạn được phép:**<br>- Trích xuất thông tin có cấu trúc (VIN, model, triệu chứng mô tả).<br>- Phân loại nhóm lỗi sơ bộ (Hardware, Software, Infotainment, Battery symptoms).<br>- Gợi ý xưởng dịch vụ ủy quyền phù hợp dựa trên bảng quy tắc khoảng cách và năng lực xưởng.<br>- Soạn bản nháp (draft) phiếu chuyển việc và thư phúc đáp khách hàng có tiền tố `[DRAFT_ONLY]`.<br><br>**Ranh giới nghiêm ngặt (TUYỆT ĐỐI CẤM):**<br>- **CẤM** AI tự động phê duyệt bồi thường tài chính, hứa hẹn đổi pin mới miễn phí hoặc cam kết thời hạn bảo hành khi chưa có biên bản giám định thực tế của Kỹ sư xưởng.<br>- **CẤM** AI tự phỏng đoán hay gán mã lỗi OBD chính thức (mã lỗi kỹ thuật bắt buộc phải đọc bằng thiết bị chẩn đoán chuyên dụng tại xưởng).<br>- **CẤM** AI tự động gửi tin nhắn/email cho khách hàng mà chưa có nút click duyệt của Chuyên viên CSKH (Bắt buộc Human-in-the-loop).<br>- **TIỀN LỌC AN TOÀN NGUY CẤP (Pre-LLM Guardrail):** Đã được cài đặt trực tiếp trong mã nguồn Python (`pre_llm_safety_filter`), nếu nội dung chứa từ khóa nguy cơ cháy nổ / tai nạn (`khói`, `cháy`, `mùi khét`, `mất phanh`, `nổ pin`, `rò điện`), hệ thống **NGẮT LẬP TỨC KHÔNG CHO LLM XỬ LÝ**, chuyển thẳng sang đường dây nóng Đội Cứu hộ Khẩn cấp 24/7. |

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

* 🔴 **Pre-LLM Safety Filter (Rule-based Code):** Đã hiện thực hóa bằng hàm Python `pre_llm_safety_filter` để ngắt kết nối trước khi payload truyền tới Gemini API.
* 🔵 **AI Step (LLM):** Bóc tách thực thể (Số VIN 17 ký tự, Model xe, Nhóm triệu chứng nghi ngờ: *Infotainment, Điều hòa, Sạc pin, Khung gầm*), sinh bản nháp phản hồi mở đầu bằng tiền tố `[DRAFT_ONLY]`.
* 🟢 **Human Step (HITL):** Chuyên viên CSKH chỉ mất 30–60 giây đọc lướt bản tóm tắt và ấn xác nhận để chuyển ticket đến Xưởng dịch vụ.
* ↩️ **Fallback Plan (Pydantic Schema Validation):** Đã cài đặt Pydantic Model `WarrantyTriageTicket`. Nếu dữ liệu trả về thiếu trường bắt buộc hoặc số VIN không đủ 17 ký tự chuẩn ISO 3779, ticket lập tức rơi vào hàng đợi `Manual Triage Queue` để Kỹ sư dịch vụ xử lý thủ công.

---

# 🏁 Phase 5 — EVALUATE: Đánh giá độ sẵn sàng & Quyết định

### 1. AI Readiness Checklist (Đánh giá trung thực, không tô hồng):
* [ ] **Dữ liệu mẫu/logs sạch để test:** `CHƯA CÓ SẴN (NOT YET)` — Hiện tại nhóm chưa tiếp cận được dữ liệu log production thực tế của VinFast do rào cản bảo mật dữ liệu khách hàng (PII). Đang lập kế hoạch trích xuất và gán nhãn 500 ticket mô phỏng trong vòng 2 tuần.
* [x] **Rủi ro khi AI sai có nằm trong tầm kiểm soát:** `ĐẠT (YES)` — Nhờ kiến trúc phòng thủ đa tầng: (1) Pre-LLM filter chặn cháy nổ; (2) Rule 3 cấm cam kết tài chính; (3) Human-in-the-loop bắt buộc ở khâu gửi tin.
* [ ] **Stakeholders sẵn sàng thay đổi quy trình:** `CHƯA XÁC NHẬN (NOT YET)` — Chưa thực hiện phỏng vấn chính thức với Ban Giám đốc VinFast hay Trưởng xưởng dịch vụ. Cần tổ chức buổi Workshop nghiệp vụ để thống nhất giao diện chuyển giao vé.

---

### 2. Quyết định của Vin Smart Future:
**[x] NOT YET (Chưa thể GO đại trà — Cần hoàn thiện Pilot chuẩn bị dữ liệu và khảo sát Stakeholders)**  
*(Nếu Ban Giám Đốc muốn triển khai sớm, nhóm đề xuất **Conditional Pilot** chỉ giới hạn tại 01 Xưởng Dịch vụ Hà Nội cho nhóm lỗi Phần mềm VF8).*

---

### 3. Justification (Lý giải quyết định dựa trên bằng chứng kỹ thuật và chi phí):
* **Lý do KHÔNG GO ngay lập tức:** Dựa trên checklist, 2 trong 3 điều kiện tiên quyết (dữ liệu sạch và sự cam kết của stakeholders) chưa được xác thực bằng bằng chứng thực địa. Việc triển khai ngay một mô hình AI vào quy trình bảo hành ô tô điện khi chưa có tập benchmark chuẩn sẽ tạo ra rủi ro pháp lý và an toàn vận hành.
* **Lộ trình chuẩn bị 4 tuần (Preparation Roadmap):**
  1. *Tuần 1-2:* Phối hợp cùng Tổ Kỹ thuật Hậu mãi thu thập và gán nhãn tập dữ liệu 500 ticket mẫu đã ẩn danh thông tin cá nhân.
  2. *Tuần 3:* Đo lường độ chính xác phân loại của Gemini 2.5 Flash trên tập dữ liệu này (Mục tiêu: Đạt F1-score ≥ 90% trước khi cho chạy thử).
  3. *Tuần 4:* Tổ chức phỏng vấn CSKH và Cố vấn Dịch vụ để đánh giá độ thân thiện của giao diện Human-in-the-loop.
* **Chi phí thử nghiệm (Simulation Cost):** Sử dụng API Gemini 2.5 Flash trong giai đoạn thử nghiệm chỉ tốn ước tính **~0.30 USD / ngày** (~7.500 VNĐ/ngày cho 300 ticket), chi phí cực kỳ tối ưu để tích lũy dữ liệu trước khi ra quyết định GO chính thức.
