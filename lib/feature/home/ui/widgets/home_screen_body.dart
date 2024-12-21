import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/feature/home/logic/home_cubit.dart';
import 'package:tasky/feature/home/ui/widgets/list_item_widget.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/assets.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});


  @override
  Widget build(BuildContext context) {
    HomeCubit cubit=context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Logo',style: TextStyles.font24DarkerGrayBold,),
        actions: [
          GestureDetector(

              onTap: () => context.pushNamed(Routes.profileScreen)
              ,child: SvgPicture.asset(Assets.iconsProfile)),
          horizontalSpace(20),
          GestureDetector(onTap: () => cubit.logout(),child: SvgPicture.asset(Assets.iconsLogout)),
          horizontalSpace(22),
        ],
      ),
      body:Padding(
        padding:  EdgeInsets.symmetric(vertical: 24.h,horizontal: 22.w),
        child: RefreshIndicator(
          onRefresh: () => cubit.refreshTasks(),
          color: ColorsManager.mainColor,
          child: cubit.todos.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Tasks',
                style: TextStyles.font16DarkerGrayWithOpacityBold,
              ),
              verticalSpace(16),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) => current is HomeChangeFilter,
                builder: (context, state) {
                  return SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          _buildFilterButton(cubit, cubit.filters[index]),
                      separatorBuilder: (context, index) => horizontalSpace(8.w),
                      itemCount: cubit.filters.length,
                    ),
                  );
                },
              ),
              verticalSpace(16),
              Expanded(
                child: ListItemWidget(),
              ),
            ],
          )
              : SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(), // تمكين التمرير دائمًا
            child: SizedBox(
              height: MediaQuery.of(context).size.height -( kToolbarHeight+50.h),
                child: _buildEmptyTasksWidget(context)),
          ),
        )
        ,

      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildEmptyTasksWidget(BuildContext context){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('No Tasks Yet!'),
          verticalSpace(10),
          TextButton(onPressed: () => context.pushNamed(Routes.addTaskScreen) , child: Text('Add Task',style: TextStyles.font19WhiteBold,))
        ],
      ),
    );
  }

  Widget _buildFilterButton(HomeCubit cubit,String filter) {
    bool isSelected = cubit.selectedFilter == filter;
    return GestureDetector(
      onTap: () => cubit.setSelectedFilter(filter),
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager.mainColor : ColorsManager.lightPurple,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(child: Text(filter,style: isSelected?TextStyles.font16WhiteBold:TextStyles.font16MediumGrayMedium,)),
      ),
    );
  }
  Widget _buildFloatingActionButton(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50.h,
          width: 50.w,
          child: FloatingActionButton(
            onPressed: () {
              context.pushNamed(Routes.scannerScreen);
            },
            heroTag: 'scannerButton',
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            backgroundColor: ColorsManager.lighterPurple,
            child: SvgPicture.asset(
              Assets.iconsQr,
              theme: const SvgTheme(fontSize: 24),
            ),
          ),
        ),
        verticalSpace(14),
        SizedBox(
          height: 64.h,
          width: 64.w,
          child: FloatingActionButton(
            onPressed: () => context.pushNamed(Routes.addTaskScreen),
            heroTag: 'addTaskButton',
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            backgroundColor: ColorsManager.mainColor,
            child: SvgPicture.asset(
              Assets.iconsAdd,
              theme: const SvgTheme(fontSize: 32),
            ),
          ),
        ),
      ],
    );
  }
}
