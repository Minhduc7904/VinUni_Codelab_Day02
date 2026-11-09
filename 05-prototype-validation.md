# Prototype VinFast — Hướng dẫn chạy và bằng chứng kiểm tra

## 1. Sản phẩm đã bổ sung

- [Sơ đồ quy trình PNG](04-workflow-diagram.png): ảnh độc lập, không phụ thuộc Mermaid hoặc trình xem PDF.
- [Prototype Python](starter-code/prompt_prototype.py): Google Gen AI SDK, JSON Schema, kiểm tra đầu ra và fallback; không có công cụ gửi tin/ghi lịch thật.
- [Log cục bộ](artifacts/prototype-local-results.json): kiểm thử validator, **không phải output Gemini**.
- [Log autograder](artifacts/autograder-results.txt): kết quả thực tế của công cụ có sẵn trong repo.

## 2. Chạy trên Windows

Từ thư mục gốc, dùng Python có sẵn trong môi trường ảo:

```powershell
.\.venv\Scripts\python.exe starter-code/prompt_prototype.py
```

Chế độ mặc định chạy **18 kiểm thử cục bộ**: hợp đồng hợp lệ, thiếu nhãn nháp, thiếu duyệt, side effect, bịa xe/ticket/xưởng/evidence, sai enum/kiểu dữ liệu, trường ngoài schema, cam kết, mã OBD, chuyển xưởng khi cần review, fallback không có xưởng và bảo toàn ca khẩn. Exit code khác 0 nếu một kiểm tra không đạt.

Để chạy Gemini thật, cài thư viện theo `requirements.txt` nếu môi trường chưa có. Cấu hình `GEMINI_API_KEY` hoặc `GOOGLE_API_KEY` trong terminal cục bộ theo README. Không đưa khóa vào source, chat hoặc Git. Sau đó chạy:

```powershell
.\.venv\Scripts\python.exe starter-code/prompt_prototype.py --live --output artifacts/prototype-live-results.json
```

Chế độ live gọi `gemini-2.5-flash` cho **6 ca đối kháng + 1 ca hợp lệ**, lưu input giả lập, raw output, kết quả kiểm tra tự động, thời gian và fallback khi lỗi. Không có khóa thì dừng với mã lỗi; không tự thay bằng output giả. Lỗi SDK/API chỉ log tên loại lỗi để hạn chế lộ thông tin nhạy cảm từ thông báo lỗi.

## 3. Đọc kết quả đúng phạm vi

- `offline_contract_tests`: chỉ xác nhận validator chấp nhận/từ chối các mẫu được kiểm soát; chưa chứng minh mô hình tuân thủ prompt.
- `live_gemini`: kiểm tra schema, nguồn tham chiếu, trạng thái và một số ranh giới; cần CSKH/kỹ thuật đọc nội dung để tìm cam kết sai, chẩn đoán hoặc rò rỉ không bị bộ lọc từ khóa bắt được.
- Backend mẫu không có side effect; chưa mô phỏng đầy đủ giao dịch CRM/DMS, phân quyền người dùng hoặc hiệu năng sản xuất.
- `critical_review` dùng từ khóa SOP giả lập. Từ khóa có thể bỏ sót hoặc gắn cờ thừa; phải kiểm định lại với chuyên gia.
- Danh sách xưởng hợp lệ do backend giả lập cung cấp. Bản demo chưa tích hợp API lấy năng lực/lịch tiếp nhận thực tế.
- Evidence là đoạn trích từ văn bản nguồn, không phải bằng chứng độc lập rằng lời khách hàng mô tả là sự thật.

Schema được cấu hình theo [tài liệu structured output của Gemini](https://ai.google.dev/gemini-api/docs/structured-output) và [Google Gen AI Python SDK](https://googleapis.github.io/python-genai/). JSON đúng cấu trúc không bảo đảm nội dung đúng.

## 4. Kết quả hiện tại và giới hạn autograder

**Đã chạy:** 18/18 kiểm thử hợp đồng cục bộ; cấu hình SDK hợp lệ; sơ đồ PNG đã mở kiểm tra. **Chưa chạy:** Gemini live vì chưa cấu hình API key.

Autograder phần file đạt **5/5**. Phần code đạt **3,5/5** theo bộ chấm hiện tại: có SDK, test cases và script chạy; bộ chấm còn đòi từ khóa `5%`/`dispatch_mobile_charger` của bài mẫu Xanh SM và log Passed nhiều lần. Không sửa autograder hoặc thêm từ khóa không liên quan để vượt kiểm tra. Kết quả này không phải điểm G1–I3 trong nhận xét của người review.

Chạy lại khi cần kiểm tra sau thay đổi:

```powershell
.\.venv\Scripts\python.exe autograder/autograder.py --section-a
.\.venv\Scripts\python.exe autograder/autograder.py --section-b
```

## 5. Nộp bài

Giữ file Python trên branch cá nhân theo README; trưởng nhóm chọn các file tài liệu/ảnh để tổng hợp vào main. Đọc log live trước khi nộp nếu đã chạy; chỉ dùng input giả lập không định danh. Không commit API key hoặc log chứa dữ liệu khách hàng thật.
