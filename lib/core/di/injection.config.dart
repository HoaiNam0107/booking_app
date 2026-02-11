// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:booking_app/core/di/firebase_module.dart' as _i951;
import 'package:booking_app/core/di/storage_module.dart' as _i561;
import 'package:booking_app/core/storage/secure_storage.dart' as _i43;
import 'package:booking_app/features/auth/data/datasources/auth_firestore_data_source.dart'
    as _i919;
import 'package:booking_app/features/auth/data/datasources/auth_local_data_source.dart'
    as _i726;
import 'package:booking_app/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i934;
import 'package:booking_app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i680;
import 'package:booking_app/features/auth/domain/repositories/auth_repository.dart'
    as _i579;
import 'package:booking_app/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i276;
import 'package:booking_app/features/auth/domain/usecases/login_usecase.dart'
    as _i424;
import 'package:booking_app/features/auth/domain/usecases/logout_usecase.dart'
    as _i236;
import 'package:booking_app/features/auth/domain/usecases/signup_usecase.dart'
    as _i604;
import 'package:booking_app/features/auth/presentation/bloc/auth_bloc.dart'
    as _i205;
import 'package:booking_app/features/home/data/datasources/home_firestore_data_source.dart'
    as _i802;
import 'package:booking_app/features/home/data/repositories/home_repository_impl.dart'
    as _i273;
import 'package:booking_app/features/home/domain/repositories/home_repository.dart'
    as _i793;
import 'package:booking_app/features/home/domain/usecases/create_service_usecase.dart'
    as _i507;
import 'package:booking_app/features/home/domain/usecases/get_services_usecase.dart'
    as _i986;
import 'package:booking_app/features/home/presentation/bloc/home_bloc.dart'
    as _i211;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    final storageModule = _$StorageModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i43.SecureStorage>(
      () => _i43.SecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i919.AuthFirestoreDataSource>(
      () => _i919.AuthFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i726.AuthLocalDataSource>(
      () => _i726.AuthLocalDataSourceImpl(gh<_i43.SecureStorage>()),
    );
    gh.lazySingleton<_i934.AuthRemoteDataSource>(
      () => _i934.AuthRemoteDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i802.HomeFirestoreDataSource>(
      () => _i802.HomeFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i579.AuthRepository>(
      () => _i680.AuthRepositoryImpl(
        remote: gh<_i934.AuthRemoteDataSource>(),
        local: gh<_i726.AuthLocalDataSource>(),
        firestore: gh<_i919.AuthFirestoreDataSource>(),
      ),
    );
    gh.factory<_i276.GetCurrentUserUseCase>(
      () => _i276.GetCurrentUserUseCase(gh<_i579.AuthRepository>()),
    );
    gh.factory<_i424.LoginUseCase>(
      () => _i424.LoginUseCase(gh<_i579.AuthRepository>()),
    );
    gh.factory<_i236.LogoutUseCase>(
      () => _i236.LogoutUseCase(gh<_i579.AuthRepository>()),
    );
    gh.factory<_i604.SignUpUseCase>(
      () => _i604.SignUpUseCase(gh<_i579.AuthRepository>()),
    );
    gh.lazySingleton<_i793.HomeRepository>(
      () => _i273.HomeRepositoryImpl(gh<_i802.HomeFirestoreDataSource>()),
    );
    gh.factory<_i205.AuthBloc>(
      () => _i205.AuthBloc(
        gh<_i424.LoginUseCase>(),
        gh<_i604.SignUpUseCase>(),
        gh<_i276.GetCurrentUserUseCase>(),
        gh<_i236.LogoutUseCase>(),
      ),
    );
    gh.factory<_i507.CreateServiceUseCase>(
      () => _i507.CreateServiceUseCase(gh<_i793.HomeRepository>()),
    );
    gh.factory<_i986.GetServicesUseCase>(
      () => _i986.GetServicesUseCase(gh<_i793.HomeRepository>()),
    );
    gh.factory<_i211.HomeBloc>(
      () => _i211.HomeBloc(
        gh<_i986.GetServicesUseCase>(),
        gh<_i507.CreateServiceUseCase>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i951.FirebaseModule {}

class _$StorageModule extends _i561.StorageModule {}
