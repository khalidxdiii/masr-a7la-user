import 'package:flutter/material.dart';

import '../../../models/problem_model.dart';

class OpenImageScreen extends StatelessWidget {
  const OpenImageScreen({super.key, this.imageUrl, this.index});
  final MAProblemModel? imageUrl;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Image.network(
            imageUrl!.imageUrl!,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
