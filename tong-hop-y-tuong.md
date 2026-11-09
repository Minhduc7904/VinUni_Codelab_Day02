# Tổng hợp ý tưởng của nhóm — Top 3 bài toán cho Deep-Dive

> **Nguồn:** các branch trên GitHub tại 09/11/2026 (đã fetch lại).
> **Ý tưởng hiện có:** 15 bài toán từ 3 thành viên (Nguyễn Minh Đức, Đỗ Lý Hoàng Nam, Nguyễn Đức Minh). Branch `Phong_2A202603832` vẫn chưa có thay đổi nào so với `main`.
> **Điểm số là nhận định của người tổng hợp**, dùng để nhóm có cơ sở thảo luận, chưa qua khảo sát nội bộ Vingroup.

---

## 1. Các branch đã kiểm tra

| Branch | Thành viên | Trạng thái |
|---|---|---|
| `nguyenminhduc/2A202603751` | Nguyễn Minh Đức | `01-problem-scan.md` (Phase 1-2) + `ytuong.md` |
| `DoLyHoangNam_2A202603777` | Đỗ Lý Hoàng Nam | `01-problem-scan.md` (Phase 1-2) |
| `NguyenDucMinh2A202603765` | Nguyễn Đức Minh | `01-problem-scan.md` (Phase 1-2, có tính tác động bằng số) |
| `Phong_2A202603832` | Phong | Chưa có thay đổi (giống `main`) |

---

## 2. Tiêu chí chấm điểm

Ba tiêu chí, mỗi tiêu chí 1-5 điểm, **tổng tối đa 15**, các tiêu chí có trọng số bằng nhau.

| Điểm | Khả thi | Doanh thu (tăng thêm hoặc thu hồi được) | Tiết kiệm (chi phí, giờ công, lãng phí) |
|:-:|---|---|---|
| 5 | Dữ liệu sẵn có, tích hợp đơn giản, rủi ro khi AI sai thấp | ≥ 10 tỷ đồng/năm | ≥ 10 tỷ đồng/năm |
| 4 | Cần thêm một ít dữ liệu hoặc tích hợp vừa phải | 3 đến dưới 10 tỷ | 3 đến dưới 10 tỷ |
| 3 | Cần cấp quyền dữ liệu hoặc rủi ro trung bình | 1 đến dưới 3 tỷ | 1 đến dưới 3 tỷ |
| 2 | Phụ thuộc tích hợp lớn, hoặc rủi ro cao | Dưới 1 tỷ, hoặc có cơ chế rõ nhưng chưa định lượng | Dưới 1 tỷ, hoặc có thật nhưng chưa định lượng |
| 1 | Phụ thuộc hạ tầng liên thông lớn và rủi ro cao | Không tạo doanh thu | Không đáng kể |

Giá trị lấy từ kịch bản trong file nguồn của từng bạn. Dấu **(\*)** nghĩa là file nguồn chưa có số lượng giao dịch hoặc ticket, nên điểm là **tạm tính theo nhận định**, cần bổ sung dữ liệu.

---

## 3. Bảng chấm điểm 15 ý tưởng

