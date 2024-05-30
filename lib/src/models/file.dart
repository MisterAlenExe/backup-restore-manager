import 'package:equatable/equatable.dart';

class FileModel extends Equatable {
  final String name;
  final String path;
  final bool isDirectory;

  const FileModel({
    required this.name,
    required this.path,
    required this.isDirectory,
  });

  @override
  List<Object?> get props => [name, path, isDirectory];
}
