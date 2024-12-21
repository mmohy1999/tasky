import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/routing/routes.dart';
import 'package:tasky/core/widgets/custom_dropdown_menu.dart';
import 'package:tasky/feature/add_task/logic/add_task_cubit.dart';
import 'package:tasky/feature/home/logic/home_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/assets.dart';
import '../../../../core/models/task_model.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit= context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeChangeFilter,
  builder: (context, state) {
    return ListView.separated(
      controller: cubit.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) => !cubit.isFetchingData || index < cubit.showTodos.length
          ? _listItemWidget(cubit, cubit.showTodos[index],context)
          : Center(
        child: CircularProgressIndicator(
          color: ColorsManager.mainColor,
        ),
      ),
      separatorBuilder: (context, index) => verticalSpace(16),
      itemCount: cubit.isFetchingData ? cubit.showTodos.length + 1 : cubit.showTodos.length,
    );

  },
);
  }

  Widget _listItemWidget(HomeCubit cubit,Task todo,BuildContext context){
    return  GestureDetector(
      onTap: () => cubit.selectTodo(todo.id),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(63.37),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(63.37),
                child: CachedNetworkImage(
                  imageUrl: "https://todo.iraqsapp.com/images/${todo.image??''}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(color: ColorsManager.mainColor,)),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          todo.title,
                          style: TextStyles.font16DarkerGrayBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      horizontalSpace(8),
                      _buildStatusWidget(todo.status),
                      horizontalSpace(12),
                      CustomDropdownMenu(
                        deleteTap: () => cubit.emitDeleteStates(todo),
                        editTap: () {
                          editTaskId=todo.id;
                          context.pushNamed(Routes.editTaskScreen);
                        },
                      ),
                    ],
                  ),
                  verticalSpace(4),
                  Text(
                    todo.desc,
                    style: TextStyles.font14DarkerGrayWithOpacityRegular,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPriorityWidget(todo.priority),
                      Text(
                        DateFormat('dd/MM/yyyy').format(todo.createdAt),
                        style: TextStyles.font12DarkerGrayRegular,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusWidget(String status){
    return Container(
      height: 22.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color:_getStatusBoxDecorationColor(status),
        borderRadius: BorderRadius.circular(5),
      ),
      child:  Center(
        child: Text(
          status,
          style: _getStatusTextStyle(status),
        ),
      ),
    );
  }
  TextStyle _getStatusTextStyle(String status){
    if(status.toLowerCase()=='waiting'){
      return TextStyles.font12CoralMedium;
    }else if(status.toLowerCase()=='inprogress'){
      return TextStyles.font12MainColorMedium;
    }else if(status.toLowerCase()=='finished'){
      return TextStyles.font12blueMedium;
    }

    return TextStyles.font12CoralMedium;
  }
  Color _getStatusBoxDecorationColor(String status){
    if(status.toLowerCase()=='waiting'){
      return ColorsManager.lightPink;
    }else if(status.toLowerCase()=='inprogress'){
      return ColorsManager.lightPurple;
    }else if(status.toLowerCase()=='finished'){
      return ColorsManager.lightBlue;
    }
    return ColorsManager.lightPink;

  }


  Widget _buildPriorityWidget(String priority){
    return  Row(
      children: [
        SvgPicture.asset(
        Assets.iconsFlag,
          colorFilter: ColorFilter.mode(
            _getPriorityFlagColor(priority),
            BlendMode.srcIn,
          ),
        ),
        horizontalSpace(4),
        Text(
          priority,
          style: _getPriorityTextStyle(priority),
        ),
      ],
    );
  }
  TextStyle _getPriorityTextStyle(String priority){
    if(priority.toLowerCase()=='low'){
      return TextStyles.font12blueMedium;
    }else if(priority.toLowerCase()=='medium'){
      return TextStyles.font12MainColorMedium;
    }else if(priority.toLowerCase()=='high'){
      return TextStyles.font12CoralMedium;
    }

    return TextStyles.font12blueMedium;
  }
  Color _getPriorityFlagColor(String priority){
    if(priority.toLowerCase()=='low'){
      return ColorsManager.blue;
    }else if(priority.toLowerCase()=='medium'){
      return ColorsManager.mainColor;
    }else if(priority.toLowerCase()=='high'){
      return ColorsManager.coral;
    }

    return ColorsManager.blue;

  }
}
