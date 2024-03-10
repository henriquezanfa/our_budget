import 'package:ob/core/di/di.dart';
import 'package:ob/features/space/data/space_repository.dart';

void injectSpace() {
  inject.registerLazySingleton<SpaceRepository>(
    () => SpaceRepository(
      firestore: inject(),
      sharedPreferences: inject(),
      authRepository: inject(),
    ),
  );
}
