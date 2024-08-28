import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/subjects/subjects_bloc.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      body: BlocBuilder<SubjectsBloc, SubjectsState>(
        bloc: context.read<SubjectsBloc>()..add(GetAllSubjectEvent()),
        builder: (context, state) {
          if (state is SubjectsInitialState || state is SubjectsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SubjectsErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }
          final subjects = (state as SubjectsLoadedState).subjects;
          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return ListTile(
                leading: Text("${index + 1}"),
                title: Text(subject.name),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.redAccent,
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
