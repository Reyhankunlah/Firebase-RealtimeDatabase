import 'package:get/route_manager.dart';
import 'package:tugas1_11pplg2/Binding/calculatorBinding.dart';
import 'package:tugas1_11pplg2/Binding/contactBinding.dart';
import 'package:tugas1_11pplg2/Binding/editPlayerBinding.dart';
import 'package:tugas1_11pplg2/Binding/example_binding.dart';
import 'package:tugas1_11pplg2/Binding/footballPlayerBinding.dart';
import 'package:tugas1_11pplg2/Binding/loginPageBinding.dart';
import 'package:tugas1_11pplg2/Binding/menu_makanan_binding.dart';
import 'package:tugas1_11pplg2/Binding/navigationBinding.dart';
import 'package:tugas1_11pplg2/Binding/profileBinding.dart';
import 'package:tugas1_11pplg2/Binding/splashScreenBinding.dart';
import 'package:tugas1_11pplg2/Binding/tablePremiere_binding.dart';
import 'package:tugas1_11pplg2/Pages/calculator_pages.dart';
import 'package:tugas1_11pplg2/Pages/contact_page.dart';
import 'package:tugas1_11pplg2/Pages/editplayer_page.dart';
import 'package:tugas1_11pplg2/Pages/ex_feature/ex_transform.dart';
import 'package:tugas1_11pplg2/Pages/footballPlayer_pages.dart';
import 'package:tugas1_11pplg2/Pages/login_page.dart';
import 'package:tugas1_11pplg2/Pages/menu_list_makanan.dart';
import 'package:tugas1_11pplg2/Pages/nav/mainNavigationPage.dart';
import 'package:tugas1_11pplg2/Pages/profile_page.dart';
import 'package:tugas1_11pplg2/Pages/splashScreen_pages.dart';
import 'package:tugas1_11pplg2/Pages/tablePremiere_page.dart';
import 'package:tugas1_11pplg2/Routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.calculatorPage,
      page: () => CalculatorPages(),
      binding: CalculatorBinding(),
    ),
    GetPage(
      name: AppRoutes.footballPage,
      page: () => FootballplayerPages(),
      binding: Footballplayerbinding(),
    ),
    GetPage(
      name: AppRoutes.editPlayerPage,
      page: () => EditplayerPage(),
      binding: Editplayerbinding(),
    ),
    GetPage(
      name: AppRoutes.profilePage,
      page: () => ProfilePage(),
      binding: Profilebinding(),
    ),
    GetPage(
      name: AppRoutes.mainNav,
      page: () => MainNavigationPage(),
      binding: Navigationbinding(),
    ),
    GetPage(
      name: AppRoutes.exTransform,
      page: () => ExTransform(),
      binding: ExampleBinding(),
    ),
    GetPage(
      name: AppRoutes.tablePremiere,
      page: () => TablepremierePage(),
      binding: TablepremiereBinding(),
    ),

    // SHARED PREFERENCE
    GetPage(
      name: AppRoutes.LoginPage,
      page: () => LoginPage(),
      binding: Loginpagebinding(),
    ),
    GetPage(
      name: AppRoutes.splashScreenPage,
      page: () => SplashscreenPages(),
      binding: Splashscreenbinding(),
    ),

    // DATABASE
    GetPage(
      name: AppRoutes.contactPage,
      page: () => ContactPage(),
      binding: Contactbinding(),
    ),
    GetPage(
      name: AppRoutes.listmakananPage,
      page: () => MenuListMakanan(),
      binding: MenuMakananBinding(),
    ),
  ];
}
