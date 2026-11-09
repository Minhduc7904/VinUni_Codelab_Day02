# Lab 02 — Deliverable 03: AI Interaction Log & Reflection
**Học viên:** Đỗ Lý Hoàng Nam  
**Đơn vị:** Vin Smart Future (Vingroup)  
**Nhánh:** `DoLyHoangNam_2A202603777`  
**Chủ đề:** Nhật ký tương tác và phản biện cùng Trí tuệ Nhân tạo (AI as Thought-Partner)  

---

## 🧭 1. Tổng quan: Vai trò của AI trong quá trình làm việc

Trong buổi Lab hôm nay tại **Vin Smart Future**, tôi đã sử dụng AI (Google Gemini / Antigravity Co-pilot) như một **Thought-Partner (Bạn đồng hành tư duy)** để cùng giải quyết bài toán: **Phân loại và điều phối khiếu nại bảo hành xe điện VinFast**.

Thay vì chỉ yêu cầu AI "viết hộ bài làm", tôi đã áp dụng quy trình làm việc phối hợp gồm 3 giai đoạn:
1. **Brainstorm & Quét cơ hội (Diverge):** Sử dụng 4 Lenses để tìm ra các điểm rò rỉ hiệu suất trong hệ sinh thái Vingroup.
2. **Stress-test & Phản biện (Challenge):** Yêu cầu AI đóng vai một CFO và Trưởng phòng Vận hành khắt khe để tìm ra lỗ hổng trong đề xuất.
3. **Thiết lập Ranh giới An toàn (Boundary Engineering):** Cùng AI xây dựng các quy tắc guardrails và thử nghiệm các ca tấn công prompt (Adversarial testing).

---

## 💡 2. Những điểm AI đã hỗ trợ hiệu quả nhất (What AI Did Well)

1. **Cấu trúc hóa luồng tư duy vận hành (Workflow Structuring):**
   - AI giúp bóc tách quy trình xử lý bảo hành hiện tại thành 5 bước rõ ràng, chỉ rõ từng điểm nghẽn (🔴 Bottleneck) tại khâu tra cứu phân mảnh CRM/DMS và các điểm chuyển giao (🔄 Handoff) giữa CSKH và Xưởng dịch vụ.
2. **Chuẩn hóa khung Problem Statement 6-field:**
   - Giúp gắn chặt bài toán kỹ thuật với mục tiêu kinh doanh thực tế của VinFast, định lượng các chỉ số KPI cụ thể: thời gian xử lý giảm từ 35-40 phút xuống dưới 3 phút, giảm tỷ lệ khiếu nại leo thang từ 18% xuống dưới 3%.
3. **Sinh kịch bản tấn công Prompt (Adversarial Test Case Generation):**
   - AI hỗ trợ tạo ra các prompt "bẫy" giả lập khách hàng nóng nảy yêu cầu bồi thường tiền ngay lập tức hoặc tài xế ép hệ thống bỏ qua bước duyệt nháp để kiểm tra tính vững chắc của ranh giới an toàn.

---

## ⚠️ 3. Những lỗi sai, ảo giác (Hallucination) và Xu hướng quá đà của AI

Trong quá trình trao đổi, tôi nhận thấy AI gặp phải 2 vấn đề lớn nếu không được kỹ sư kiểm soát chặt chẽ:

1. **Ảo giác về thẩm quyền (Over-automation / Authority Hallucination):**
   - Ban đầu, AI tự tin đề xuất quy trình tự động 100%: *"Hệ thống AI sẽ tự động phân tích lỗi pin, tự động duyệt bảo hành thay pin mới miễn phí cho khách hàng và tự động xuất hóa đơn bảo hành"*.
   - **Thực tế nguy hiểm:** Trong ngành ô tô và tài chính của VinFast, pin cao áp là linh kiện đắt đỏ nhất (chiếm 30-40% giá trị xe). Một quyết định thay pin phải qua giám định điện áp từng cell thực tế của Kỹ sư xưởng. Nếu để AI tự động duyệt, doanh nghiệp sẽ đối mặt với rủi ro gian lận bảo hành và thất thoát hàng triệu USD.
2. **Bệnh sính công nghệ phức tạp (Over-engineering Bias):**
   - AI từng đề xuất xây dựng kiến trúc "Multi-Agent System" gồm 5 sub-agents: Agent phân tích cảm xúc, Agent tra cứu OBD, Agent đàm phán khách hàng, Agent kiểm tra tồn kho phụ tùng, và Agent giám sát.
   - **Thực tế:** Kiến trúc này quá cồng kềnh, độ trễ cao (> 10s), chi phí API đắt đỏ và tạo ra vô số điểm lỗi tiềm ẩn. Bài toán thực chất chỉ cần một **LLM Feature** trích xuất thực thể kết hợp **Rule-based Router** định tuyến xưởng là đã giải quyết trọn vẹn.

---

## 🛠️ 4. Tôi đã phản biện và điều chỉnh Prompt / Ranh giới như thế nào?

Để khắc phục các điểm yếu trên, tôi đã thực hiện các điều chỉnh then chốt:

1. **Kéo AI về thực tế với tư duy "Problem First, AI Second":**
   - Tôi đã từ chối mô hình Multi-Agent và yêu cầu AI tái cấu trúc theo mô hình tinh gọn: **LLM Classifier + Rule-based Guardrail**.
2. **Thiết lập 2 Ranh giới Vận hành Bắt buộc (Strict Operational Boundaries):**
   - **Quy tắc 1 (Tagging HITL):** Mọi văn bản phản hồi khách hàng do LLM sinh ra **bắt buộc phải có tiền tố `[DRAFT_ONLY]`**. Nếu thiếu tiền tố này, hệ thống backend sẽ chặn không cho phép gửi tin nhắn.
   - **Quy tắc 2 (No Financial / Replacement Commitment):** AI tuyệt đối **không được cam kết bồi thường tiền hoặc hứa hẹn đổi pin miễn phí**. AI chỉ được phép ghi nhận triệu chứng và đề xuất lịch hẹn kiểm tra tại xưởng.
3. **Xây dựng cơ chế Fallback rõ ràng:**
   - Khi độ tự tin của LLM < 80% hoặc khách hàng dùng từ ngữ gay gắt đe dọa pháp lý, AI không được tự xử lý mà phải gắn cờ `CRITICAL_REVIEW` chuyển về Kỹ sư trưởng xưởng.

---

## 🎓 5. Bài học lớn nhất rút ra (Key Takeaway)

> **"Trí tuệ nhân tạo không thay thế kỹ sư, nhưng kỹ sư biết làm chủ và đặt ranh giới cho AI sẽ tạo ra những giải pháp an toàn và hiệu quả gấp 10 lần."**

Giá trị lớn nhất của một **AI Product Engineer** không nằm ở việc viết ra prompt hoa mỹ, mà nằm ở **năng lực thấu hiểu quy trình thực địa, dũng cảm nói KHÔNG với các giải pháp AI phức tạp không cần thiết, và thiết lập những ranh giới an toàn không thể bị phá vỡ.**
