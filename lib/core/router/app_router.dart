import 'package:auto_route/auto_route.dart';
import 'package:booking_app/features/auth/ui/pages/login_page.dart';
import 'package:booking_app/features/auth/ui/pages/register_page.dart';
import 'package:booking_app/features/auth/ui/pages/splash_page.dart';

import '../../features/admin/ui/page/home_admin_page.dart';
import '../../features/home/ui/page/home_customer_page.dart';
import '../../features/home/ui/page/home_seller_page.dart';
import '../../features/home/ui/page/home_shipper_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: HomeCustomerRoute.page),
    AutoRoute(page: HomeSellerRoute.page),
    AutoRoute(page: HomeShipperRoute.page),
    AutoRoute(page: HomeAdminRoute.page),
  ];
}