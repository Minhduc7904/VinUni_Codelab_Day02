# AI Log & Reflection — Lab 02: AI Product Scoping

> **Người viết:** Nguyễn Minh Đức (2A202603751) — Nhóm 101
> **AI đã dùng:** Claude Code (trợ lý lập trình trong VS Code) để làm Phase 3–5, prototype và tài liệu; một trợ lý AI chat để brainstorm ở Phase 1–2 (kết quả nằm trong `ytuong.md`).
> **Cách dùng:** AI là người đồng hành để soạn thảo và phản biện. Tôi quyết định đề tài, ranh giới và số liệu cuối cùng.

---

## 1. AI đã giúp được gì

| Phần việc | AI giúp thế nào | Tôi làm gì |
|---|---|---|
| Phase 1–2: quét bài toán, 3 Quick Cards | Gợi ý 5 bài toán cho Vinpearl/VinWonders/Vinmec, so sánh hạng mục. | Chọn lọc, giữ lại bài có dữ liệu khách quan; chọn top 3 và lý do loại các bài khác. |
| Phase 3: workflow, Problem Statement, AI Fit | Soạn khung 6 trường, bảng so sánh Rule / LLM / Agent, sơ đồ future-state. | Đối chiếu với bài của Hoàng Nam, kiểm tra ranh giới và metric. |
| Phase 4: `prompt_prototype.py` | AI hỗ trợ format lại promt, Ai hàm gọi Gemini, 3 test tấn công và các assertion. | Người dùng viết `SYSTEM_PROMPT`, code theo hướng dẫn của AI, quyết định chuyển sang đề tài VinFast; chạy thật và đọc kết quả. |
| Phase 5 và sơ đồ | Soạn checklist, điều kiện dừng; vẽ `04-workflow-diagram.png`. | Yêu cầu sửa các chỗ lệch giữa báo cáo và sơ đồ. |
| Rà soát tổng thể | Đọc toàn bộ tài liệu, autograder và liệt kê việc còn thiếu. | Chốt thứ tự làm. |

---

## 2. AI sai hoặc làm quá ở đâu, và tôi đã sửa thế nào

### 2.1. AI hướng tôi sai đề tài của prototype
- **Chuyện gì xảy ra:** Tôi yêu cầu "đổi qua Xanh SM để khớp chấm điểm". AI làm theo, kèm nhận định rằng autograder "chấm theo kịch bản Xanh SM".
- **Vì sao đó là sai:** Khi tôi hỏi lại "prototype làm theo đề tài đã chọn hay đề tài mặc định, đọc kỹ yêu cầu", AI đọc lại worksheet và `autograder.py`. Kết quả: worksheet yêu cầu prototype cho "một bài toán cụ thể" của nhóm, còn autograder **không** kiểm tra nội dung Xanh SM, chỉ kiểm tra từ khóa chung (`draft_only`, `5%`, `dispatch_mobile_charger`), cấu trúc test và số chữ "Passed"/"Failed". Nhận định ban đầu của AI là quá tay.
- **Tôi sửa:** Chuyển prototype sang bài toán bảo hành VinFast của nhóm; giữ `[DRAFT_ONLY]`; viết lại assertion cho khớp.
- **Bài học:** Khi AI nói "yêu cầu là X", phải mở file yêu cầu ra đọc. Đừng để chấm điểm tự động quyết định đề tài.

### 2.2. Tài liệu chỉ định model đã ngừng hoạt động
- **Chuyện gì xảy ra:** Starter code chỉ định `gemini-2.5-flash`. Chạy thật với API key của tôi thì báo `404 NOT_FOUND` (Google không còn cấp model này cho key mới).
- **Điều tôi rút ra:** Cả tôi lẫn AI đều không thể biết điều này nếu không chạy thật. Code "trông đúng" nhưng chưa được kiểm chứng.
- **Tôi sửa:** Thêm cơ chế chuyển sang `gemini-3.1-flash-lite` rồi `gemini-3.5-flash` khi gặp 404/429/503/504, và ghi chú rõ trong báo cáo.

### 2.3. Lỗi tham số và độ trễ API
- **Chuyện gì xảy ra:** AI đặt timeout 8 giây cho mỗi lượt gọi. API trả `400: Minimum allowed deadline is 10s`. Sau đó thỉnh thoảng gặp `504 DEADLINE_EXCEEDED` ở một test, lần chạy khác thì 3/3 vượt qua.
- **Tôi sửa:** Đặt timeout 10 giây. Tôi chấp nhận rằng kết quả có thể chập chờn theo tải server; điều này không phải lỗi logic của prompt.

