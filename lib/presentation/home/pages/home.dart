import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/common/widgets/app_bar.dart';
import 'package:my_app/core/configs/assets/app_vectors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(AppVectors.logo),
        ),
      ),
    );
  }
}
