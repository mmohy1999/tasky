import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/routing/routes.dart';
import 'package:tasky/core/theming/colors.dart';
import 'package:tasky/core/theming/styles.dart';
import 'package:tasky/feature/home/logic/home_cubit.dart';
import 'package:tasky/feature/home/ui/widgets/home_screen_body.dart';
import 'package:tasky/feature/task/logic/task_cubit.dart';
import 'package:tasky/generated/assets.dart';
import '../../../core/helpers/spacing.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) => current is HomeSelectTask||current is HomeLogout,
      listener: (context, state) {
       if(state is HomeSelectTask){
         taskId=state.id;
         context.pushNamed(Routes.taskScreen);
       }else if(state is HomeLogout){
         context.pushNamedAndRemoveUntil(Routes.loginScreen,predicate: (route) => false,);

       }
      },
      buildWhen: (previous, current) =>  current is HomeLoading || current is HomeSuccess || current is HomeError,
      builder: (context, state) {
        if(state is HomeLoading){
          return Scaffold(body: Center(child: CircularProgressIndicator(color: ColorsManager.mainColor,),),);
        }else if(state is HomeError){
          return Scaffold(body: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error),
              Text(state.error),
            ],
          ),),);
        }else if(state is HomeSuccess) {
            return HomeScreenBody();

        }
        return Scaffold();
      },


    );
  }

}
