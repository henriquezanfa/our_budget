import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/features/space/data/space_repository.dart';
import 'package:ob/features/space/domain/space_model.dart';

part 'space_state.dart';

class SpaceCubit extends Cubit<SpaceState> {
  SpaceCubit(this._spaceRepository) : super(const SpaceState.initial()) {
    final currentSpace = _spaceRepository.getCurrentSpace();
    emit(SpaceState.loaded(currentSpace));
  }
  final SpaceRepository _spaceRepository;

  Future<void> changeCurrentSpace(SpaceModel space) async {
    await _spaceRepository.setCurrentSpace(space);
    emit(SpaceState.loaded(space));
  }
}
