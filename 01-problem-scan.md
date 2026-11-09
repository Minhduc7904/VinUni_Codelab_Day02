# Lab 02 — Deliverable 01: Problem Scan & Quick Cards
**Học viên:** Hoàng Thế Phong  
**Đơn vị:** Vin Smart Future (Vingroup)  
**Nhánh:** `Phong_2A202603832`  

---

# 🔍 Phase 1 — SCAN: Tìm kiếm cơ hội (4 Lenses — Tập trung vào Xanh SM & Vinhomes)

Sử dụng 4 thấu kính (*Repetitive, Time-consuming, AI-upgrade, Stakeholder Pain*) để rà soát chuyên sâu hoạt động vận hành của **Xanh SM (GSM)** và **Vinhomes**:

| # | Subsidiary | Lens | Mô tả ngắn bài toán vận hành | Bottleneck / Rò rỉ hiệu suất hiện tại |
|:---:|:---|:---:|:---|:---|
| **1** | **Vinhomes** | **AI-upgrade & Time-consuming** | **Phân loại & điều phối sự cố kỹ thuật cư dân (Smart Incident Triage):** Tiếp nhận phản ánh sự cố kỹ thuật (điện, nước, thang máy, cảnh quan) kèm mô tả tự do trên App Vinhomes Resident. | CSKH Ban Quản Lý phải đọc và phân loại thủ công (mất 12–15 phút/ticket), tỷ lệ gán nhầm đội kỹ thuật ~18%, gây lãng phí ~950 triệu VNĐ/tháng chi phí nhân sự trên 30 khu đô thị. |
| **2** | **Xanh SM (GSM)** | **Time-consuming & Stakeholder Pain** | **Điều phối xử lý sự cố sạc pin / hết pin thực địa:** Tiếp nhận báo cáo khẩn cấp từ tài xế khi xe lỗi sạc hoặc cạn pin giữa đường để tìm trụ sạc trống hoặc điều xe cứu hộ. | Điều phối viên phải tra cứu thủ công vị trí GPS và tìm trụ sạc VinFast còn trống rồi gõ tay tin nhắn chỉ đường (mất 15 phút/lượt), gây lãng phí ~423 triệu VNĐ/tháng (giờ công điều vận & doanh thu cuốc xe bị lỡ). |
| **3** | **Xanh SM (GSM)** | **Stakeholder Pain & Time-consuming** | **Đối soát & giải trình khiếu nại chênh lệch cước phí:** Xử lý khiếu nại từ khách hàng và tài xế về lệch km, phí chờ, phụ phí cầu đường/sân bay. | Tài xế bị tạm giữ doanh thu 24–48h chờ đối soát; CSKH mất 15 phút/ticket tra cứu chéo log GPS và biên lai BOT, gây tốn ~545 triệu VNĐ/tháng (nhân sự đối soát & hoàn tiền sai). |
| **4** | **Xanh SM (GSM)** | **Time-consuming** | **Xử lý yêu cầu tìm đồ thất lạc (Lost & Found):** Tiếp nhận thông tin khách để quên hành lý/điện thoại trên xe, xác minh với tài xế và hẹn điểm trao trả tại Hub. | Tổng đài viên xử lý thủ công qua nhiều cuộc gọi (mất 18 phút/ca, ~250 ca/ngày), làm chậm thời gian liên hệ tài xế và tốn ~244 triệu VNĐ/tháng chi phí vận hành & quãng đường xe chạy rỗng. |
| **5** | **Vinhomes** | **Repetitive** | **Kiểm duyệt hồ sơ đăng ký thi công & vận chuyển nội khu:** Đối chiếu đơn đăng ký sửa chữa căn hộ và danh mục vật liệu ra vào tòa nhà với quy định PCCC & nội quy BQL. | Nhân viên BQL rà soát thủ công từng bộ hồ sơ (20–30 phút/bộ), gây ứ đọng phê duyệt vào đầu tuần và làm chậm tiến độ nhận nhà của cư dân. |
| **6** | **Xanh SM (GSM)** | **Repetitive** | **Tổng hợp nguyên nhân hủy chuyến giờ cao điểm:** Phân nhóm lý do khách hủy chuyến và tài xế từ chối chuyến từ ghi chú tự do để phát hiện điểm đón (pickup point) sai lệch. | Đội vận hành phải tổng hợp log thủ công cuối ngày nên không kịp thời điều chỉnh tọa độ điểm đón ảo gây hủy chuyến hàng loạt tại các tòa nhà lớn. |

---

# 🃏 Phase 2 — QUICK-ASSESS: 3 Quick Problem Cards (Kèm đánh giá tiết kiệm chi phí)

