import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        const Text(
          "Về chúng tôi",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        const Text(
          "Little star là ứng dụng dạy tiếng việt dành cho trẻ em từ 3 đến 7 tuổi với hàng trăm bài học dựa trên tiêu chuẩn sách giáo khoa, không những thế các bé còn có thể xem video truyện cổ tích với nội dung được chọn lọc nhằm tránh nội dung độc hại. Bên cạnh đó, ứng dụng có hệ thống quản lý giúp phụ huynh vừa có thể để con tự lập vừa có thể can thiệp một cách tự nhiên nếu cần thiết.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        const Text(
          "Liên hệ - Gửi phản hồi - Hướng dẫn sữ dụng",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const Text(
          "Vui lòng truy cập vào website của chúng tôi qua đường dẫn",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            if (!await launch("https://little-star-web.herokuapp.com")) {
              throw 'Could not launch "https://little-star-web.herokuapp.com"';
            }
          },
          child: const Text(
            "https://little-star-web.herokuapp.com",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ));
  }
}
