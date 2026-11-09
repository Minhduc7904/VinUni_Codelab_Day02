# Lab 02 — Worksheet: AI Product Scoping (Vin Smart Future)

---

## 🏛️ 1. Bối cảnh thực tế: Vin Smart Future (Vingroup)

**Vingroup** — Tập đoàn tư nhân lớn nhất Việt Nam — vừa sáp nhập toàn bộ các phòng ban công nghệ thuộc các công ty thành viên thành một đơn vị công nghệ thống nhất mang tên **Vin Smart Future**. 

Nhiệm vụ của **Vin Smart Future** là xây dựng các giải pháp AI, số hóa, và tự động hóa cốt lõi để nâng cao hiệu suất vận hành và trải nghiệm khách hàng xuyên suốt các công ty thành viên:
* 🚗 **VinFast:** Hệ thống xe điện thông minh (EV), trợ lý AI ảo trong xe, dự đoán bảo trì pin, và quản lý chuỗi cung ứng sản xuất.
* 🚕 **Xanh SM (GSM):** Vận hành đội xe taxi/xe máy điện thông minh, điều vận thông minh (Smart Dispatching), tối ưu hóa lộ trình di chuyển.
* 🏢 **Vinhomes:** Quản lý đô thị thông minh (Smart Cities), trợ lý cư dân thông minh, tối ưu hóa mức tiêu thụ năng lượng.
* 🏥 **Vinmec:** Y tế thông minh, chẩn đoán hình ảnh bằng AI, tối ưu hóa quản lý hồ sơ bệnh án.
* 🎢 **Vinpearl / VinWonders:** Trải nghiệm du lịch số hóa, quản lý phòng và luồng khách thông minh tại các khu vui chơi.

Trong buổi Lab hôm nay, nhóm của bạn sẽ đóng vai trò là **AI Product Engineer** tại **Vin Smart Future**, tiến hành tìm kiếm, scoping, phân tích độ khả thi, thiết lập ranh giới vận hành, và xây dựng một **bản mẫu kỹ thuật (prompt prototype)** cho một bài toán cụ thể thuộc một trong những mảng kinh doanh trên.

---

## 📊 2. Cơ cấu tính điểm bài lab

### 👥 Điểm nhóm (60 điểm)

| Gate | Điểm | Deliverable | Tiêu chí chấm |
|---|---:|---|---|
| **G1. Workflow Mapping** | 20 | Problem Deep-Dive | Vẽ chi tiết quy trình hiện tại: các bước, handoff, thời gian, bottleneck |
| **G2. Problem Statement** | 20 | Problem Deep-Dive | Problem Statement 6-field bám sát thực tế, metric có số và ranh giới rõ ràng |
| **G3. AI Fit & Future Flow** | 10 | Problem Deep-Dive | So sánh Rule vs LLM vs Agent, future flow có bước AI, ranh giới và Fallback |
| **G4. Decision Quality** | 10 | Problem Deep-Dive | Quyết định Go/Not Yet/No-Go trung thực và có chứng cứ rõ ràng |

### 👤 Điểm cá nhân (40 điểm)

| Gate | Điểm | Deliverable | Tiêu chí chấm |
|---|---:|---|---|
| **I1. Scan & Cards** | 15 | Quick Cards | Liệt kê 5 problems sử dụng 3 lenses, hoàn thiện 3 quick cards chất lượng |
| **I2. Prototyping** | 10 | 02-lab/ | Chạy thử nghiệm programmatic prompt prototype thành công |
| **I3. AI Log & Reflection** | 15 | 03-ai-log.md | Phản ánh trung thực về việc dùng AI làm thought-partner (giúp gì, sai gì, sửa gì) |

---

# 🚀 Phase 0 — worked Example: Xanh SM Intelligent Dispatcher (15 min)

*Giảng viên walk-through ví dụ thực tế từ Vin Smart Future để bạn hiểu rõ cách scoping một bài toán AI.*
Đọc chi tiết worked example tại file [02-deliverable-example.md](02-deliverable-example.md).

---

# 🔍 Phase 1 — SCAN (Cá nhân, 20 min)

Hãy sử dụng **4 Lenses** dưới đây để quét qua hoạt động vận hành của các công ty thành viên Vingroup. Ghi lại **ít nhất 5 bài toán/bottleneck** thực tế.

### 4 Lenses tìm bài toán AI cho Vingroup:
1. **Lặp lại (Repetitive):** Tác vụ lặp đi lặp lại nhiều lần hằng ngày.
2. **Tốn thời gian (Time-consuming):** Tác vụ ngốn thời gian xử lý thủ công của nhân viên.
3. **AI có thể tốt hơn (AI-upgrade):** Dịch vụ khách hàng hiện tại còn chậm hoặc phản hồi rập khuôn.
4. **Pain từ người khác (Stakeholder Pain):** Bottleneck khiến khách hàng hoặc nhân viên thực địa phàn nàn.

