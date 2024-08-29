part of 'rooms_bloc.dart';

sealed class RoomsState extends Equatable {
  const RoomsState();
}

final class RoomsInitialState extends RoomsState {
  @override
  List<Object> get props => [];
}

final class RoomsLoadingState extends RoomsState {
  @override
  List<Object> get props => [];
}

final class RoomsLoadedState extends RoomsState {
  final List<Room> rooms;

  const RoomsLoadedState({required this.rooms});

  @override
  List<Object> get props => [rooms];
}

final class RoomsErrorState extends RoomsState {
  final String message;

  const RoomsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
