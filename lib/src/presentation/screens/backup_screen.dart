import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backup_restore_manager/src/presentation/logic/backup_bloc/backup_bloc.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backups'),
      ),
      body: BlocBuilder<BackupBloc, BackupState>(
        builder: (context, state) {
          if (state is BackupLoaded) {
            if (state.files.isEmpty) {
              return const Center(
                child: Text('No backups found'),
              );
            }

            return ListView.builder(
              itemCount: state.files.length,
              itemBuilder: (context, index) {
                final file = state.files[index];

                return ListTile(
                  title: Text(file.name),
                  subtitle: Text(file.path),
                  trailing: IconButton(
                    icon: const Icon(Icons.restore),
                    onPressed: () {
                      context.read<BackupBloc>().add(
                            BackupFileRestored(file),
                          );
                    },
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
