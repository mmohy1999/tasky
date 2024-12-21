import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/assets.dart';
import '../../logic/add_task_cubit.dart';

class PriorityWidget extends StatelessWidget {
  final AddTaskCubit cubit;
  const PriorityWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Priority'),
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
            value: cubit.selectedPriority,
            style: TextStyles.font16MainColorBold,
            icon: SvgPicture.asset(Assets.iconsArrowDown),
            onChanged:(value)=>cubit.changePriority(value),
            items:cubit.listPriority.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.iconsFlag),
                    horizontalSpace(10),
                    Text(value,style: TextStyles.font16MainColorBold,),
                  ],
                ),
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
