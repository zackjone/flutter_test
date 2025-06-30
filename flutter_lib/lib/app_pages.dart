
import 'package:flutter_test_app/pages.dart';
import 'package:flutter_test_app/pages/home_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages implements Pages {
  static String home = '/home';

  static List<GetPage>? getAllPages() {
    return flutterPages.map((e) {
      return GetPage(name: e, page: () => AppPages.innerGetPage(e));
    }).toList();
  }

  static List<String> flutterPages = [
    home
  ];

  static innerGetPage(String? pageName) {
    if(home.contains(pageName!)){
      return HomePage();
    }
    return null;
  }

  @override
  getPage(String? pageName) {
    return AppPages.innerGetPage(pageName);
  }
}
