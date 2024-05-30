part of 'backup_bloc.dart';

sealed class BackupEvent extends Equatable {
  const BackupEvent();

  @override
  List<Object> get props => [];
}

final class BackupLoadFiles extends BackupEvent {}

final class BackupFileRequested extends BackupEvent {
  final FileModel file;

  const BackupFileRequested(this.file);

  @override
  List<Object> get props => [file];
}

final class BackupFileRestored extends BackupEvent {
  final FileModel file;

  const BackupFileRestored(this.file);

  @override
  List<Object> get props => [file];
}
