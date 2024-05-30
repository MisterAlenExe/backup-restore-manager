import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backup_restore_manager/src/core/const/constants.dart';
import 'package:backup_restore_manager/src/core/di/injector_container.dart';
import 'package:backup_restore_manager/src/data/file_service.dart';
import 'package:backup_restore_manager/src/models/file.dart';

part 'backup_event.dart';
part 'backup_state.dart';

class BackupBloc extends Bloc<BackupEvent, BackupState> {
  BackupBloc() : super(BackupInitial()) {
    on<BackupLoadFiles>(_onLoadFiles);
    on<BackupFileRequested>(_onBackupFile);
    on<BackupFileRestored>(_onRestoreFile);
  }

  final fileService = serviceLocator<FileService>();

  Future<void> _onLoadFiles(
    BackupLoadFiles event,
    Emitter<BackupState> emit,
  ) async {
    try {
      emit(BackupLoading());

      final files = fileService.getFiles(AppConstants.backupPath);

      emit(BackupLoaded(files));
    } catch (e) {
      emit(BackupError(e.toString()));
    }
  }

  Future<void> _onBackupFile(
    BackupFileRequested event,
    Emitter<BackupState> emit,
  ) async {
    try {
      emit(BackupLoading());

      await fileService.backupFile(event.file);
    } catch (e) {
      log('Error backing up file: $e');
      emit(BackupError(e.toString()));
    } finally {
      add(BackupLoadFiles());
    }
  }

  Future<void> _onRestoreFile(
    BackupFileRestored event,
    Emitter<BackupState> emit,
  ) async {
    try {
      emit(BackupLoading());

      await fileService.restoreFile(event.file);
    } catch (e) {
      log('Error restoring file: $e');
      emit(BackupError(e.toString()));
    } finally {
      add(BackupLoadFiles());
    }
  }
}
