import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backup_restore_manager/src/presentation/logic/backup_bloc/backup_bloc.dart';
import 'package:backup_restore_manager/src/presentation/logic/explorer_bloc/explorer_bloc.dart';
import 'package:backup_restore_manager/src/presentation/screens/backup_screen.dart';
import 'package:backup_restore_manager/src/presentation/screens/explorer_screen.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.backup),
            label: 'Backup',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) context.read<ExplorerBloc>().add(ExplorerLoadFiles());
          if (index == 1) context.read<BackupBloc>().add(BackupLoadFiles());

          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _selectedIndex == 0 ? const ExplorerScreen() : const BackupScreen(),
    );
  }
}
