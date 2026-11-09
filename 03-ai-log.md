# Lab 02 — Deliverable 03: AI Interaction Log & Reflection
**Học viên:** Hoàng Thế Phong  
**Đơn vị:** Vin Smart Future (Vingroup)  
**Nhánh:** `Phong_2A202603832`  

---

* **AI đã giúp được gì (Khen):** AI hỗ trợ rất nhanh ở bước brainstorm các bài toán vận hành của Xanh SM và Vinhomes theo 4 lenses, đồng thời giúp kẻ bảng ước tính chi phí tiết kiệm (ROI) và dựng khung code gọi Gemini SDK trong `prompt_prototype.py` chỉ trong vài phút.
* **AI làm chưa tốt / sai ở đâu (Chê):** Ban đầu AI hay gợi ý giải pháp kiểu "dùng Agent tự động hóa 100%" khá viển vông (như tự động duyệt bảo hành/hoàn tiền hoặc tự gửi thẳng tin nhắn cho tài xế và khách hàng mà không qua kiểm duyệt), cộng thêm các con số thống kê đưa ra lúc đầu còn hơi chung chung.
* **Tôi đã kiểm chứng và sửa lại thế nào:** Tôi đã chỉnh lại thiết kế từ Agent xuống **LLM Feature có bước Human-in-the-loop**, ép chặt các ranh giới cứng vào `SYSTEM_PROMPT` (bắt buộc gắn tiền tố `[DRAFT_ONLY]` ở đầu mọi phản hồi và nếu pin `< 5%` thì cấm chỉ đường quá `5km` mà phải kích hoạt `dispatch_mobile_charger`), sau đó chạy các câu prompt tấn công (adversarial tests) để kiểm chứng thực tế trên code.
