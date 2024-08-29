import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/rooms/rooms_bloc.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rooms')),
      body: BlocBuilder<RoomsBloc, RoomsState>(
        bloc: context.read<RoomsBloc>()..add(GetAllRoomsEvent()),
        builder: (context, state) {
          if (state is RoomsInitialState || state is RoomsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RoomsErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }
          final rooms = (state as RoomsLoadedState).rooms;
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final subject = rooms[index];
              return ListTile(
                leading: Text("${index + 1}"),
                title: Text(subject.name),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.delete,
                    color: Colors.redAccent,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
