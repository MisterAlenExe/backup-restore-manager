import 'dart:developer';

import 'package:backup_restore_manager/src/core/const/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backup_restore_manager/src/core/di/injector_container.dart';
import 'package:backup_restore_manager/src/data/file_service.dart';
import 'package:backup_restore_manager/src/models/file.dart';

part 'explorer_event.dart';
part 'explorer_state.dart';

class ExplorerBloc extends Bloc<ExplorerEvent, ExplorerState> {
  ExplorerBloc() : super(ExplorerInitial()) {
    on<ExplorerLoadFiles>(_onLoadFiles);
    on<ExplorerNavigateToDirectory>(_onNavigateToDirectory);
    on<ExplorerNavigateToParentDirectory>(_onNavigateToParentDirectory);
    on<ExplorerSelectFile>(_onSelectFile);
    on<ExplorerUnselectFile>(_onUnselectFile);
  }

  final fileService = serviceLocator<FileService>();

  String _currentPath = AppConstants.defaultPath;
  String get currentPath => _currentPath;
  bool get isRootDirectory => _currentPath == AppConstants.defaultPath;

  FileModel? _selectedFile;
  FileModel? get selectedFile => _selectedFile;

  Future<void> _onLoadFiles(
    ExplorerLoadFiles event,
    Emitter<ExplorerState> emit,
  ) async {
    String oldPath = _currentPath;
    if (state is ExplorerLoaded) {
      oldPath = (state as ExplorerLoaded).currentPath;
    }

    try {
      emit(ExplorerLoading());

      final files = fileService.getFiles(_currentPath);

      _selectedFile = null;

      emit(ExplorerLoaded(_currentPath, files));
    } catch (e) {
      log('Error loading files: $e');
      emit(ExplorerError(e.toString()));

      _currentPath = oldPath;
      add(ExplorerLoadFiles());
    }
  }

  Future<void> _onNavigateToDirectory(
    ExplorerNavigateToDirectory event,
    Emitter<ExplorerState> emit,
  ) async {
    if (!event.directory.isDirectory) {
      return;
    }

    _currentPath = event.directory.path;

    add(ExplorerLoadFiles());
  }

  Future<void> _onNavigateToParentDirectory(
    ExplorerNavigateToParentDirectory event,
    Emitter<ExplorerState> emit,
  ) async {
    String newPath = _currentPath
        .split('\\')
        .sublist(0, _currentPath.split('\\').length - 1)
        .join('\\');
    if (newPath.isEmpty) {
      newPath = 'D:';
    }

    _currentPath = newPath;

    add(ExplorerLoadFiles());
  }

  Future<void> _onSelectFile(
    ExplorerSelectFile event,
    Emitter<ExplorerState> emit,
  ) async {
    List<FileModel> oldFiles = [];
    if (state is ExplorerLoaded) {
      oldFiles = (state as ExplorerLoaded).files;
    }

    emit(ExplorerLoading());

    _selectedFile = event.file;

    emit(ExplorerLoaded(_currentPath, oldFiles));
  }

  Future<void> _onUnselectFile(
    ExplorerUnselectFile event,
    Emitter<ExplorerState> emit,
  ) async {
    List<FileModel> oldFiles = [];
    if (state is ExplorerLoaded) {
      oldFiles = (state as ExplorerLoaded).files;
    }

    emit(ExplorerLoading());

    _selectedFile = null;

    emit(ExplorerLoaded(_currentPath, oldFiles));
  }
}
