import 'package:backup_restore_manager/src/presentation/logic/backup_bloc/backup_bloc.dart';
import 'package:backup_restore_manager/src/presentation/widgets/explorer_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backup_restore_manager/src/presentation/logic/explorer_bloc/explorer_bloc.dart';
import 'package:backup_restore_manager/src/presentation/widgets/file_item.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExplorerAppBar(
        currentPath: context.watch<ExplorerBloc>().currentPath,
        isRootDirectory: context.watch<ExplorerBloc>().isRootDirectory,
        onPopDirectory: () {
          context.read<ExplorerBloc>().add(
                ExplorerNavigateToParentDirectory(),
              );
        },
        selectedFile: context.watch<ExplorerBloc>().selectedFile,
        onUnselectFile: () {
          context.read<ExplorerBloc>().add(
                ExplorerUnselectFile(),
              );
        },
        onBackupFile: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Backup file'),
                content: const Text('Do you want to backup the selected file?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (context.read<ExplorerBloc>().selectedFile != null) {
                        context.read<BackupBloc>().add(
                              BackupFileRequested(
                                context.read<ExplorerBloc>().selectedFile!,
                              ),
                            );
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('Backup'),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: BlocBuilder<ExplorerBloc, ExplorerState>(
        builder: (context, state) {
          if (state is ExplorerLoaded) {
            if (state.files.isEmpty) {
              return const Center(
                child: Text('No files found'),
              );
            }

            return ListView.builder(
              itemCount: state.files.length,
              itemBuilder: (context, index) {
                final file = state.files[index];

                return FileItem(
                  file: file,
                  isSelected:
                      file == context.watch<ExplorerBloc>().selectedFile,
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
