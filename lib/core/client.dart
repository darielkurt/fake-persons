import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  return Dio();
});
