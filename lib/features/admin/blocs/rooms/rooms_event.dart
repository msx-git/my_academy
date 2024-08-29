part of 'rooms_bloc.dart';

sealed class RoomsEvent extends Equatable {
  const RoomsEvent();
}

final class GetAllRoomsEvent extends RoomsEvent {
  @override
  List<Object?> get props => [];
}
