import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backup_restore_manager/src/models/file.dart';
import 'package:backup_restore_manager/src/presentation/logic/explorer_bloc/explorer_bloc.dart';

class FileItem extends StatelessWidget {
  const FileItem({
    super.key,
    required this.file,
    required this.isSelected,
  });

  final FileModel file;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: Colors.grey[300],
      leading: Icon(
        file.isDirectory ? Icons.folder : Icons.file_present,
      ),
      title: Text(file.name),
      onTap: () {
        if (file.isDirectory) {
          context.read<ExplorerBloc>().add(
                ExplorerNavigateToDirectory(file),
              );
        }
      },
      onLongPress: () {
        context.read<ExplorerBloc>().add(
              ExplorerSelectFile(file),
            );
      },
    );
  }
}
