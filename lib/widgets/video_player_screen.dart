import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:get/get.dart';

class VideoPlayerScreen extends StatelessWidget {
  VideoPlayerScreen({Key? key}) : super(key: key);

  final String? link = Get.parameters["link"];

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      '<iframe src="$link"></iframe>',
      factoryBuilder: () => MyWidgetFactory(),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