### 📝 List bài toán của tôi:
| # | Subsidiary (VinFast/Xanh SM...) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 | **VinFast** | Time-consuming & Stakeholder Pain | **Phân loại & xử lý khiếu nại bảo hành:** CSKH tra cứu thủ công qua nhiều hệ thống rời rạc để phân loại ticket lỗi xe/pin (mất trung bình 40 phút/ticket) *[Giả định]*, gây chậm SLA và tăng 18% khiếu nại leo thang. |
| 2 | **VinFast** | Repetitive & AI-upgrade | **Tra cứu tài liệu kỹ thuật xưởng dịch vụ:** Kỹ sư mất 3-5 ngày tổng hợp bản tin kỹ thuật mới; thợ máy tra cứu thủ công chậm, làm tăng thời gian xe nằm xưởng thêm ~1.5 giờ/xe *[Giả định]*. |
| 3 | **Xanh SM (GSM)** | Stakeholder Pain & Time-consuming | **Khai báo sự cố & va chạm hiện trường cho tài xế:** Tài xế phải gọi tổng đài khai báo thủ công khi gặp sự cố trên đường (12-15 phút/lượt), quy trình rườm rà gây ùn tắc và tăng áp lực lớn cho tài xế *[Giả định]*. |
| 4 | **Xanh SM (GSM)** | Repetitive & AI-upgrade | **Phân tích đánh giá & sắc thái chuyến xe (Passenger Feedback):** Đội vận hành phải lọc thủ công hàng ngàn feedback 1-2 sao mỗi ngày, độ trễ 24-48 giờ khiến các khiếu nại nghiêm trọng không được xử lý nóng *[Giả định]*. |
| 5 | **VinFast** | Time-consuming | **Kiểm tra hồ sơ tín dụng mua xe trả góp:** Nhân viên đối soát thủ công giấy tờ tài chính (60-90 phút/hồ sơ), tỷ lệ sai sót 12% làm kéo dài thời gian bàn giao xe và rò rỉ 5% khách hàng tiềm năng *[Giả định]*. |

---

# 🃏 Phase 2 — QUICK-ASSESS (Cá nhân, 30 min)

