import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/helpers/extensions.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../generated/assets.dart';
import '../../logic/add_task_cubit.dart';

class ImageWidget extends StatelessWidget {
  final AddTaskCubit cubit;
  const ImageWidget({super.key,required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      buildWhen: (previous, current) => current is ChangeImageTask,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => cubit.pickFromGallery(),
          child:cubit.imageUrl.isNullOrEmpty()&&cubit.imageFile==null? SizedBox(
            width: double.infinity,
            height: 56.h,
            child: DottedBorder(
              color: ColorsManager.mainColor,
              radius: Radius.circular(12),
              borderType: BorderType.RRect,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.iconsFlag,
                        width: 24,
                        height: 24,
                      ),
                      horizontalSpace(8),
                      Text(
                        'Add Img',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5F33E1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ):SizedBox(
            width: double.infinity,
            height: 225.h,
            child: ClipRRect(
              child:cubit.imageFile!=null?Image.file(cubit.imageFile!,fit:BoxFit.cover) :CachedNetworkImage(
                imageUrl: "https://todo.iraqsapp.com/images/${cubit.task.image??''}",
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: ColorsManager.mainColor,)),
                errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        );
      },
    );
  }
}
