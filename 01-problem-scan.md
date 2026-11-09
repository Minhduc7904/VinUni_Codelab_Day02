# Lab 02 — Deliverable 01: Problem Scan & Quick Cards
**Học viên:** Đỗ Lý Hoàng Nam  
**Đơn vị:** Vin Smart Future (Vingroup)  
**Nhánh:** `DoLyHoangNam`  

---

# 🔍 Phase 1 — SCAN: Tìm kiếm cơ hội (4 Lenses)

Sử dụng 4 thấu kính (*Repetitive, Time-consuming, AI-upgrade, Stakeholder Pain*) để rà soát toàn bộ các mảng vận hành của hệ sinh thái Vingroup:

| # | Subsidiary | Lens | Mô tả ngắn bài toán vận hành | Bottleneck / Rò rỉ hiệu suất hiện tại |
|:---:|:---|:---:|:---|:---|
| **1** | **VinFast** | **Time-consuming & Stakeholder Pain** | **Phân loại & xử lý khiếu nại bảo hành:** Tiếp nhận và phân loại ticket khiếu nại liên quan đến lỗi xe điện/pin qua nhiều kênh. | CSKH phải tra cứu thủ công qua nhiều hệ thống rời rạc để phân loại ticket lỗi xe/pin (mất 25-40 phút/ticket), gây chậm trễ SLA và làm tăng 18% khiếu nại leo thang. |
| **2** | **VinFast** | **Repetitive & AI-upgrade** | **Tra cứu tài liệu kỹ thuật xưởng dịch vụ (Service Workshop RAG):** Hỗ trợ kỹ sư xưởng và thợ máy tra cứu tài liệu, sơ đồ mạch điện và quy trình sửa chữa xe điện. | Kỹ sư mất 3-5 ngày tổng hợp bản tin kỹ thuật mới; thợ máy tra cứu thủ công chậm, làm tăng thời gian xe nằm xưởng thêm ~1.5 giờ/xe. |
| **3** | **Xanh SM (GSM)** | **Stakeholder Pain & Time-consuming** | **Khai báo sự cố & va chạm hiện trường cho tài xế:** Tiếp nhận cuộc gọi/tin báo khẩn cấp khi tài xế gặp va chạm, hỏng hóc hoặc cạn pin giữa đường. | Tài xế phải gọi tổng đài khai báo thủ công khi gặp sự cố, quy trình trao đổi rườm rà gây ách tắc giao thông, trễ giờ và tăng áp lực tâm lý lớn cho tài xế. |
| **4** | **Xanh SM (GSM)** | **Repetitive & AI-upgrade** | **Phân tích đánh giá & sắc thái chuyến xe (Passenger Feedback Sentiment):** Phân tích phản hồi sau chuyến đi của khách hàng để phát hiện dịch vụ bất thường. | Đội vận hành phải lọc thủ công hàng ngàn feedback 1-2 sao mỗi ngày, khiến các khiếu nại nghiêm trọng không được cảnh báo và xử lý nóng kịp thời. |
| **5** | **VinFast** | **Time-consuming** | **Kiểm tra hồ sơ tín dụng mua xe trả góp:** Thẩm định tính hợp lệ và đối soát hồ sơ tài chính của khách hàng đăng ký vay mua xe VinFast. | Nhân viên đối soát thủ công giấy tờ tài chính (60-90 phút/hồ sơ), tỷ lệ sai sót 12% làm kéo dài thời gian bàn giao xe và rò rỉ 5% khách hàng tiềm năng. |

---

# 🃏 Phase 2 — QUICK-ASSESS: 3 Quick Problem Cards

Chọn top 3 bài toán từ danh sách trên để phân tích sơ bộ:

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
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Khách gửi khiếu nại qua App/Hotline                    │
│   ──> 2. CSKH đọc mô tả & tra cứu lịch sử qua CRM/DMS        │
│   ──> 3. Phân loại lỗi phần cứng/phần mềm/pin thủ công       │
│   ──> 4. Gán xưởng dịch vụ gần nhất & gửi tin cho khách      │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2 & 3 (⏱ 25-40 min)   │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2 & 3            │
│ (Trích xuất thông tin xe/lỗi -> Gợi ý phân loại & draft vé) │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                        │
│ Giảm thời gian phân loại từ 30 min ──> dưới 3 min/ticket;   │
│ Giảm tỷ lệ khiếu nại bảo hành leo thang từ 18% ──> dưới 3%. │
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
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```
