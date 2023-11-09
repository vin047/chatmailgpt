import 'package:chatmailgpt/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class TextBlockWrapper extends StatelessWidget {
  const TextBlockWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.red,
        borderRadius: BorderRadius.circular(Sizes.p4),
      ),
      child: child,
    );
  }
}
