part of 'backup_bloc.dart';

sealed class BackupState extends Equatable {
  const BackupState();

  @override
  List<Object> get props => [];
}

final class BackupInitial extends BackupState {}

final class BackupLoading extends BackupState {}

final class BackupLoaded extends BackupState {
  final List<FileModel> files;

  const BackupLoaded(this.files);

  @override
  List<Object> get props => [files];
}

final class BackupError extends BackupState {
  final String message;

  const BackupError(this.message);

  @override
  List<Object> get props => [message];
}
