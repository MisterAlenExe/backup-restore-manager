import 'package:backup_restore_manager/src/models/backup_metadata.dart';
import 'package:backup_restore_manager/src/models/file.dart';

class AppUtils {
  static List<FileModel> sortFiles(List<FileModel> files) {
    files.sort((a, b) {
      if (a.isDirectory && !b.isDirectory) {
        return -1;
      } else if (!a.isDirectory && b.isDirectory) {
        return 1;
      } else {
        return a.name.compareTo(b.name);
      }
    });

    return files;
  }

  static BackupMetadataModel generateBackupMetadata(FileModel file) {
    return BackupMetadataModel(
      timestamp: DateTime.now(),
      filePath: file.path,
    );
  }
}