| Hạng | # | Ý tưởng | Công ty | Người | Khả thi | Doanh thu | Tiết kiệm | **Tổng** |
|---:|---|---|---|---|:-:|:-:|:-:|:-:|
| 1 | A1 | Phát hiện thất thoát doanh thu | Vinpearl | Đức | 4 | 5 | 2 | **11** |
| 2 | A2 | Tối ưu năng lượng resort | Vinpearl/VinWonders | Đức | 4 | 1 | 5 | **10** |
| 2 | A5 | Giảm lãng phí thực phẩm buffet | Vinpearl/VinWonders | Đức | 4 | 1 | 5 | **10** |
| 4 | B1 | Phân loại ticket bảo hành | VinFast | Nam | 4 | 2\* | 3\* | 9 |
| 4 | B2 | RAG tài liệu kỹ thuật xưởng | VinFast | Nam | 3 | 3\* | 3\* | 9 |
| 4 | B4 | Sắc thái đánh giá 1-2 sao | Xanh SM | Nam | 5 | 2\* | 2\* | 9 |
| 4 | B5 | Kiểm tra hồ sơ tín dụng mua xe | VinFast | Nam | 3 | 3\* | 3\* | 9 |
| 8 | A4 | Điều phối giường bệnh | Vinmec | Đức | 2 | 4 | 2 | 8 |
| 8 | B3 | Sự cố và cạn pin tài xế | Xanh SM | Nam | 4 | 2\* | 2\* | 8 |
| 8 | C2 | Kiểm tra hồ sơ bảo lãnh viện phí | Vinmec | Minh | 4 | 2 | 2 | 8 |
| 11 | C1 | Phân loại phản ánh cư dân | Vinhomes | Minh | 4 | 1 | 2 | 7 |
| 11 | C3 | Dự đoán bỏ hẹn, lấp lịch khám | Vinmec | Minh | 4 | 2 | 1 | 7 |
| 11 | C5 | Kiểm tra hồ sơ đăng ký cư dân, thẻ ra vào | Vinhomes | Minh | 4 | 1 | 2\* | 7 |
| 14 | C4 | Điều phối yêu cầu sửa chữa | Vinhomes | Minh | 3 | 1 | 2\* | 6 |
| 15 | A3 | Theo dõi bệnh nhân bị bỏ sót | Vinmec | Đức | 3 | 1 | 1 | 5 |

C4 và C5 của Minh chỉ có ở Phase 1 (chưa có Quick Card và chưa có số liệu), nên điểm là tạm tính. Các số liệu nền như sau:

* **A1:** kịch bản thu hồi 0,1-0,5% trên doanh thu thuần hợp nhất 15.539 tỷ của Vinpearl 2025, tương đương 15,5-77,7 tỷ/năm. Phần tiết kiệm giờ đối soát chưa định lượng.
* **A2:** giả định chi phí năng lượng 200 tỷ/năm, tiết kiệm 5-10% là 10-20 tỷ.
* **A5:** giả định ngân sách nguyên liệu 300 tỷ/năm, giảm 3-8% là 9-24 tỷ.
* **A4:** giả định 500 giường, tăng 2 điểm % công suất là khoảng 7,3 tỷ/năm.
* **C1:** 20,8 triệu đồng/tháng, khoảng 0,25 tỷ/năm.
* **C2:** 38,61 triệu đồng/tháng, khoảng 0,46 tỷ/năm.
* **C3:** tối đa 46,8 triệu đồng/tháng, khoảng 0,56 tỷ/năm.

---

## 4. Top 3 theo tiêu chí mới

### 🥇 1. A1 — Phát hiện thất thoát doanh thu (Vinpearl) — 11/15

* **Vấn đề:** mỗi giao dịch đi qua nhiều hệ thống (booking, giá, thanh toán, hóa đơn, đối soát đối tác) nên dễ sai hoa hồng, sai giá theo hợp đồng, hoàn tiền trùng. Tài chính không đối soát hết hàng triệu giao dịch bằng tay.
* **AI làm gì:** Document AI/LLM đọc hợp đồng, trích xuất điều khoản; Rule Engine đối chiếu giao dịch; mô hình bất thường bắt phần quy tắc chưa phủ; nhân viên tài chính xác minh.
* **Điểm mạnh:** là ý tưởng duy nhất đạt 5 điểm ở Doanh thu, và là bài duy nhất trong top 3 có phần LLM tự nhiên.
* **Phản biện:** nếu hệ thống hiện tại đã đối soát tự động bằng quy tắc đầy đủ thì AI thêm được ít giá trị. Phần đối chiếu giao dịch bản chất là rule, LLM chỉ cần ở bước đọc hợp đồng. Cần xác nhận có truy cập được hợp đồng và giao dịch mẫu hay không.

### 🥈 2. A2 — Tối ưu năng lượng resort (Vinpearl/VinWonders) — 10/15

