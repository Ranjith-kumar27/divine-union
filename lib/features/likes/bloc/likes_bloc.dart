import 'package:bloc/bloc.dart';

import 'likes_event.dart';
import 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  LikesBloc() : super(const LikesState()) {
    on<ChangeTab>(_onChangeTab);
  }

  void _onChangeTab(ChangeTab event, Emitter<LikesState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
