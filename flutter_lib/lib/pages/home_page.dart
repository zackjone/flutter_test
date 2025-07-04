import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/image_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('图片展示'),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              SystemNavigator.pop();
            },
          )),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("本地图片"),
            ImageWidget(
              width: 300,
              height: 300,
              imageUrl: 'logo_icon_default',
            ),
            Text("网络图片"),
            ImageWidget(
              width: 300,
              height: 300,
              imageUrl:
              'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
            ),
          ],
        ),
      ),
    );
  }
}
