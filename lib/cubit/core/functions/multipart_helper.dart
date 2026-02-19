import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';

class MultipartHelper {
  /// Creates a [MultipartFile] from a local file path
  ///
  /// [path]: local file path
  /// [contentType]: MIME type like 'image/jpeg', 'image/png'
  static Future<MultipartFile> fromFilePath(
    String path, {
    String? contentType,
  }) async {
    final file = File(path);

    if (!await file.exists()) {
      throw FileSystemException('File does not exist at path: $path', path);
    }

    MediaType? mediaType;
    if (contentType != null) {
      try {
        mediaType = MediaType.parse(contentType);
      } catch (_) {
        // إذا فشل التحويل، اتركه null
        mediaType = null;
      }
    }

    return MultipartFile.fromFile(
      path,
      filename: p.basename(path),
      contentType: mediaType,
    );
  }
}
