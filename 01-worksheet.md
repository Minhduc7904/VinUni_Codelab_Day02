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
1. **Lặp lại (Repetitive):** Tác vụ lặp đi lặp lại nhiều lần hằng ngày. (Ví dụ: So khớp hóa đơn sạc điện tại VinFast, route lại chuyến taxi tại Xanh SM).
2. **Tốn thời gian (Time-consuming):** Tác vụ ngốn thời gian xử lý thủ công của nhân viên. (Ví dụ: Soạn thảo phản hồi đánh giá 1-star của cư dân Vinhomes).
3. **AI có thể tốt hơn (AI-upgrade):** Dịch vụ khách hàng hiện tại còn chậm hoặc phản hồi rập khuôn. (Ví dụ: Chatbot CSKH Vinpearl hỗ trợ đặt vé vui chơi).
4. **Pain từ người khác (Stakeholder Pain):** Bottleneck khiến khách hàng hoặc nhân viên thực địa phàn nàn. (Ví dụ: Tài xế Xanh SM phàn nàn về việc hệ thống gợi ý điểm đón khách không chính xác).

> [!TIP]
> **🤖 AI Prompts — Partner brainstorm:**
> Hãy sử dụng prompt sau để brainstorm các bài toán thực tế nếu bạn chưa có ý tưởng:
> *"Tôi là AI Engineer tại Vin Smart Future (Vingroup). Tôi đang tìm kiếm các pain point vận hành cụ thể có thể tối ưu bằng AI cho mảng [Chọn một: VinFast / Xanh SM / Vinhomes / Vinmec]. Hãy gợi ý cho tôi 5 quy trình nghiệp vụ thủ công, tốn nhiều thời gian và gây rò rỉ hiệu suất kèm con số thống kê ước tính về tổn thất."*

### 📝 List bài toán của tôi (Tập trung vào Xanh SM & Vinhomes):
| # | Subsidiary (VinFast/Xanh SM...) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 | **Vinhomes** | **AI có thể tốt hơn (AI-upgrade)** | Phân loại mức độ khẩn cấp và điều phối (triage & routing) phản ánh sự cố kỹ thuật của cư dân trên App Vinhomes Resident (điện, nước, thang máy, cảnh quan) về đúng đội kỹ thuật. Hiện CSKH phân loại thủ công mất 30–45 phút/ticket, tỷ lệ gán sai bộ phận ~18%. |
| 2 | **Xanh SM** | **Pain từ người khác (Stakeholder Pain)** | Giải quyết khiếu nại chênh lệch cước phí & phụ phí cầu đường/phí chờ giữa khách hàng và tài xế. Tài xế phàn nàn vì bị treo doanh thu chờ đối soát (24–48h), còn CSKH mất ~15 phút/vụ để đối chiếu lộ trình GPS, vé cầu đường và soạn phản hồi. |
| 3 | **Xanh SM** | **Tốn thời gian (Time-consuming)** | Xử lý yêu cầu tìm đồ thất lạc (Lost & Found) sau chuyến đi: CSKH phải tra cứu cuốc xe, gọi điện xác minh với tài xế, ghi chép mô tả món đồ và hẹn điểm trả đồ thủ công (mất 18–25 phút/trường hợp, ~250 ca/ngày). |
| 4 | **Vinhomes** | **Lặp lại (Repetitive)** | Rà soát và đối chiếu hồ sơ đăng ký thi công/sửa chữa căn hộ & đăng ký vận chuyển vật liệu ra vào tòa nhà của cư dân với quy định PCCC và nội quy Ban Quản Lý (mất 20–30 phút/bộ hồ sơ). |
| 5 | **Xanh SM** | **Lặp lại (Repetitive)** | Tổng hợp và phân nhóm lý do khách hủy chuyến / tài xế từ chối chuyến từ log ghi chú tự do và cuộc gọi tổng đài vào giờ cao điểm để cảnh báo điểm nghẽn điểm đón (pickup point) sai lệch. |
| 6 | **Vinhomes** | **Tốn thời gian (Time-consuming)** | Tổng hợp biên bản hiện trường và soạn thảo phản hồi giải trình cá nhân hóa cho các đánh giá 1–2 sao của cư dân về dịch vụ bảo trì tại căn hộ (mất 15–20 phút/phản hồi). |

