part of 'explorer_bloc.dart';

sealed class ExplorerEvent extends Equatable {
  const ExplorerEvent();

  @override
  List<Object> get props => [];
}

final class ExplorerLoadFiles extends ExplorerEvent {}

final class ExplorerNavigateToDirectory extends ExplorerEvent {
  final FileModel directory;

  const ExplorerNavigateToDirectory(this.directory);

  @override
  List<Object> get props => [directory];
}

final class ExplorerNavigateToParentDirectory extends ExplorerEvent {}

final class ExplorerSelectFile extends ExplorerEvent {
  final FileModel file;

  const ExplorerSelectFile(this.file);

  @override
  List<Object> get props => [file];
}

final class ExplorerUnselectFile extends ExplorerEvent {}
