# AI LOG & REFLECTION – QUÁ TRÌNH LỰA CHỌN VÀ PHÂN TÍCH BÀI TOÁN AI

**Ngày thực hiện:** 09/11/2026  
**Công cụ:** ChatGPT/Codex, GitHub, Web Search  
**Phạm vi:** Vinhomes, Vinmec và VinFast  
**Tài liệu:** [Problem Scan](01-problem-scan.md) · [Deep-Dive Report](02-deep-dive-report.md)

## 1. Quá trình tìm kiếm và lựa chọn bài toán

Tôi sử dụng AI để khảo sát các pain point vận hành tại Vinhomes và Vinmec theo phương pháp **4 Lenses: Repetitive, Time-consuming, AI-upgrade và Stakeholder Pain**.

Ban đầu, AI đề xuất 10 bài toán (5 Vinhomes, 5 Vinmec). Sau khi phân tích tính khả thi, thời gian và lợi ích tài chính, tôi tập trung vào 3 hướng:

- **VH-01:** Phân loại và điều phối phản ánh cư dân.
- **VM-01:** Tự động kiểm tra hồ sơ bảo hiểm/bảo lãnh viện phí.
- **VM-02:** Dự đoán bệnh nhân bỏ hẹn và tối ưu lịch khám.

VM-02 ban đầu được chọn để phân tích sâu vì có khả năng tạo thêm doanh thu thông qua tận dụng công suất khám trống.

Sau đó, tôi chuyển đề tài Deep-Dive sang **VinFast Smart Warranty Triage Co-pilot – Phân loại và điều phối khiếu nại bảo hành xe điện**, tham khảo bài viết của Hoàng Nam trên GitHub và phát triển nội dung theo yêu cầu bài lab.

## 2. Phân tích hiệu quả kinh tế và những điều rút ra

AI hỗ trợ xây dựng các giả định về khối lượng công việc, thời gian xử lý, chi phí nhân sự và khả năng cải thiện sau khi ứng dụng AI.

| Bài toán | Thời gian tiết kiệm/thu hồi | Giá trị ước tính/tháng |
|---|---|---|
| VH-01 | 208 giờ nhân sự | 20,8 triệu đồng |
| VM-01 | 351 giờ nhân sự | 38,61 triệu đồng |
| VM-02 | 52 giờ công suất khám | 46,8 triệu đồng |

**Bài học quan trọng:** Những con số trên chỉ là kịch bản giả định, không phải dữ liệu thực tế của Vingroup. Tiết kiệm thời gian không đồng nghĩa với tăng lợi nhuận.

Để tính ROI chính xác cần xác minh khối lượng công việc, tỷ lệ cải thiện, chi phí triển khai, vận hành AI và phần lợi ích thực sự chuyển thành tiền.

Với VinFast, kịch bản 300 ticket/ngày, giảm thời gian xử lý từ 40 xuống 10 phút/ticket tương đương tiết kiệm lý thuyết 150 giờ/ngày. Tuy nhiên, phép tính phải bao gồm thời gian kiểm duyệt, sửa lỗi và xử lý ngoại lệ.

## 3. AI hỗ trợ phát triển Deep-Dive VinFast như thế nào?

AI hỗ trợ phân tích bài toán thành các thành phần cụ thể:

- **Business Flow:** Tiếp nhận khiếu nại → tra cứu thông tin → phân loại → đề xuất xưởng → nhân viên xác nhận.
- **Giải pháp kỹ thuật:** LLM xử lý ngôn ngữ và tạo nháp; Rule Engine kiểm tra điều kiện nghiệp vụ; nhân viên phê duyệt trước khi thực hiện.
- **KPI:** Thời gian xử lý ticket, độ chính xác phân loại, tỷ lệ đề xuất xưởng đúng và tỷ lệ phải chuyển xử lý thủ công.
- **An toàn:** Không tự kết luận lỗi kỹ thuật, quyết định bảo hành, bồi thường hoặc gửi phản hồi khi chưa được phê duyệt.

AI cũng hỗ trợ đối chiếu báo cáo với rubric G1–G4, chỉnh sửa cấu trúc, bổ sung nguồn tham khảo và làm rõ cách đo lường.

