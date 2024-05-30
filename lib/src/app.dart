import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backup_restore_manager/src/core/di/injector_container.dart';
import 'package:backup_restore_manager/src/presentation/logic/backup_bloc/backup_bloc.dart';
import 'package:backup_restore_manager/src/presentation/logic/explorer_bloc/explorer_bloc.dart';
import 'package:backup_restore_manager/src/presentation/screens/launcher_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ExplorerBloc>(
            create: (_) => serviceLocator<ExplorerBloc>()
              ..add(
                ExplorerLoadFiles(),
              ),
          ),
          BlocProvider<BackupBloc>(
            create: (_) => serviceLocator<BackupBloc>()
              ..add(
                BackupLoadFiles(),
              ),
          ),
        ],
        child: const LauncherScreen(),
      ),
    );
  }
}
