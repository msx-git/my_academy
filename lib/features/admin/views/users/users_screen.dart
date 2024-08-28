import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/user/user.dart';
import '../../blocs/users/users_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          bottom: const TabBar(
            labelColor: Colors.blue,
            tabs: [
              Tab(text: 'All users'),
              Tab(text: 'Students'),
              Tab(text: 'Teachers'),
              Tab(text: 'Admins'),
            ],
          ),
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersInitialState || state is UsersLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UsersErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }
            final allUsers = (state as UsersLoadedState).users;
            final students =
                state.users.where((user) => user.roleId == 1).toList();
            final teachers =
                state.users.where((user) => user.roleId == 2).toList();
            final admins =
                state.users.where((user) => user.roleId == 3).toList();
            return TabBarView(
              children: [
                UserList(users: allUsers),
                UserList(users: students),
                UserList(users: teachers),
                UserList(users: admins),
              ],
            );
          },
        ),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: Text("${index + 1}"),
          title: Text(user.name),
          subtitle: Text(user.role.name),
        );
      },
    );
  }
}
