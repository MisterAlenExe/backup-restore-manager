import 'package:equatable/equatable.dart';

class BackupMetadataModel extends Equatable {
  final DateTime timestamp;
  final String filePath;

  const BackupMetadataModel({
    required this.timestamp,
    required this.filePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.millisecondsSinceEpoch,
      'file_path': filePath,
    };
  }

  factory BackupMetadataModel.fromJson(Map<String, dynamic> json) {
    return BackupMetadataModel(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      filePath: json['file_path'],
    );
  }

  @override
  List<Object?> get props => [timestamp, filePath];
}
