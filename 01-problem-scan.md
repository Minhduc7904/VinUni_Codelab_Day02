# Problem Scan & Quick Cards — Vinpearl / VinWonders / Vinmec

> **Người thực hiện:** Nguyễn Minh Đức — AI Engineer, Vin Smart Future
> **Phạm vi quét:** Vinpearl, VinWonders, Vinmec
> **Tiêu chí lọc:** chỉ giữ bài toán (1) có dữ liệu đầu vào khách quan (giao dịch, cảm biến, hình ảnh, hồ sơ công việc), (2) kết quả kiểm chứng được bằng số, (3) tác động kinh doanh rõ ràng. Loại các bài toán phải *đoán ý định con người* (ví dụ: dự đoán khách có quay lại hay không).
> **Lưu ý về số liệu:** Doanh thu thuần hợp nhất Vinpearl 2025 là 15.539 tỷ đồng (Báo cáo thường niên Vinpearl 2025). Mọi con số còn lại (tỷ lệ thất thoát, chi phí năng lượng, ngân sách nguyên liệu, thời gian xử lý) là **giả định để sàng lọc ý tưởng**, chưa được Vingroup xác nhận và cần đo baseline thực tế trước khi triển khai. Vinmec không có số liệu nội bộ nên dùng mô hình một cơ sở y tế giả định.

---

# 🔍 Phase 1 — SCAN: Tìm kiếm cơ hội (Cá nhân)

Dùng 4 Lenses (Lặp lại, Tốn thời gian, AI-upgrade, Pain từ người khác) quét vận hành của các công ty thành viên Vingroup.

| # | Subsidiary | Lens | Mô tả ngắn bài toán |
|---|------------|------|---------------------|
| 1 | **Vinpearl** | Lặp lại | **Phát hiện thất thoát doanh thu.** Mỗi giao dịch đi qua nhiều hệ thống (booking, giá/khuyến mãi, thanh toán, hóa đơn, đối soát đối tác) nên dễ sai hoa hồng, sai giá theo hợp đồng, hoàn tiền trùng hoặc lệch giữa thanh toán và hóa đơn. Bộ phận tài chính phải đối soát hàng triệu giao dịch theo nhiều bộ hợp đồng khác nhau, khó kiểm tra toàn bộ bằng tay. |
| 2 | **Vinpearl / VinWonders** | AI-upgrade | **Tối ưu năng lượng resort.** Chiller, bơm nước, thông gió và làm mát vận hành theo lịch cố định, trong khi hiệu suất thay đổi theo nhiệt độ ngoài trời và mức tải. Cùng một nhu cầu làm lạnh nhưng các tổ hợp chiller khác nhau tiêu thụ lượng điện khác nhau. |
| 3 | **Vinmec** | Pain từ người khác | **Bệnh nhân bị bỏ sót trong quy trình theo dõi.** Chỉ định xét nghiệm bổ sung hoặc tái khám đã được ghi nhưng chưa có kết quả hoặc hành động tiếp theo, không có cơ chế nhắc đúng người phụ trách. Yêu cầu theo dõi còn nằm trong ghi chú tự do của bác sĩ, hệ thống nhắc lịch thông thường không đọc được. |
| 4 | **Vinmec** | Tốn thời gian | **Điều phối giường bệnh và luồng điều trị.** Giường trống nhưng chưa sẵn sàng, bệnh nhân chờ chuyển khoa, kế hoạch xuất viện cập nhật chậm, các bộ phận không đồng bộ trạng thái nên điều phối giữa nhiều khoa mất nhiều thời gian. |
| 5 | **Vinpearl / VinWonders** | Pain từ người khác | **Lãng phí thực phẩm tại buffet.** Món hết sớm ở chỗ này, dư nhiều ở chỗ khác, nguyên liệu đã sơ chế không dùng đến. Bếp và quản lý nhà hàng chỉ dựa vào kinh nghiệm, khó biết chính xác món nào gây lãng phí lớn nhất. |

---

# 🃏 Phase 2 — QUICK-ASSESS: 3 Quick Problem Cards (Cá nhân)

Chọn top 3 từ danh sách SCAN: **#1 (Vinpearl — Thất thoát doanh thu), #3 (Vinmec — Theo dõi bệnh nhân), #2 (Vinpearl — Năng lượng).**

## Card #1 — Vinpearl: Phát hiện thất thoát doanh thu