Chọn top 3 bài toán từ danh sách trên để phân tích sơ bộ và định lượng hiệu quả kinh tế:

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán (1 câu): Tự động phân loại mức độ khẩn cấp và điều │
│ phối phản ánh sự cố kỹ thuật của cư dân về đúng đội bảo trì.│
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [x] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Cư dân (chờ xử lý lâu), Nhân viên      │
│ CSKH Ban Quản Lý (quá tải đọc ticket), Đội kỹ thuật (nhận   │
│ nhầm đầu việc không đúng chuyên môn M&E/PCCC/Cảnh quan).    │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Cư dân gửi phản ánh sự cố (text/ảnh) trên App Resident │
│   ──> 2. CSKH BQL mở từng ticket, đọc mô tả và xem ảnh      │
│   ──> 3. Tra bảng phân công chọn mức ưu tiên & đội kỹ thuật │
│   ──> 4. Gán ticket trên hệ thống kèm ghi chú cho thợ       │
│   ──> 5. Soạn tin nhắn xác nhận thời gian xử lý (SLA)       │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2-4 (⏱ 12 phút/lượt)  │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2-5              │
│ (Trích xuất loại sự cố, độ khẩn cấp -> Gợi ý đội & draft)   │
│                                                             │
│ Đo thành công bằng gì (Metric có số & Tiền tiết kiệm)?      │
│ - Giảm thời gian phân loại & điều phối từ 12 min ──> <2 min │
│ - Giảm tỷ lệ gán nhầm đội kỹ thuật từ 18% ──> dưới 3%      │
│ - Tiết kiệm: ~7.875 giờ CSKH + 2.800 giờ Kỹ thuật/tháng,    │
│   tương đương ~950 triệu VNĐ/tháng (~11,4 tỷ VNĐ/năm).      │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán (1 câu): Tài xế Xanh SM báo cáo sự cố sạc pin /    │
│ hết pin giữa đường cần điều phối cứu hộ hoặc trạm sạc gần.  │
│ Công ty thành viên: [ ] VinFast  [x] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Tài xế (chờ đợi, mất doanh thu),       │
│ Điều phối viên (quá tải tra cứu thủ công giờ cao điểm).     │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Tài xế gọi tổng đài điều vận báo hết pin               │
│   ──> 2. Điều phối viên tra cứu thủ công vị trí xe trên map │
│   ──> 3. Tra cứu thủ công các trạm sạc VinFast còn trụ trống│
│   ──> 4. Viết tin nhắn chỉ dẫn/đường đi gửi qua App tài xế  │
│   ──> 5. Liên hệ đội xe cứu hộ nếu xe đã cạn kiệt pin (<5%) │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 3-4 (⏱ 12 phút/lượt)  │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 3-4              │
│ (Tự động hóa lấy vị trí -> Tra cứu trạm trống -> Draft tin) │
│                                                             │
│ Đo thành công bằng gì (Metric có số & Tiền tiết kiệm)?      │
│ - Giảm thời gian xử lý sự cố từ 15 phút ──> dưới 3 phút.    │
│ - 100% ca pin < 5% tự động kích hoạt xe cứu hộ pin di động. │
│ - Tiết kiệm: ~1.800 giờ công Điều vận/tháng (~153 triệu VNĐ)│
│   + tránh thất thoát ~270 triệu VNĐ doanh thu cuốc xe lỡ    │
│   (Tổng tiết kiệm ~423 triệu VNĐ/tháng ~ 5,1 tỷ VNĐ/năm).   │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán (1 câu): Đối soát dữ liệu lộ trình GPS/phụ phí và  │
│ tự động soạn nháp giải trình khiếu nại cước phí Xanh SM.    │
│ Công ty thành viên: [ ] VinFast  [x] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Tài xế (bị treo doanh thu cuốc xe),    │
│ Khách hàng (bức xúc vì phí phát sinh), Nhân viên CSKH       │
│ Đối soát (mất thời gian tra cứu chéo nhiều màn hình).       │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Khách hàng/Tài xế gửi khiếu nại cước phí qua App/Call  │
│   ──> 2. CSKH mở CMS tra cứu log GPS thực tế & thời gian chờ│
│   ──> 3. Đối chiếu với quy chế tính cước & vé trạm thu phí  │
│   ──> 4. Tính số tiền chênh lệch & trình duyệt hoàn tiền    │
│   ──> 5. Soạn văn bản giải trình chi tiết gửi Khách & Tài xế│
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2, 3 & 5 (⏱ 15 phút)  │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2, 3 & 5         │
│ (Tổng hợp chênh lệch từ log JSON -> Đối chiếu -> Draft thư) │
│                                                             │
│ Đo thành công bằng gì (Metric có số & Tiền tiết kiệm)?      │
│ - Giảm thời gian xử lý mỗi ticket từ 15 phút ──> dưới 3 phút│
│ - Đạt 95% bản nháp giải trình chính xác số liệu ngay lần đầu│
│ - Tiết kiệm: ~5.000 giờ công CSKH/tháng (~425 triệu VNĐ) +  │
│   giảm ~120 triệu VNĐ lỗi hoàn tiền sai (~545 triệu/tháng,  │
│   tương đương ~6,5 tỷ VNĐ/năm).                             │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```