Chọn **top 3 bài toán** từ danh sách trên và hoàn thiện **3 Quick Problem Cards** dưới đây (10 phút/card).

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán (1 câu): Tự động trích xuất mã lỗi, phân loại mức   │
│ độ nghiêm trọng và điều phối ticket khiếu nại bảo hành xe.  │
│ Công ty thành viên: [x] VinFast  [ ] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? CSKH VinFast (quá tải tra cứu CRM/DMS),│
│ Chủ xe điện (chờ đợi lâu, tức giận vì trễ SLA hẹn bảo hành).│
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Tiếp nhận khiếu nại (3 min)                            │
│   ──> 2. Tra cứu thông tin xe & pin trên CRM/DMS (10 min)   │
│   ──> 3. Phân tích mô tả & gán loại lỗi sơ bộ (15 min)      │
│   ──> 4. Gán xưởng dịch vụ ủy quyền phù hợp (7 min)         │
│   ──> 5. Soạn phản hồi & hẹn lịch tiếp nhận xe (5 min)      │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2 & 3 (⏱ 25 min)      │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2, 3 & 5         │
│ (Trích xuất thông tin xe/lỗi -> Gợi ý phân loại & draft vé) │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                        │
│ Giảm thời gian xử lý ticket từ 40 min ──> dưới 3 min/ticket;│
│ Giảm tỷ lệ khiếu nại bảo hành leo thang từ 18% ──> dưới 3%. │
│ [Số liệu là Giả định thiết kế KPI dự án]                    │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán (1 câu): Tiếp nhận khẩn cấp thông tin sự cố hiện   │
│ trường/pin xe và tự động draft phương án điều phối cứu hộ.  │
│ Công ty thành viên: [ ] VinFast  [x] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Tài xế Xanh SM (hoang mang, dừng đỗ xe │
│ nguy hiểm), Điều phối viên trực ban (quá tải cuộc gọi gấp). │
│                                                             │
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Tài xế gọi hotline khẩn cấp báo sự cố/pin              │
│   ──> 2. Điều phối viên hỏi và ghi chép toạ độ GPS, mã xe    │
│   ──> 3. Tra cứu thủ công trạm sạc gần nhất hoặc xe cứu hộ   │
│   ──> 4. Soạn SMS/App notification chỉ dẫn gửi cho tài xế    │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2 & 3 (⏱ 12-15 min)   │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2, 3 & 4         │
│ (Chuẩn hoá vị trí -> Đề xuất cứu hộ/trạm -> Draft tin nhắn) │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                        │
│ Giảm thời gian tiếp nhận & điều phối từ 15 min ──> under 2min│
│ 100% cuộc gọi sự cố pin < 5% được kích hoạt cứu hộ khẩn cấp.│
│ [Số liệu là Giả định thiết kế vận hành]                     │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán (1 câu): Tự động phân tích sắc thái và chủ đề đánh │
│ giá 1-2 sao của hành khách để kích hoạt xử lý nóng sự cố.   │
│ Công ty thành viên: [ ] VinFast  [x] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Đội vận hành QA Xanh SM (lọc thủ công  │
│ hàng ngàn feedback), Hành khách có trải nghiệm tệ bỏ dịch vụ│
│                                                             │
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Hành khách gửi rating 1-2 sao kèm nhận xét trên App    │
│   ──> 2. Đội QA tải file log phản hồi cuối ngày             │
│   ──> 3. Đọc thủ công và gán tag lỗi (thái độ, xe bẩn, cước)│
│   ──> 4. Tạo ticket khiếu nại báo cho Trưởng trạm điều hành │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 3 (⏱ chậm trễ 24-48h) │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2 & 3            │
│ (Phân loại sắc thái, bóc tách nguyên nhân theo thời gian thực│
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                        │
│ Phát hiện khiếu nại nghiêm trọng trong 5 min (thay vì 24h);  │
│ Giảm 40% tỷ lệ churn của khách hàng gặp trải nghiệm xấu.    │
│ [Số liệu là Giả định mục tiêu kinh doanh]                   │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

---

# 🏗️ Phase 3 — DEEP-DIVE (Nhóm, 85 min)

## 3.1. Current-State Workflow Mapping (25 min)
* 🔴 **Bottleneck:** Bước 2 (Tra cứu CRM/DMS - 10 min) & Bước 3 (Phân loại triệu chứng xe - 15 min).
* 🔄 **Handoff:** Bước 4 (Chuyển giao thông tin giữa CSKH và Xưởng dịch vụ ủy quyền - 7 min).
* Ghi rõ thời gian vận hành trung bình: **Tổng cộng = 40 phút / lượt**.  
*(Xem sơ đồ trực quan hóa chi tiết tại file `04-workflow-diagram.png`)*.

## 3.2. Problem Statement (6-field) & Metrics (15 min)
| Field | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Chuyên viên CSKH Hậu mãi (Call Center / App Support) phối hợp cùng Cố vấn Dịch vụ tại Xưởng bảo hành VinFast. |
| **2. Current Workflow** | Khi khách hàng gửi yêu cầu bảo hành/khiếu nại, CSKH đọc mô tả, tra cứu số khung VIN, model xe và lịch sử sửa chữa trên CRM và DMS; tự phán đoán phân loại nhóm triệu chứng (Pin cao áp, Động cơ, Hệ thống treo, Phần mềm điều khiển/ADAS), tra cứu xưởng ủy quyền phù hợp và soạn tin nhắn hẹn lịch. Quy trình gồm 5 bước tuần tự, mất trung bình **40 phút / ticket**. |
| **3. Bottleneck** | **Bước 2 & Bước 3 (chiếm 25 phút):** CSKH không có chuyên môn sâu về kỹ thuật ô tô điện, mất nhiều thời gian đọc văn bản tiếng Việt dài dòng của khách và tra cứu đối chiếu. Tỷ lệ phân loại nhầm xưởng dịch vụ ước tính khoảng 15% *[Giả định]* . |
| **4. Business Impact** | Quy mô ước tính ~300 ticket khiếu nại/ngày trên toàn hệ thống *[Giả định quy mô vận hành]*. Với 40 phút/ticket, tổng thời gian xử lý tiêu tốn **300 × 40 phút = 12.000 phút = 200 giờ làm việc/ngày** của đội ngũ CSKH. Tỷ lệ chậm SLA phản hồi dẫn đến **18% khiếu nại bị leo thang (escalated complaints)**. |
| **5. Success Metric** | 1. Giảm thời gian xử lý từ 40 phút ──> **dưới 3 phút/ticket** (giảm **92.5%**).<br>2. Độ chính xác phân loại danh mục triệu chứng và xưởng dịch vụ đạt **≥ 92%**.<br>3. Giảm tỷ lệ khiếu nại leo thang do chậm SLA từ 18% ──> **dưới 3%** *[Toàn bộ là Giả định thiết kế KPI]* . |
| **6. Operational Boundary** | **Được phép:** Trích xuất thực thể (VIN, model, triệu chứng), gợi ý xưởng khả dụng, draft tin nháp gắn nhãn `[DRAFT_ONLY]`.<br>**CẤM:** Không tự ý duyệt bồi thường tài chính hoặc hứa đổi pin miễn phí; không tự gán mã lỗi OBD; không tự động gửi tin khi chưa có duyệt của CSKH (HITL); bắt buộc có **Pre-LLM filter** chặn nguy cơ cháy nổ chuyển cứu hộ 24/7. |

## 3.3. Future-State Flow & AI Fit (25 min)
* **Xác định mức AI Fit (AI-Fit Matrix):** [ ] Rule / State-Machine  [x] LLM Feature (kết hợp Rule Router)  [ ] Agentic Loop.
* **Quy trình tương lai (Future-State Flow):**
  * 🔴 **Pre-LLM Step:** Quét từ khóa an toàn nguy cấp (cháy, khói, phanh) bằng code Python; ngắt LLM và gọi Cứu hộ 24/7 nếu phát hiện.
  * 🔵 **AI Step:** LLM trích xuất VIN 17 ký tự, phân loại nhóm lỗi sơ bộ và draft thư hẹn có nhãn `[DRAFT_ONLY]`.
  * 🟢 **Human Step (HITL):** CSKH rà soát bản tóm tắt và click phê duyệt gửi đi trong 30-60 giây.
  * ↩️ **Fallback:** Pydantic Schema Validation kiểm tra định dạng VIN và trường thông tin. Nếu sai format, tự động đẩy về hàng đợi `Manual Triage Queue` cho Kỹ sư trưởng xưởng xử lý thủ công.

---

# 💻 Phase 4 — TECHNICAL PROMPT PROTOTYPE (Nhóm, 30 min)

Mã nguồn nguyên mẫu đã được cài đặt hoàn thiện tại [starter-code/prompt_prototype.py](starter-code/prompt_prototype.py) với 4 bài kiểm thử tấn công (Adversarial Tests), tích hợp Pydantic Schema và Pre-LLM Emergency Filter. Đã chạy thử nghiệm đạt exit code 0 và vượt qua 100% assertions.

---

# 🏁 Phase 5 — EVALUATE (Nhóm, 20 min)

### AI Readiness Checklist:
1. [ ] Chúng tôi có sẵn dữ liệu mẫu/logs sạch để test? *(Chưa có sẵn — Cần 2 tuần thu thập và ẩn danh 500 ticket mô phỏng)*.
2. [x] Rủi ro khi AI sai có nằm trong tầm kiểm soát (qua HITL hoặc Fallback)? *(Đã kiểm soát đa tầng qua Pre-LLM filter và Rule 3)*.
3. [ ] Stakeholders sẵn sàng thay đổi quy trình làm việc cũ? *(Chưa khảo sát chính thức với Ban Giám đốc VinFast hay CSKH)*.

### Quyết định cuối cùng của Ban Giám Đốc Vin Smart Future:
[ ] **GO (Bắt đầu xây dựng Prototype):** Bắt đầu phát triển với scope hẹp.  
[x] **NOT YET (Cần tích lũy thêm dữ liệu/xác lập baseline):** Trì hoãn để chuẩn bị thêm (Hoặc chỉ triển khai Conditional Pilot hẹp tại 01 xưởng cho nhóm lỗi Phần mềm VF8).  
[ ] **NO-GO (Không khả thi / Rule-based tốt hơn):** Hủy bỏ dự án AI này.

**Justification (Lý giải quyết định dựa trên bằng chứng kỹ thuật và chi phí):**
> Nhóm đưa ra quyết định **NOT YET** dựa trên nguyên tắc quản trị kỹ thuật trung thực: Hiện tại 2/3 điều kiện tiên quyết trong checklist (dữ liệu sạch và sự sẵn sàng của stakeholder) chưa được thẩm định thực tế. Việc vội vã đưa AI vào quy trình bảo hành ô tô điện khi chưa có tập benchmark F1-score chuẩn sẽ tạo ra rủi ro pháp lý lớn. Nhóm đề xuất lộ trình 4 tuần chuẩn bị dữ liệu và phỏng vấn người dùng trước khi ra quyết định GO chính thức.

---

# 📝 Phase 6 — REFLECTION (Cá nhân)
*Chi tiết phản ánh quá trình phối hợp và phản biện cùng AI được lưu trữ tại file [03-ai-log.md](03-ai-log.md).*
