import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/theming/colors.dart';
import 'package:tasky/core/theming/styles.dart';

import '../../generated/assets.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({super.key, this.editTap, this.deleteTap});
 final void Function()? editTap;
 final void Function()? deleteTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      width: 24.w,
      child: PopupMenuButton(
        color: Colors.white,
        onSelected: (value) {
          if (value == 'edit') {
            editTap!();
          } else if (value == 'delete') {
            deleteTap!();
          }
        },

        itemBuilder: (BuildContext context) {
          return [
          PopupMenuItem<String>(

            padding: EdgeInsets.zero,
            value: 'edit',
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16,end: 26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 6),
                    child: Text(
                      'Edit',
                      style: TextStyles.font16BlackMedium,
                    ),
                  ),

                  Divider(color: ColorsManager.lightGray,),

                ],
              ),

            ),
          ),

          PopupMenuItem<String>(
            padding: EdgeInsets.zero,
              value: 'delete',
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 26, 0),
                child: Text(
                'Delete',
                style: TextStyles.font16CoralMedium,
                ),
              ),
               ),
          ];
        },
        icon: SvgPicture.asset(Assets.iconsMenu),
        padding: EdgeInsets.zero,
      ),
    );
  }
}