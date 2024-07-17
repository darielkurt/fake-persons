import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.customLoading,
    this.customError,
  });
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget? customLoading;
  final Widget? customError;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) {
        if (customError != null) {
          return customError!;
        }
        return const SizedBox.shrink();
      },
      loading: () =>
          customLoading ?? const Center(child: CircularProgressIndicator()),
    );
  }
}
