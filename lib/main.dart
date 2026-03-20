import 'package:booking_app/core/di/injection.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'features/admin/ui/bloc/admin_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();

  final talker = getIt<Talker>();
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(printEventFullData: false, printStateFullData: false),
  );

  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<AdminBloc>(create: (_) => getIt<AdminBloc>()),
      ],
      child: MaterialApp.router(
        title: 'QuickBite',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
