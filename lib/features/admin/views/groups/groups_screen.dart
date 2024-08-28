import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/models.dart';
import '../../blocs/groups/groups_bloc.dart';
import 'a_group_screen.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      body: BlocBuilder<GroupsBloc, GroupsState>(
        bloc: context.read<GroupsBloc>()..add(GetAllGroupsEvent()),
        builder: (context, state) {
          if (state is GroupsInitialState || state is GroupsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GroupsErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }
          final allGroups = (state as GroupsLoadedState).groups;
          return ListView.builder(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 20.h,
            ),
            itemCount: allGroups.length,
            itemBuilder: (context, index) {
              final group = allGroups[index];
              return GroupItem(group: group, index: index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.group, required this.index});

  final Group group;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AGroupScreen(group: group),
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.r,
            )
          ],
        ),
        child: ListTile(
          leading: Text("${index + 1}"),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${group.name}"),
              Text("Subject: ${group.subject.name}"),
              Text("Main teacher: ${group.mainTeacher.name}"),
              Text("Assistant teacher: ${group.assistantTeacher.name}"),
              Text("Students: ${group.students.length}"),
            ],
          ),
        ),
      ),
    );
  }
}