```text
┌─────────────────────────────────────────────────────────────
│ QUICK PROBLEM CARD #1
│
│ Bài toán: Đối soát giao dịch với điều khoản hợp đồng đối tác
│ để phát hiện sai hoa hồng, sai giá, hoàn tiền trùng.
│ Công ty thành viên: [x] Khác: Vinpearl / VinWonders
│
│ Ai đang đau? Nhân viên kế toán/kiểm soát doanh thu (đối soát
│ thủ công), bộ phận tài chính (thất thoát khó phát hiện).
│
│ Workflow thủ công hiện tại (5 bước):
│   1. Xuất dữ liệu giao dịch từ booking/thanh toán/hóa đơn
│   → 2. Mở hợp đồng đối tác, đọc điều khoản giá, chiết khấu,
│        hoa hồng
│   → 3. Đối chiếu giao dịch với điều khoản (Excel, chủ yếu
│        lấy mẫu)
│   → 4. Lập danh sách chênh lệch nghi vấn
│   → 5. Xác minh với đối tác, điều chỉnh/thu hồi
│
│ Bước nào tốn nhất? Bước 2-3 (đọc nhiều hợp đồng có điều khoản
│ khác nhau, không đối chiếu hết được hàng triệu giao dịch)
│ (⏱ cần đo baseline; giả định vài ngày công mỗi kỳ đối soát)
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2 (đọc hợp đồng,
│ trích xuất điều khoản), bước 3 (đối chiếu toàn bộ giao dịch),
│ bước 4 (tổng hợp bằng chứng cho người xác minh).
│
│ Đo thành công bằng gì (Metric có số)?
│   - Tổng số tiền chênh lệch đã xác minh và thực sự thu hồi
│     được (KPI chính).
│   - Kịch bản minh họa: thu hồi 0,1% - 0,5% doanh thu
│     (~15,5 - 77,7 tỷ đồng/năm trên 15.539 tỷ, giả định).
│   - Độ chính xác điều khoản trích xuất >= 95%;
│     tỷ lệ cảnh báo đúng (precision) >= 80%.
│
│ Quick Architecture: [x] Rule  [x] LLM  [ ] Agent
│   (LLM/Document AI chỉ đọc hợp đồng để trích xuất điều khoản;
│    Rule Engine đối chiếu; Isolation Forest bắt bất thường.
│    AI chỉ cảnh báo, nhân viên tài chính quyết định.)
└─────────────────────────────────────────────────────────────
```

## Card #3 — Vinmec: Theo dõi bệnh nhân bị bỏ sót

```text
┌─────────────────────────────────────────────────────────────
│ QUICK PROBLEM CARD #3
│
│ Bài toán: Phát hiện các chỉ định theo dõi (xét nghiệm bổ sung,
│ tái khám) chưa hoàn tất để nhắc đúng người phụ trách.
│ Công ty thành viên: [x] Vinmec
│
│ Ai đang đau? Bác sĩ/điều dưỡng phụ trách (không có công cụ
│ nhắc việc), bệnh nhân (chậm được theo dõi), bệnh viện (rủi ro
│ an toàn chẩn đoán).
│
│ Workflow thủ công hiện tại (5 bước):
│   1. Bác sĩ khám, chỉ định xét nghiệm/theo dõi (ghi chú tự do)
│   → 2. Xét nghiệm thực hiện, kết quả về hệ thống
│   → 3. Bác sĩ đánh giá kết quả khi có thời gian
│   → 4. Ghi nhận chỉ định theo dõi, hẹn tái khám
│   → 5. Nhân viên liên hệ bệnh nhân (nếu có người nhớ)
│
│ Bước nào tốn nhất? Bước 3-5 (không có cơ chế phát hiện việc
│ quá hạn chưa xử lý; phụ thuộc trí nhớ cá nhân)
│ (⏱ cần đo baseline; giả định một phần chỉ định bị chậm/bỏ sót)
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 1 (trích xuất yêu
│ cầu theo dõi từ ghi chú), bước 3-5 (kiểm tra việc quá hạn,
│ tạo cảnh báo cho người phụ trách).
│
│ Đo thành công bằng gì (Metric có số)?
│   - Tỷ lệ chỉ định theo dõi xử lý đúng hạn: baseline (cần đo)
│     lên >= 95%.
│   - Tỷ lệ cảnh báo sai < 20%.
│   - Thời gian trung bình đóng một vòng theo dõi giảm 30%.
│
│ Quick Architecture: [x] Rule  [x] LLM  [ ] Agent
│   (Rule Engine kiểm tra hạn/trạng thái; LLM chỉ đọc ghi chú
│    để trích xuất yêu cầu theo dõi. Không chẩn đoán, không
│    quyết định điều trị, chỉ cảnh báo nhân viên y tế.)
└─────────────────────────────────────────────────────────────
```

