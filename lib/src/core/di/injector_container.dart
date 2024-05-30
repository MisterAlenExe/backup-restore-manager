import 'package:get_it/get_it.dart';

import 'package:backup_restore_manager/src/data/file_service.dart';
import 'package:backup_restore_manager/src/presentation/logic/backup_bloc/backup_bloc.dart';
import 'package:backup_restore_manager/src/presentation/logic/explorer_bloc/explorer_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDI() async {
  //* Data Layer
  serviceLocator.registerLazySingleton<FileService>(
    () => FileService(),
  );

  //* Presentation Layer
  serviceLocator.registerFactory<ExplorerBloc>(
    () => ExplorerBloc(),
  );
  serviceLocator.registerFactory<BackupBloc>(
    () => BackupBloc(),
  );
}
