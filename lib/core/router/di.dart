import 'package:booking_app/core/router/app_router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterModule {
  @lazySingleton
  AppRouter get appRouter => AppRouter();
}