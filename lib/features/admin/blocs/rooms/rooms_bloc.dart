import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_academy/domain/repositories/admin_repositories/admin_rooms_repository.dart';

import '../../../../data/models/models.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final AdminRoomsRepository _adminRoomsRepository;

  RoomsBloc({required AdminRoomsRepository adminRoomsRepository})
      : _adminRoomsRepository = adminRoomsRepository,
        super(RoomsLoadingState()) {
    on<GetAllRoomsEvent>(_onGetAllRooms);
  }

  void _onGetAllRooms(GetAllRoomsEvent event, emit) async {
    emit(RoomsLoadingState());
    try {
      final responseList = await _adminRoomsRepository.getAllRooms();
      emit(RoomsLoadedState(rooms: responseList));
    } catch (e) {
      emit(RoomsErrorState(message: e.toString()));
    }
  }
}
