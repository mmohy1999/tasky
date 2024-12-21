import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/helpers/extensions.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/assets.dart';
import '../../logic/add_task_cubit.dart';

class ProgressWidget extends StatelessWidget {
  final AddTaskCubit cubit;
  const ProgressWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress'),
        verticalSpace(8),
        Container(
          height: 50.h,
          width: double.infinity,
          padding:  EdgeInsetsDirectional.only(start: 10.w,end: 8.w),
          decoration: BoxDecoration(
            color: ColorsManager.lightPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<String>(
            value: cubit.selectedProgress.toCapitalized(),
            style: TextStyles.font16MainColorBold,
            icon: SvgPicture.asset(Assets.iconsArrowDown),
            onChanged:(value)=>cubit.changeProgress(value),
            items:cubit.listProgress.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,style: TextStyles.font16MainColorBold,),
              );
            }).toList(),
            decoration:  InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: true,
              fillColor: ColorsManager.lightPurple,
            ),

          ),
        ),
      ],
    );
  }
}
