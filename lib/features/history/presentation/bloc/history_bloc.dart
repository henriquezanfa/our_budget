import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(ExercisesInitial()) {
    on<HistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