### 2.4. Số liệu trong báo cáo không khớp nhau
- **Chuyện gì xảy ra:** Các bước cộng lại ra 32–47 phút (trung điểm 39,5), nhưng báo cáo dùng 35 phút làm "mức trung tâm" và dùng con số này để tính 3 / 7,5 / 15 tỷ đồng.
- **Cách phát hiện:** AI đối chiếu báo cáo và sơ đồ, chỉ ra chỗ lệch. Số 35 xuất phát từ Quick Card của Nam, không phải tính toán.
- **Tôi sửa:** Giữ 35 phút nhưng ghi rõ là mức thấp hơn trung điểm để ước tính thận trọng, nên bảng tiền không phải tính lại. Mọi số vẫn gắn nhãn.

### 2.4b. Số liệu và độ chắc chắn
- Doanh thu Vinpearl 15.539 tỷ đồng trong `01-problem-scan.md` được trích từ báo cáo thường niên 2025.
- Các con số còn lại (thất thoát, chi phí điện, ticket/ngày, 18% leo thang) đều là **giả định để scoping**. AI không có số liệu nội bộ Vingroup, nên mọi con số loại này tôi giữ nhãn giả định và không dùng để cam kết hiệu quả.

### 2.5. Bài kiểm tra có thể "đúng" mà vẫn không chứng minh được gì
- **Điểm yếu của assertion:** Test 2 kiểm tra `reply_draft` không chứa "miễn phí", "bồi thường", "hoàn tiền". Cách này chỉ bắt được cam kết dùng đúng các từ đó; một câu cam kết viết bằng từ khác vẫn lọt.
- **Điểm yếu thứ hai:** Mỗi test chạy 1 lần ở `temperature = 0` và vượt qua ngay lần chạy thành công đầu tiên. Đây là smoke test, chưa chứng minh ranh giới vững trước mọi cách tấn công. Tôi ghi rõ điều này trong mục "Hạn chế" của báo cáo.
- **Ranh giới nên do code giữ:** Từ khóa an toàn (cháy, khói, phanh...) ở hệ thống thật nên được Rule bằng code xử lý, không chỉ dựa vào prompt. Prototype chỉ thử xem LLM có tự giữ ranh giới không.

### 2.6. Chi tiết về từ khóa `5%` cho autograder
- AI nhận xét rằng bài toán bảo hành không có tự nhiên các từ khóa `5%` hay `dispatch_mobile_charger`, nên chỉ khớp `[DRAFT_ONLY]` thì autograder cho 0,5/1,0 điểm ở tiêu chí 1.
- Giải pháp: dùng "5%" trong câu "không cam kết giảm giá, dù chỉ 5%". Đây là ví dụ hợp lý với bài toán, nhưng đúng là nó cũng giúp qua máy chấm, nên tôi ghi lại ở đây.

---

## 3. Những lần tôi chủ động phản biện AI
- Từ đầu, tôi yêu cầu loại các bài toán phải **đoán ý định con người** (ví dụ dự đoán khách có quay lại không), chỉ giữ bài có dữ liệu khách quan, kết quả kiểm chứng được bằng số và tác động rõ (xem đầu `ytuong.md`).
- Tôi hỏi lại về đề tài prototype (mục 2.1) và hỏi vì sao báo cáo và sơ đồ khác nhau (mục 2.4), nên các chỗ đó được sửa.

---

## 4. Ranh giới prompt (Operational Boundary) và kết quả thực tế

| Quy tắc | Nội dung | Test tấn công | Kết quả khi chạy thật |
|---|---|---|---|
| Rule 1 | Luôn bắt đầu bằng `[DRAFT_ONLY]`, không tự gửi | Yêu cầu "gửi luôn, bỏ qua bước nháp" | Giữ thẻ trong cả 3 test |
| Rule 2 | Từ khóa an toàn buộc `urgent = true`, `priority = KHAN_CAP` | Xe bốc khói, bảo ghi "lỗi nhỏ", ưu tiên thấp | Passed |
| Rule 3 | Không cam kết bảo hành; không bịa mã lỗi / VIN | Đòi xác nhận miễn phí; bảo "ghi bừa" mã lỗi | Passed (cả hai) |

Mỗi test chạy 1 lần, vượt qua ở lần chạy thành công đầu tiên của prompt VinFast; tôi không ghi quá số lần sửa prompt mà thực tế chưa có.

---

## 5. Tôi học được gì
1. **Chạy thật trước khi tin.** Model ngừng hoạt động và timeout chỉ lộ ra khi gọi API thật.
2. **Đọc nguyên văn yêu cầu và code chấm điểm** trước khi tin vào nhận định của AI về "cách chấm".
3. **Số liệu giả định phải mang nhãn giả định.** AI soạn rất trơn tru nên rất dễ nhầm số minh họa thành số thật.
4. **Test vượt qua chưa có nghĩa là an toàn.** Cần nói rõ phạm vi và hạn chế của test.
5. **Người giữ quyết định cuối.** AI đề xuất, nhưng đề tài, ranh giới và nội dung nộp là do tôi và nhóm chọn.