* **Vấn đề:** chiller, bơm, thông gió vận hành theo lịch cố định, trong khi hiệu suất thay đổi theo nhiệt độ và tải. Cùng nhu cầu làm lạnh nhưng các tổ hợp chiller tiêu thụ điện khác nhau.
* **AI làm gì:** ML dự báo tiêu thụ điện, tối ưu toán học chọn cấu hình, kỹ sư phê duyệt rồi áp dụng.
* **Điểm mạnh:** kết quả đo thẳng bằng đồng hồ điện (kWh/tấn lạnh), dễ chứng minh.
* **Phản biện:** không dùng LLM nên khó nối với phần prototype của lab. Cần có hệ thống BMS và dữ liệu đo lịch sử; con số 200 tỷ là giả định, không phải ngân sách công bố.

### 🥈 2. A5 — Giảm lãng phí thực phẩm buffet (Vinpearl/VinWonders) — 10/15

* **Vấn đề:** món hết sớm ở chỗ này, dư ở chỗ khác; nguyên liệu sơ chế không dùng đến; bếp chỉ dựa vào kinh nghiệm.
* **AI làm gì:** Computer Vision và cân điện tử đo thực phẩm thừa, ML dự báo nhu cầu, tối ưu lượng chế biến.
* **Điểm mạnh:** thử nghiệm được ở một nhà hàng, đo trực tiếp lượng thực phẩm thừa trên mỗi suất ăn.
* **Phản biện:** cần camera, cân điện tử và dữ liệu POS, nặng về phần cứng. Không dùng LLM. Con số 300 tỷ là giả định.

> Hai bài A2 và A5 đồng điểm 10 nên đều đứng hạng 2. Nhóm chọn một trong hai cho vị trí thứ ba, hoặc xét thêm bài B1/B2 bên dưới.

---

## 5. Lưu ý quan trọng khi đọc thứ hạng

1. **Quy mô các kịch bản không so sánh ngang được.** Ý tưởng của Đức (A1, A2, A5) tính theo quy mô toàn doanh nghiệp (200-300 tỷ ngân sách giả định), trong khi Minh tính theo quy mô một cơ sở pilot (vài chục triệu đồng/tháng). Điểm của A2/A5 so với C1/C2/C3 vì vậy chênh lệch lớn, phần nhiều do cách đặt giả định chứ chưa chắc do bài toán tốt hơn. Cần quy về cùng một phạm vi (ví dụ cùng là một cơ sở pilot) trước khi chốt.
2. **Số liệu của Nam (dấu \*)** gồm 25-40 phút/ticket, 18% khiếu nại leo thang, 12% sai sót hồ sơ, 5% khách tiềm năng rò rỉ đều chưa có nguồn và chưa có số lượng ticket/hồ sơ, nên điểm Doanh thu và Tiết kiệm của B1-B5 chỉ là tạm tính.
3. **Tiêu chí mới không đo độ hợp LLM.** Theo tiêu chí này A2 và A5 lên top dù không dùng LLM, trong khi bài lab yêu cầu prototype prompt bằng Gemini. Nếu nhóm cần bài toán có phần LLM rõ, thứ tự là **A1 (11), rồi B1/B2/B5 (9)**.
4. **A3 (Theo dõi bệnh nhân)** chỉ được 5 điểm vì giá trị chính của nó là an toàn bệnh nhân, không nằm trong ba tiêu chí này.
5. **B3 (Sự cố tài xế Xanh SM)** gần như trùng ví dụ giảng viên trong `02-deliverable-example.md`, nhưng khớp trực tiếp với code `prompt_prototype.py`.

---

## 6. Việc cần nhóm chốt

1. Thống nhất phạm vi tính giá trị (cùng quy mô pilot) để chấm lại cho công bằng.
2. Quyết định có yêu cầu bài toán phải dùng LLM hay không.
3. Hỏi Phong về tiến độ vì branch chưa có nội dung.
4. Với bài được chọn, thu thập số liệu baseline thật để thay các con số giả định.
