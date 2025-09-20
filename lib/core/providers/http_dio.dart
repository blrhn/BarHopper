import 'package:bar_hop/core/config/api_config.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "http_dio.g.dart";

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

  return dio;
}