---

# 🃏 Phase 2 — QUICK-ASSESS (Cá nhân, 30 min)

Chọn **top 3 bài toán** từ danh sách trên (**#1 Vinhomes Điều phối sự cố kỹ thuật, #2 Xanh SM Đối soát khiếu nại cước phí, #3 Xanh SM Tìm đồ thất lạc**) và hoàn thiện **3 Quick Problem Cards** dưới đây (10 phút/card).

## Thẻ bài toán 1: Card #1 — Vinhomes Phân loại & Điều phối sự cố kỹ thuật cư dân

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán: Cư dân Vinhomes gửi phản ánh sự cố kỹ thuật kèm   │
│ mô tả tự do/hình ảnh cần được phân loại mức độ khẩn cấp và  │
│ chuyển đúng đội kỹ thuật (M&E, PCCC, Cảnh quan, An ninh).   │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [x] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác: _______________  │
│                                                             │
│ Ai đang đau (Actor)? Cư dân (chờ xử lý lâu), Nhân viên      │
│ CSKH Ban Quản Lý (quá tải đọc ticket), Đội kỹ thuật (nhận   │
│ nhầm đầu việc không đúng chuyên môn).                       │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Cư dân gửi phản ánh sự cố (text/ảnh) trên App Resident │
│   → 2. CSKH BQL mở từng ticket, đọc mô tả và xem ảnh sự cố  │
│   → 3. CSKH tra bảng phân công để xác định mức độ ưu tiên   │
│        (Khẩn cấp/Thường) và chọn bộ phận kỹ thuật phụ trách │
│   → 4. Gán ticket trên hệ thống kèm ghi chú tóm tắt cho thợ │
│   → 5. Soạn tin nhắn xác nhận thời gian dự kiến xử lý (SLA) │
│        gửi lại cho cư dân trên App                          │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2-4 (⏱ 12 phút/lượt,  │
│ thường bị ứ đọng vào buổi sáng và tối, dễ gán nhầm bộ phận) │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2-5              │
│ (Tự động trích xuất loại sự cố, mức độ khẩn cấp, gợi ý đội  │
│ kỹ thuật phụ trách và soạn nháp phản hồi SLA cho cư dân)    │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ - Giảm thời gian phân loại & điều phối từ 12 phút ──> <2 ph │
│ - Giảm tỷ lệ gán nhầm đội kỹ thuật từ 18% ──> dưới 3%      │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
│ (LLM Feature: Phân tích ngôn ngữ tự nhiên + soạn nháp SLA)  │
└─────────────────────────────────────────────────────────────┘
```

## Thẻ bài toán 2: Card #2 — Xanh SM Xử lý khiếu nại chênh lệch cước phí & phụ phí

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán: Khách hàng hoặc tài xế Xanh SM khiếu nại về cước  │
│ phí chuyến đi (lệch km, phí chờ, phí cầu đường/sân bay) cần │
│ đối soát dữ liệu GPS và giải trình minh bạch, nhanh chóng.  │
│ Công ty thành viên: [ ] VinFast  [x] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác: _______________  │
│                                                             │
│ Ai đang đau (Actor)? Tài xế (bị tạm giữ doanh thu cuốc xe), │
│ Khách hàng (bức xúc vì phí phát sinh), Nhân viên CSKH       │
│ Đối soát (mất nhiều thời gian tra cứu chéo nhiều màn hình). │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Khách hàng/Tài xế gửi khiếu nại cước phí qua App/Hotline│
│   → 2. CSKH mở CMS tra cứu log cuốc xe (quãng đường ước tính│
│        vs GPS thực tế, thời gian dừng đỗ, biên lai phụ phí) │
│   → 3. Đối chiếu với quy chế tính cước & trạm thu phí BOT   │
│   → 4. Tính toán số tiền chênh lệch và lập đề xuất hoàn tiền│
│        (nếu có) trình Trưởng ca phê duyệt                   │
│   → 5. Soạn văn bản giải trình chi tiết gửi Khách & Tài xế  │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2, 3 & 5 (⏱ 15 phút/  │
│ lượt)                                                       │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2, 3 & 5         │
│ (Tự động tổng hợp chênh lệch từ log JSON cuốc xe, đối chiếu │
│ chính sách phụ phí và soạn nháp giải trình rõ ràng)         │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ - Giảm thời gian xử lý mỗi ticket từ 15 phút ──> dưới 3 phút│
│ - Đạt 95% bản nháp giải trình chính xác số liệu ngay lần đầu│
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
│ (Rule tính toán số học + LLM tổng hợp nguyên nhân & draft)  │
└─────────────────────────────────────────────────────────────┘
```

## Thẻ bài toán 3: Card #3 — Xanh SM Xử lý yêu cầu tìm đồ thất lạc (Lost & Found)

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán: Hành khách báo để quên hành lý/điện thoại trên xe │
│ Xanh SM cần xác minh nhanh với tài xế và điều phối phương   │
│ án trao trả an toàn trước khi xe nhận nhiều khách mới.      │
│ Công ty thành viên: [ ] VinFast  [x] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác: _______________  │
│                                                             │
│ Ai đang đau (Actor)? Hành khách (lo lắng mất tài sản giá    │
│ trị), Tổng đài viên CSKH (xử lý thủ công nhiều bước),       │
│ Tài xế (bị gián đoạn khi đang chạy cuốc mới).               │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Khách gọi tổng đài hoặc gửi form báo quên đồ trên xe   │
│   → 2. CSKH ghi nhận mô tả đồ vật, vị trí ngồi, mã chuyến đi│
│   → 3. CSKH kiểm tra trạng thái hiện tại của tài xế (đang   │
│        chở khách hay rảnh) và gọi điện/nhắn tin xác minh    │
│   → 4. Ghi chép kết quả xác minh vào CRM và thống nhất cách │
│        nhận lại đồ (gửi Hub Xanh SM hoặc giao tận nơi)      │
│   → 5. Soạn tin nhắn thông báo hướng dẫn nhận đồ cho khách  │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2, 4 & 5 (⏱ 18 phút/  │
│ lượt)                                                       │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2, 4 & 5         │
│ (Chuẩn hóa thông tin đồ thất lạc từ mô tả của khách, tạo    │
│ thông báo kiểm tra nhanh gửi App tài xế khi dừng xe, và     │
│ soạn hướng dẫn thủ tục nhận đồ tại Hub gần nhất)            │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ - Giảm thời gian tiếp nhận & phản hồi đầu tiên từ 18 phút   │
│   ──> dưới 4 phút                                           │
│ - Tăng tỷ lệ liên hệ xác minh với tài xế trong 10 phút đầu  │
│   lên 90%                                                   │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
│ (LLM Feature: Trích xuất thông tin có cấu trúc & soạn tin)  │
└─────────────────────────────────────────────────────────────┘
```

> [!TIP]
> **🤖 AI Prompts — Stress-Test thẻ bài toán:**
> Hãy dán nội dung thẻ bài toán của bạn vào LLM để nhận phản biện:
> *"Đây là một thẻ bài toán vận hành tôi đề xuất cho Vin Smart Future: [Dán nội dung]. Hãy đóng vai trò là một CFO và Trưởng phòng Vận hành cực kỳ khắt khe, chỉ ra cho tôi 3 điểm yếu về logic, metric, và giải thích vì sao rule-based code thông thường có thể giải quyết bài toán này tốt hơn là dùng AI."*

---

# 🏗️ Phase 3 — DEEP-DIVE (Nhóm, 85 min)

## 3.1. Current-State Workflow Mapping (25 min)
**Vẽ quy trình hiện tại lên bảng/giấy A3.** Sử dụng các ký hiệu:
* 🔴 **Bottleneck:** Bước gây tắc nghẽn, tốn thời gian, hoặc sai sót nhiều nhất.
* 🔄 **Handoff:** Điểm chuyển giao thông tin giữa người và hệ thống, hoặc giữa các bộ phận.
* Ghi rõ thời gian vận hành trung bình: **Tổng cộng = ____ phút/lượt**.

## 3.2. Problem Statement (6-field) & Metrics (15 min)
Điền đầy đủ 6 trường thông tin của bài toán:

| Field | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Ai đang thực hiện tác vụ hằng ngày? |
| **2. Current Workflow** | Mô tả tóm tắt quy trình thủ công hiện tại và công cụ sử dụng. |
| **3. Bottleneck** | Bước nào chậm, lỗi, hoặc cần xử lý ngôn ngữ tự động nhiều nhất? |
| **4. Business Impact** | Tổn thất thực tế đo bằng thời gian, chi phí, hoặc SLA của Vingroup. |
| **5. Success Metric** | AI giải quyết được thì đạt ngưỡng số mấy? (Ví dụ: *"85% vé được phân loại dưới 10s"*). |
| **6. Operational Boundary** | AI được phép làm gì, TUYỆT ĐỐI không được làm gì, điểm nào cần duyệt? |

## 3.3. Future-State Flow & AI Fit (25 min)
* **Xác định mức AI Fit (AI-Fit Matrix):** Giải pháp thuộc nhóm nào? [ ] Rule / State-Machine [ ] LLM Feature [ ] Agentic Loop.
* **Vẽ Future-State Flow:** Đánh dấu rõ:
  * 🔵 **AI Step:** Tác vụ LLM xử lý.
  * 🟢 **Human Step (HITL):** Bước con người phê duyệt/review (Human-in-the-loop).
  * ↩️ **Fallback:** Kế hoạch dự phòng khi LLM trả về kết quả lỗi hoặc không tự tin.

---

# 💻 Phase 4 — TECHNICAL PROMPT PROTOTYPE (Nhóm, 30 min)

Để đảm bảo kỹ sư của Vin Smart Future luôn giữ vững năng lực lập trình, nhóm của bạn sẽ tiến hành **lập trình bản mẫu prompt** trực tiếp trên **Gemini 2.5 Flash** bằng Python để stress-test hệ thống.

### Hướng dẫn thực hiện:
1. Mở file [starter-code/prompt_prototype.py](starter-code/prompt_prototype.py) bằng VS Code/Cursor.
2. Hoàn thiện các nội dung sau:
   * **System Prompt:** Viết chỉ thị cực kỳ nghiêm ngặt quy định vai trò, nhiệm vụ, định dạng output và **Operational Boundary (Ranh giới cấm)** của mô hình.
   * **Structured Output:** Định nghĩa định dạng JSON output rõ ràng.
   * **Adversarial Test Cases:** Viết ít nhất 3 prompts "tấn công" (Adversarial inputs) cố tình dụ AI vượt ranh giới hoặc đưa ra câu trả lời không được phép để kiểm tra xem ranh giới của bạn có thực sự vững chắc.
3. Chạy file python:
   ```bash
   python3 prompt_prototype.py
   ```
4. Kiểm tra xem các ranh giới an toàn có bị LLM phá vỡ hay không và ghi lại kết quả vào worksheet.

---

# 🏁 Phase 5 — EVALUATE (Nhóm, 20 min)

### AI Readiness Checklist:
1. [ ] Chúng tôi có sẵn dữ liệu mẫu/logs sạch để test?
2. [ ] Rủi ro khi AI sai có nằm trong tầm kiểm soát (qua HITL hoặc Fallback)?
3. [ ] Stakeholders sẵn sàng thay đổi quy trình làm việc cũ?

### Quyết định cuối cùng của Ban Giám Đốc Vin Smart Future:
[ ] **GO (Bắt đầu xây dựng Prototype):** Bắt đầu phát triển với scope hẹp.
[ ] **NOT YET (Cần tích lũy thêm dữ liệu/xác lập baseline):** Trì hoãn để chuẩn bị thêm.
[ ] **NO-GO (Không khả thi / Rule-based tốt hơn):** Hủy bỏ dự án AI này.

**Justification (Lý giải quyết định dựa trên bằng chứng kỹ thuật và chi phí):**
> *Viết lý giải chi tiết tại đây*

---

# 📝 Phase 6 — REFLECTION (Cá nhân)
*Ghi nhận phản ánh của cá nhân bạn về việc phối hợp với AI trong buổi học hôm nay vào file `03-ai-log.md`.*
