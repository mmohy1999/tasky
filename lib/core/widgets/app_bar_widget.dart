import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/helpers/extensions.dart';

import '../../generated/assets.dart';
import '../theming/styles.dart';

class Widgets {


 static AppBar appBarWidget(
      {required BuildContext context, required String title, List<Widget>? actions}) {
    return  AppBar(leading: Padding(
    padding:  EdgeInsetsDirectional.only(start:25.w,end: 11.w,top: 18.h,bottom: 18.h),
    child: GestureDetector(
      onTap:() =>  context.pop(),
        child: SvgPicture.asset(Assets.iconsArrowLeft,width: 18.w,height: 12.h,)),
    ),
        title: Text(title,style: TextStyles.font16DarkerGrayBold,),
        actions:actions
    );
  }
}

