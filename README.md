# VNGFresher_NearbySearch_v2

1.Mô tả ứng dụng
- Tìm kiếm các vị trí xung quanh.
- Màn hình 1: Hiển thị tên vị trí, icon, loại, và khoảng cách tới vị trí hiện tại.
- Màn hình 2: Hiển thị thông tin chi tiết bao gồm: Hình ảnh, website, phone number, address, rating, types.

2.Các công cụ dùng trong ứng dụng.
- Google Places API Web service.(link: https://developers.google.com/places/web-service/search) , dùng để tải danh sách các vị trí xung quanh, hình ảnh và thông tin chi tiết của các vị trí.
- CoreLocation Framework để xác định vị trí hiện tại.

3.Xử lý tối ưu trong ứng dụng.
-Ở mà hình chính: Load 1 lần chỉ 20 kết quả. Khi người dùng kéo hết danh sách mới load thêm 20 kết quả nữa (dữ liệu cho 20 kết quả là rất nhỏ).
- Tải sẵn các icon lưu trong bộ nhớ ứng dụng về để  tiết kiệm băng thông, không cần load trực tiếp icon từ Google API (các icon là dữ liệu hình ảnh tiêu tốn khá nhiều băng thông).
- Khi người dùng chọn xem chi tiết vị trí nào đó mới load hình ảnh và thông tin chi tiết của vị trí đó về. Không load thông tin chi tiết của các vị trí người dùng chưa xem để tiết kiệm băng thông.
- xử dụng đa luồng để load hình ảnh. Tăng trải nghiệm người dùng khi chuyển từ màn hình chính sang màn hình thông tin chi tiết.

4.Kiểm thử ứng dụng.
- Ứng dụng đã được chaỵ thử trên máy ảo và máy thật trong điều kiện mạng wifi mạnh và mạng 3G, mạng không ổn định.
- Trong điều kiện mạng yếu phần màn hình chính và các thông tin chi tiết của các vị trí không bị ảnh hưởng quá nhiều. Chỉ có phần hình ảnh của vị trí phụ thuộc nhiều vào tốc độ mạng.
- ứng dụng hoạt động ổn định, không bị dừng bất thường.
- Kết quả trả về tương đối chính xác.
- Đôi lúc gặp lỗi không xác định được vị trí hiện tại.

5.Hạn chế của ứng dụng.
- Chưa cho phép người dùng tuỳ chỉnh tìm kiếm.
- Chỉ search được 60 kết quả (do hạn chế của Google API).
- đôi khi gặp lỗi không xác định được vị trí hiện tại, cần reset lại dịch vụ định vị của máy.

6. Lời cảm ơn.
- Em xin chân thành cảm ơn chị Nguyễn Ngọc Phương Tuyền đã nhiệt tình cung cấp cho em rất nhiều thông tin về chương trình và các anh/chị đã bỏ thời gian chấm bài của em.
