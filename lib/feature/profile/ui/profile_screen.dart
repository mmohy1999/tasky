import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/feature/profile/ui/widgets/profile_screen_body.dart';

import '../../../core/theming/colors.dart';
import '../logic/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileState>(
      buildWhen: (previous, current) =>  current is ProfileLoading || current is ProfileSuccess || current is ProfileError,
      builder: (context, state) {
        if(state is ProfileLoading){
          return Scaffold(body: Center(child: CircularProgressIndicator(color: ColorsManager.mainColor,),),);
        }
        else if(state is ProfileError){
          return Scaffold(body: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error),
              Text(state.error),
            ],
          ),),);
        }else if(state is ProfileSuccess) {
          return ProfileScreenBody();
        }
        return Scaffold();
      },


    );
  }
}