## 4. Những hạn chế và điều chỉnh sau khi làm việc với AI

| Vấn đề | Điều chỉnh |
|---|---|
| Số liệu tham khảo dễ bị hiểu thành dữ liệu nội bộ | Gắn nhãn giả định/chưa xác minh |
| Mục tiêu xử lý dưới 3 phút quá lạc quan | Đề xuất pilot ≤ 10 phút/ticket |
| LLM có thể tự suy diễn mã lỗi OBD | Chỉ sử dụng dữ liệu chẩn đoán đã xác minh |
| Confidence do LLM tự đưa ra chưa đáng tin | Kiểm tra bằng dữ kiện, schema và đánh giá thực nghiệm |
| Nhãn `[DRAFT_ONLY]` không đảm bảo an toàn | Kiểm soát quyền thực thi tại backend và bắt buộc phê duyệt |
| KPI chưa có mẫu số rõ ràng | Tách độ chính xác đề xuất và tỷ lệ bao phủ |

Tôi nhận ra rằng **prompt tốt chưa đủ tạo thành hệ thống AI đáng tin cậy**. Cần kết hợp kiểm tra đầu ra, phân quyền backend, human-in-the-loop và kiểm thử thực tế.

## 5. Kết quả đạt được và những việc chưa hoàn thành

**Đã thực hiện:**
- Khảo sát 10 bài toán và lựa chọn 3 hướng tiềm năng.
- Xây dựng mô hình giả định về thời gian, tài chính và ROI.
- Chuyển hướng và hoàn thiện bản thảo Deep-Dive cho VinFast.
- Thiết kế kiến trúc AI, system prompt, JSON mẫu và 6 tình huống kiểm thử đối kháng.
- Kiểm tra cú pháp JSON và rà soát báo cáo theo rubric.

**Chưa thực hiện hoặc chưa có bằng chứng:**
- Chưa xác minh số liệu nội bộ với stakeholder.
- Chưa chạy prototype Gemini và thu thập log kiểm thử thực tế.
- Chưa tích hợp CRM/DMS hoặc đánh giá trên dữ liệu vận hành.
- Chưa có cơ sở xác nhận ROI thực tế hay khả năng triển khai production.

Vì vậy, trạng thái hiện tại là **NOT YET cho pilot vận hành**.

## 6. Reflection – Bài học cá nhân

Qua quá trình làm việc với AI, tôi rút ra ba bài học chính:

1. **Bắt đầu từ pain point, không bắt đầu từ công nghệ.** Cần hiểu quy trình vận hành, người chịu ảnh hưởng và giá trị kinh doanh trước khi chọn giải pháp AI.
2. **Phân biệt giả định với bằng chứng.** AI giúp tính toán, phân tích và viết báo cáo nhanh nhưng không đảm bảo dữ liệu đầu vào đúng. Mọi ROI đều cần baseline thực tế.
3. **AI phải có giới hạn trách nhiệm.** LLM nên hỗ trợ hiểu nội dung và đề xuất; các quyết định quan trọng cần rule kiểm soát và con người xác nhận.

**Điểm tôi thấy hữu ích nhất:** AI giúp chuyển một ý tưởng chung thành bài toán có quy trình, KPI, giả định tài chính, kiến trúc và kế hoạch kiểm thử rõ ràng. Tuy nhiên, tôi cần tự hiểu, đánh giá và xác minh kết quả thay vì phụ thuộc hoàn toàn vào nội dung AI tạo ra.

## 7. Hướng phát triển tiếp theo

Tôi dự kiến xây dựng prototype VinFast bằng dữ liệu giả lập, chạy các tình huống hợp lệ và đối kháng, ghi log kết quả, so sánh với baseline rule-only và cải thiện thiết kế. Sau đó mới xem xét đánh giá với dữ liệu được cấp quyền và quyết định điều kiện chuyển sang pilot.

**Kết luận:** AI đã hỗ trợ hiệu quả trong quá trình Problem Discovery, Business Analysis và Solution Design. Kết quả hiện tại là một bản thiết kế và phân tích có cấu trúc, chưa phải giải pháp đã được kiểm chứng. Giá trị thực sự chỉ có thể khẳng định sau khi đo lường và thử nghiệm trong điều kiện thực tế.