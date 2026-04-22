import 'package:get_it/get_it.dart';
import 'package:lamma3ly/app/env/env_config.dart';
import 'package:lamma3ly/core/network/api_client.dart';
import 'package:lamma3ly/core/storage/secure_storage_service.dart';
import 'package:lamma3ly/shared/auth/data/api/auth_api_service.dart';
import 'package:lamma3ly/shared/auth/data/repositories/auth_repository_impl.dart';
import 'package:lamma3ly/shared/auth/domain/repositories/auth_repository.dart';
import 'package:lamma3ly/shared/auth/domain/usecases/login_usecase.dart';
import 'package:lamma3ly/shared/auth/domain/usecases/register_usecase.dart';
import 'package:lamma3ly/shared/auth/domain/usecases/logout_usecase.dart';
import 'package:lamma3ly/shared/auth/domain/usecases/auto_login_usecase.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_cubit.dart';

/// Service locator instance accessible throughout the app.
final GetIt sl = GetIt.instance;

/// Initializes all dependencies for the application.
///
/// Called once from the entry point before [runApp].
/// Register dependencies bottom-up: core → data → domain → presentation.
Future<void> initDependencies(EnvConfig config) async {
  // ─── Core Services ─────────────────────────────────────
  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(config: config, storage: sl()),
  );

  // ─── Auth Data Layer ───────────────────────────────────
  sl.registerLazySingleton<AuthApiService>(
    () => AuthApiService(apiClient: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authApi: sl(), storage: sl()),
  );

  // ─── Auth Domain Layer (Use Cases) ─────────────────────
  sl.registerFactory(() => LoginUseCase(repository: sl()));
  sl.registerFactory(() => RegisterUseCase(repository: sl()));
  sl.registerFactory(() => LogoutUseCase(repository: sl()));
  sl.registerFactory(() => AutoLoginUseCase(repository: sl()));

  // ─── Auth Presentation Layer (Cubits) ──────────────────
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      autoLoginUseCase: sl(),
    ),
  );
}
