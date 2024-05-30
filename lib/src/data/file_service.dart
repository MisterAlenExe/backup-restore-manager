import 'dart:convert';
import 'dart:io';

import 'package:backup_restore_manager/src/core/const/constants.dart';
import 'package:backup_restore_manager/src/core/utils/utils.dart';
import 'package:backup_restore_manager/src/models/backup_metadata.dart';
import 'package:backup_restore_manager/src/models/file.dart';

class FileService {
  List<FileModel> getFiles(String path) {
    final files = Directory(path).listSync().map((e) {
      return FileModel(
        name: e.path.split('\\').last,
        path: e.path,
        isDirectory: e is Directory,
      );
    }).toList();

    return AppUtils.sortFiles(files);
  }

  Future<void> backupFile(FileModel file) async {
    final backupDir = Directory(AppConstants.backupPath);
    final backupFileDir = Directory('${backupDir.path}\\${file.name}');
    final backupFile = File(file.path);
    final metadataFile = File('${backupFileDir.path}\\metadata.json');

    try {
      // Create backup directory
      if (!(await backupDir.exists())) {
        await backupDir.create();
      }

      // Create file directory
      if (!(await backupFileDir.exists())) {
        await backupFileDir.create();
      }

      // Copy file to backup directory
      await backupFile.copy('${backupFileDir.path}/${file.name}');

      // Metadata
      if (!(await metadataFile.exists())) {
        await metadataFile.create();
      }
      await metadataFile.writeAsString(
        json.encode(
          AppUtils.generateBackupMetadata(file).toJson(),
        ),
      );
    } catch (_) {
      if (await backupFileDir.exists()) {
        await backupFileDir.delete(recursive: true);
      }

      rethrow;
    }
  }

  Future<void> restoreFile(FileModel file) async {
    final backupFileDir = Directory('${AppConstants.backupPath}\\${file.name}');
    final backupFile = File('${backupFileDir.path}\\${file.name}');
    final metadataFile = File('${backupFileDir.path}\\metadata.json');

    try {
      if (!(await backupFileDir.exists()) ||
          !(await backupFile.exists()) ||
          !(await metadataFile.exists())) {
        throw Exception('Data about the backup file is missing');
      }

      BackupMetadataModel metadata = BackupMetadataModel.fromJson(
        json.decode(
          await metadataFile.readAsString(),
        ),
      );

      // Restore file
      await backupFile.copy(metadata.filePath);

      // Delete backup file
      await backupFileDir.delete(recursive: true);
    } catch (_) {
      rethrow;
    }
  }
}
