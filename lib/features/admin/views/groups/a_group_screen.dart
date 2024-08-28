import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_academy/data/models/models.dart';

import '../../blocs/groups/groups_bloc.dart';

class AGroupScreen extends StatelessWidget {
  const AGroupScreen({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<GroupsBloc>()
                  .add(DeleteGroupEvent(groupId: group.id));
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.delete,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
      body: ListView(
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          Text("Subject: ${group.subject.name}"),
          Text("Main teacher: ${group.mainTeacher.name}"),
          Text("Main teacher ID: ${group.mainTeacher.id}"),
          Text("Assistant teacher: ${group.assistantTeacher.name}"),
          Text("Assistant teacher ID: ${group.assistantTeacher.id}"),
          Text("Students: ${group.students.length}"),
          ListView.builder(
            itemCount: group.students.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text("${index + 1}"),
                title: Text(group.students[index].name),
              );
            },
          ),
        ],
      ),
    );
  }
}
