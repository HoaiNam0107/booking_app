// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

import '../../features/admin/data/datasources/admin_remote_datasource.dart'
    as _i668;
import '../../features/admin/data/repositories/admin_repository_impl.dart'
    as _i335;
import '../../features/admin/domain/repositories/admin_repository.dart'
    as _i583;
import '../../features/admin/domain/usecase/admin_usecases.dart' as _i888;
import '../../features/admin/ui/bloc/admin_bloc.dart' as _i1064;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/datasources/auth_local_datasource.dart' as _i556;
import '../../features/auth/datasources/auth_remote_datasource.dart' as _i573;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/register_customer_usecase.dart'
    as _i1063;
import '../../features/auth/domain/usecases/register_seller_usecase.dart'
    as _i154;
import '../../features/auth/ui/bloc/auth_bloc.dart' as _i918;
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import '../router/app_router.dart' as _i81;
import '../router/di.dart' as _i630;
import '../service/preferences_service.dart' as _i860;
import '../service/secure_storage_service.dart' as _i142;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final routerModule = _$RouterModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i207.Talker>(() => appModule.talker);
    gh.lazySingleton<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => appModule.firestore);
    gh.lazySingleton<_i457.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => appModule.secureStorage);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i81.AppRouter>(() => routerModule.appRouter);
    gh.lazySingleton<_i668.AdminRemoteDataSource>(
      () => _i668.AdminRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i207.Talker>(),
      ),
    );
    gh.lazySingleton<_i573.AuthRemoteDataSource>(
      () => _i573.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i207.Talker>(),
      ),
    );
    gh.lazySingleton<_i142.SecureStorageService>(
      () => _i142.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(() => _i932.NetworkInfoImpl());
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i207.Talker>(),
        gh<_i142.SecureStorageService>(),
      ),
    );
    gh.lazySingleton<_i860.PreferencesService>(
      () => _i860.PreferencesServiceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i556.AuthLocalDataSource>(
      () => _i556.AuthLocalDataSourceImpl(gh<_i142.SecureStorageService>()),
    );
    gh.lazySingleton<_i583.AdminRepository>(
      () => _i335.AdminRepositoryImpl(gh<_i668.AdminRemoteDataSource>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i573.AuthRemoteDataSource>(),
        gh<_i556.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i17.GetCurrentUserUseCase>(
      () => _i17.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i1063.RegisterCustomerUseCase>(
      () => _i1063.RegisterCustomerUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i154.RegisterSellerUseCase>(
      () => _i154.RegisterSellerUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i888.WatchSellerRequestsUseCase>(
      () => _i888.WatchSellerRequestsUseCase(gh<_i583.AdminRepository>()),
    );
    gh.lazySingleton<_i888.ApproveSellerUseCase>(
      () => _i888.ApproveSellerUseCase(gh<_i583.AdminRepository>()),
    );
    gh.lazySingleton<_i888.RejectSellerUseCase>(
      () => _i888.RejectSellerUseCase(gh<_i583.AdminRepository>()),
    );
    gh.lazySingleton<_i888.CreateShipperUseCase>(
      () => _i888.CreateShipperUseCase(gh<_i583.AdminRepository>()),
    );
    gh.lazySingleton<_i888.WatchShippersUseCase>(
      () => _i888.WatchShippersUseCase(gh<_i583.AdminRepository>()),
    );
    gh.factory<_i1064.AdminBloc>(
      () => _i1064.AdminBloc(
        gh<_i888.WatchSellerRequestsUseCase>(),
        gh<_i888.ApproveSellerUseCase>(),
        gh<_i888.RejectSellerUseCase>(),
        gh<_i888.CreateShipperUseCase>(),
        gh<_i888.WatchShippersUseCase>(),
        gh<_i207.Talker>(),
      ),
    );
    gh.factory<_i918.AuthBloc>(
      () => _i918.AuthBloc(
        gh<_i188.LoginUseCase>(),
        gh<_i1063.RegisterCustomerUseCase>(),
        gh<_i154.RegisterSellerUseCase>(),
        gh<_i48.LogoutUseCase>(),
        gh<_i17.GetCurrentUserUseCase>(),
        gh<_i207.Talker>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}

class _$RouterModule extends _i630.RouterModule {}

class _$NetworkModule extends _i667.NetworkModule {}
