import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class AsyncValueShimmerWidget<T> extends StatelessWidget {
  const AsyncValueShimmerWidget({
    super.key,
    required this.value,
    required this.loading,
    required this.data,
  });

  final AsyncValue<T> value;
  final Widget Function() loading;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: (() => Shimmer.fromColors(
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).focusColor,
            child: loading(),
          )),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}
