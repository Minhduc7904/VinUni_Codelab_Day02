# Lab 02 — Deliverable 01: Problem Scan & Quick Cards
**Học viên:** Đỗ Lý Hoàng Nam  
**Đơn vị:** Vin Smart Future (Vingroup)  
**Nhánh:** `DoLyHoangNam_2A202603777`  

---

# 🔍 Phase 1 — SCAN: Tìm kiếm cơ hội (4 Lenses)

Sử dụng 4 thấu kính (*Repetitive, Time-consuming, AI-upgrade, Stakeholder Pain*) để rà soát toàn bộ các mảng vận hành của hệ sinh thái Vingroup.  
*(Ghi chú: Toàn bộ số liệu thời gian và tỷ lệ tổn thất dưới đây được xây dựng dựa trên phương pháp Desk Research kết hợp với [Giả định mô phỏng vận hành]*).

| # | Subsidiary | Lens | Mô tả ngắn bài toán vận hành | Điểm nghẽn (Bottleneck) hiện tại |
|:---:|:---|:---:|:---|:---|
| **1** | **VinFast** | **Time-consuming & Stakeholder Pain** | **Phân loại & xử lý khiếu nại bảo hành:** Tiếp nhận và phân loại ticket khiếu nại liên quan đến lỗi xe điện/pin qua nhiều kênh. | CSKH phải tra cứu thủ công qua nhiều hệ thống rời rạc (CRM, DMS, log pin) để phân loại lỗi xe/pin (mất trung bình 40 phút/ticket) *[Giả định]*, gây trễ cam kết SLA và làm tăng 18% khiếu nại leo thang. |
| **2** | **VinFast** | **Repetitive & AI-upgrade** | **Tra cứu tài liệu kỹ thuật xưởng dịch vụ (Service Workshop RAG):** Hỗ trợ kỹ sư xưởng và thợ máy tra cứu tài liệu, sơ đồ mạch điện và quy trình sửa chữa xe điện. | Kỹ sư mất 3-5 ngày tổng hợp bản tin kỹ thuật mới; thợ máy tra cứu thủ công chậm, làm tăng thời gian xe nằm xưởng thêm ~1.5 giờ/xe *[Giả định]*. |
| **3** | **Xanh SM (GSM)** | **Stakeholder Pain & Time-consuming** | **Khai báo sự cố & va chạm hiện trường cho tài xế:** Tiếp nhận cuộc gọi/tin báo khẩn cấp khi tài xế gặp va chạm, hỏng hóc hoặc cạn pin giữa đường. | Tài xế phải gọi tổng đài khai báo thủ công khi gặp sự cố, quy trình trao đổi rườm rà (12-15 phút/cuộc gọi) gây ách tắc giao thông và tăng áp lực tâm lý lớn cho tài xế *[Giả định]*. |
| **4** | **Xanh SM (GSM)** | **Repetitive & AI-upgrade** | **Phân tích đánh giá & sắc thái chuyến xe (Passenger Feedback Sentiment):** Phân tích phản hồi sau chuyến đi của khách hàng để phát hiện dịch vụ bất thường. | Đội vận hành phải lọc thủ công hàng ngàn feedback 1-2 sao mỗi ngày, độ trễ 24-48 giờ khiến các khiếu nại nghiêm trọng không được cảnh báo và xử lý nóng kịp thời *[Giả định]*. |
| **5** | **VinFast** | **Time-consuming** | **Kiểm tra hồ sơ tín dụng mua xe trả góp:** Thẩm định tính hợp lệ và đối soát hồ sơ tài chính của khách hàng đăng ký vay mua xe VinFast. | Nhân viên đối soát thủ công giấy tờ tài chính (60-90 phút/hồ sơ), tỷ lệ sai sót 12% làm kéo dài thời gian bàn giao xe và rò rỉ khoảng 5% khách hàng tiềm năng *[Giả định]*. |

---

# 🃏 Phase 2 — QUICK-ASSESS: 3 Quick Problem Cards

Chọn top 3 bài toán từ danh sách trên để phân tích sơ bộ:

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán (1 câu): Tự động trích xuất triệu chứng, phân loại  │
│ danh mục kỹ thuật và dự thảo phân luồng ticket bảo hành xe. │
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
│ (Trích xuất thực thể -> Gợi ý phân luồng -> Draft tin nháp) │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                        │
│ Giảm thời gian xử lý ticket từ 40 min ──> dưới 3 min/ticket;│
│ Giảm tỷ lệ khiếu nại bảo hành leo thang từ 18% ──> dưới 3%. │
│ [Toàn bộ số liệu là Giả định thiết kế KPI cho dự án]        │
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
