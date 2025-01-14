import 'package:flutter/material.dart';
import 'package:rick_and_morty/shared/palette.dart';
import 'package:rick_and_morty/utils/functions.dart';

class NotFoundWidget extends StatelessWidget {
  final String title;
  final double? heightAppBar;

  const NotFoundWidget({
    super.key,
    required this.title,
    this.heightAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: Functions.getHeightBody(context, heightAppBar: heightAppBar),
        child: Column(
          children: [
            const Spacer(),
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/icon.png',
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Palette.grayMedium,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