## Card #2 — Vinpearl / VinWonders: Tối ưu năng lượng

```text
┌─────────────────────────────────────────────────────────────
│ QUICK PROBLEM CARD #2
│
│ Bài toán: Chọn tổ hợp chiller và cấu hình vận hành tiêu thụ
│ ít điện nhất mà vẫn đảm bảo nhiệt độ, độ ẩm và giới hạn kỹ
│ thuật, thay vì chạy theo lịch cố định.
│ Công ty thành viên: [x] Khác: Vinpearl / VinWonders
│
│ Ai đang đau? Kỹ sư vận hành tòa nhà (tự cân nhắc cấu hình),
│ ban quản lý resort (hóa đơn điện lớn).
│
│ Workflow thủ công hiện tại (4 bước):
│   1. Vận hành chiller theo lịch cố định/kinh nghiệm
│   → 2. Kỹ sư theo dõi thông số trên hệ thống BMS
│   → 3. Điều chỉnh thủ công khi nhiệt độ/tải thay đổi
│   → 4. Cuối tháng đọc hóa đơn điện để đánh giá
│
│ Bước nào tốn nhất? Bước 3 (chọn tổ hợp chiller theo tải và
│ thời tiết, khó tìm cấu hình tối ưu bằng kinh nghiệm)
│ (⏱ cần đo baseline; đo bằng kWh/tấn lạnh)
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 3 (dự báo tiêu thụ
│ điện và đề xuất cấu hình tối ưu cho kỹ sư phê duyệt).
│
│ Đo thành công bằng gì (Metric có số)?
│   - Giảm kWh/tấn lạnh 5-10% so với baseline (đã hiệu chỉnh
│     theo tải làm lạnh và thời tiết).
│   - Kịch bản minh họa: chi phí năng lượng 200 tỷ/năm (giả
│     định), tiết kiệm 10 - 20 tỷ.
│   - Thời gian vận hành trong giới hạn kỹ thuật >= 99%.
│
│ Quick Architecture: [x] Rule  [ ] LLM  [ ] Agent
│   (Thực chất là ML dự báo chuỗi thời gian + tối ưu toán học,
│    không phải LLM. Kỹ sư phê duyệt trước khi áp dụng.)
└─────────────────────────────────────────────────────────────
```

---

## Lý do chọn và loại các bài toán còn lại

* **Chọn #1, #3, #2:** cả ba có dữ liệu khách quan, kiểm chứng được bằng số (tiền thu hồi, tỷ lệ theo dõi đúng hạn, kWh), không cần đoán ý định con người, và có thể thử nghiệm ở phạm vi hẹp (một nhóm đối tác, một chuyên khoa, một hệ thống chiller).
* **Loại #4 (Vinmec — Điều phối giường):** tác động hệ thống lớn nhưng phụ thuộc dữ liệu liên thông giữa các khoa và độ chính xác của trạng thái giường, tích hợp phức tạp, khó làm MVP trong thời gian ngắn. Lưu ý không được tối đa hóa tỷ lệ lấp đầy mà bỏ công suất dự phòng cấp cứu.
* **Loại #5 (Food Waste):** khả thi và dễ thử nghiệm nhưng cần camera, cân điện tử và dữ liệu POS, nặng về phần cứng và phần AI chủ yếu là Computer Vision/dự báo, không phù hợp với hướng prototype LLM của lab này.
* **Thứ tự ưu tiên mang vào buổi họp nhóm:** #1 (đo tác động tài chính rõ nhất, có phần LLM tự nhiên ở bước đọc hợp đồng), tiếp theo #3. Bài #2 mạnh về giá trị nhưng không dùng LLM.
* **Điều kiện trước khi chọn chính thức (#1):** phải kiểm tra hệ thống hiện tại đã đối soát tự động đến đâu. Nếu gần như mọi giao dịch đã được kiểm tra bằng quy tắc đầy đủ thì AI không tạo thêm nhiều giá trị.
