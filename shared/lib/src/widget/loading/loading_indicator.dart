import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: Sizes.dp30(context),
          height: Sizes.dp30(context),
          child: CircularProgressIndicator(strokeWidth: 1.5),
        ),
      ),
    );
  }
}
