import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/helpers/spacing.dart';
import 'package:tasky/core/theming/styles.dart';
import 'package:tasky/core/widgets/app_bar_widget.dart';
import 'package:tasky/feature/task/logic/task_cubit.dart';
import 'package:tasky/generated/assets.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_dropdown_menu.dart';
import '../../../add_task/logic/add_task_cubit.dart';

class TaskScreenBody extends StatelessWidget {
  const TaskScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    TaskCubit cubit= context.read<TaskCubit>();
    QrCode qrCode = QrCode.fromData(
      data: cubit.task.id,
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );
    QrImage qrImage = QrImage(qrCode);

    return Scaffold(
      appBar: Widgets.appBarWidget(context: context, title: 'Task Details',actions: [
        CustomDropdownMenu(
        deleteTap: () => cubit.emitDeleteStates(),
        editTap: () {
          editTaskId=cubit.task.id;
          context.pushReplacementNamed(Routes.editTaskScreen);
        },
      ),
        horizontalSpace(22.w)
      ]
      
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 225.h,
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: "https://todo.iraqsapp.com/images/${cubit.task.image??""}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(color: ColorsManager.mainColor,)),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 22.w,vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cubit.task.title,style: TextStyles.font24DarkerGrayBold,),
                  verticalSpace(8),
                  Text(cubit.task.desc,
                    style: TextStyles.font14DarkerGrayWithOpacityRegular.copyWith(height: 1.71),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.lightPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 24.w,end:10.w,top: 7.h,bottom: 7.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('End Date',style: TextStyles.font9LightDarkGrayRegular,),
                        Text(DateFormat('dd MMMM, yyyy').format(cubit.task.createdAt),style: TextStyles.font14DarkerGrayRegular.copyWith(height: 1.7),),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsetsDirectional.only(end: 10.w,top: 13.w,bottom: 13.w),
                    child: SvgPicture.asset(
                      Assets.iconsCalendar,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
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
                      value: cubit.task.status.toCapitalized(),
                      style: TextStyles.font16MainColorBold,
                      icon: SvgPicture.asset(Assets.iconsArrowDown),
                      onChanged:null,
                      items:[ 'Inprogress', 'Waiting', 'Finished' ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyles.font16MainColorBold,),
                        );
                      }).toList(),
                      decoration:  InputDecoration(
                        disabledBorder: InputBorder.none,
                         enabledBorder: InputBorder.none,
                         focusedBorder: InputBorder.none,
                         filled: true,
                          fillColor: ColorsManager.lightPurple,
                      ),
                    ),
                  ),
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
                      value: cubit.task.priority,
                      style: TextStyles.font16MainColorBold,
                      icon: SvgPicture.asset(Assets.iconsArrowDown),

                      onChanged:null,
                      items:[ 'low', 'medium', 'high' ].map<DropdownMenuItem<String>>((String value) {
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
                  verticalSpace(16),
                  SizedBox(
                    height: 326.h,
                    width: 326.w,
                    child: PrettyQrView(
                      qrImage: qrImage,
                    )
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
