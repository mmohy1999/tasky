
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/helpers/spacing.dart';
import 'package:tasky/generated/assets.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/styles.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
          context.pushNamed(Routes.loginScreen);
         //context.pushNamed(Routes.profileScreen);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Let’s Start',
            textAlign: TextAlign.center,
            style: TextStyles.font19WhiteBold,
          ),
          horizontalSpace(8),
          SvgPicture.asset(Assets.iconsArrowRight,theme:  SvgTheme(fontSize: 19.sp)),
        ],
      ),
    );
  }
}
