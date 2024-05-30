part of 'explorer_bloc.dart';

sealed class ExplorerState extends Equatable {
  const ExplorerState();

  @override
  List<Object> get props => [];
}

final class ExplorerInitial extends ExplorerState {}

final class ExplorerLoading extends ExplorerState {}

final class ExplorerLoaded extends ExplorerState {
  final String currentPath;
  final List<FileModel> files;

  const ExplorerLoaded(this.currentPath, this.files);

  @override
  List<Object> get props => [currentPath, files];
}

final class ExplorerError extends ExplorerState {
  final String message;

  const ExplorerError(this.message);

  @override
  List<Object> get props => [message];
}
