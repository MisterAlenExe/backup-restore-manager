import 'package:flutter/material.dart';

import 'package:backup_restore_manager/src/models/file.dart';

class ExplorerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExplorerAppBar({
    super.key,
    required this.currentPath,
    required this.isRootDirectory,
    required this.onPopDirectory,
    required this.selectedFile,
    required this.onUnselectFile,
    required this.onBackupFile,
  });

  final String currentPath;
  final bool isRootDirectory;
  final VoidCallback onPopDirectory;
  final FileModel? selectedFile;
  final VoidCallback onUnselectFile;
  final VoidCallback onBackupFile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Explorer ($currentPath)',
      ),
      leading: isRootDirectory
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onPopDirectory,
            ),
      actions: selectedFile == null
          ? null
          : [
              IconButton(
                icon: const Icon(Icons.backup_outlined),
                onPressed: onBackupFile,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onUnselectFile,
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
