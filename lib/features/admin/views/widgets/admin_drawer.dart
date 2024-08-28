import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/constants.dart';
import '../../admin.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.mainBackground,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text("Users"),
              leading: const Icon(Icons.people_alt_outlined),
              trailing: const Icon(CupertinoIcons.chevron_forward),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const UsersScreen(),
                ),
              ),
            ),
            ListTile(
              title: const Text("Groups"),
              leading: const Icon(Icons.groups_3_outlined),
              trailing: const Icon(CupertinoIcons.chevron_forward),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const GroupsScreen(),
                ),
              ),
            ),
            ListTile(
              title: const Text("Subjects"),
              leading: const Icon(Icons.subject),
              trailing: const Icon(CupertinoIcons.chevron_forward),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SubjectsScreen(),
                ),
              ),
            ),
            ListTile(
              title: const Text("Rooms"),
              leading: const Icon(Icons.meeting_room),
              trailing: const Icon(CupertinoIcons.chevron_forward),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const RoomsScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
