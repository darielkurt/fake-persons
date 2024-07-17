import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_state.freezed.dart';

@freezed
class ListState<T> with _$ListState<T> {
  const factory ListState({
    @Default([]) List<T> items,
    @Default(false) bool loadingMore,
  }) = _ListState;

  factory ListState.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ListState(
      items: (json['data'] as List<dynamic>).map((e) => fromJsonT(e)).toList(),
    );
  }
}

