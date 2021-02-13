import 'package:get_it/get_it.dart';
import '../data/hive/hive.dart';
import '../data/net/auth_service.dart';
import '../data/net/main_service.dart';

GetIt locator = GetIt.instance;

void locatorSetup() {
  locator.registerSingleton(HiveDB());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => MainService());
}
