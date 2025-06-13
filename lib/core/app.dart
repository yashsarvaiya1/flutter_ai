import 'package:api_demo/modules/block_chat/index.dart';
import 'package:api_demo/modules/home/index.dart';
import 'package:api_demo/modules/image_describer/index.dart';
import 'package:api_demo/modules/ip/index.dart';
import 'package:api_demo/modules/ip/views/map_page.dart';
import 'package:api_demo/modules/mcqtest/index.dart';
import 'package:api_demo/modules/teststrip/index.dart';
import 'package:api_demo/modules/welcome/index.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = "/home";
  static const String welcome = "/welcome";
  static const String ippage = "/ippage";
  static const String mappage = "/mappage";
  static const String strippage = "/strippage";
  static const String blockchatpage = "/blockchatpage";
  static const String imageaipage = "/imageaipage";
  static const String mcqpage = "/mcqpage";

  static final pages = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: welcome, page: () => WelcomePage()),
    GetPage(name: ippage, page: () => IpPage()),
    GetPage(name: mappage, page: () => MapPage()),
    GetPage(name: strippage, page: () => StripPage()),
    GetPage(name: blockchatpage, page: () => BlockchatPage()),
    GetPage(name: imageaipage, page: () => ImageAiPage()),
    GetPage(name: mcqpage, page: () => McqPage()),
  ];
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => WelcomeController(), fenix: true);
    Get.lazyPut(() => IpController(), fenix: true);
    Get.lazyPut(() => StripController(), fenix: true);
    Get.lazyPut(() => BlockchatController(), fenix: true);
    Get.lazyPut(() => ImageAiController(), fenix: true);
    Get.lazyPut(() => McqController(), fenix: true);

    //services
    Get.lazyPut(() => GetipService(), fenix: true);
    Get.lazyPut(() => StripService(), fenix: true);
    Get.lazyPut(() => FetchBlockchat(), fenix: true);
    Get.lazyPut(() => ImageAiService(), fenix: true);
    Get.lazyPut(() => FetchMcq(), fenix: true);
  }
}
