import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/helpers/spacing.dart';
import 'package:tasky/core/theming/colors.dart';
import 'package:tasky/core/theming/styles.dart';
import 'package:tasky/core/widgets/app_bar_widget.dart';
import 'package:tasky/feature/profile/logic/profile_cubit.dart';
import 'package:tasky/generated/assets.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit=context.read<ProfileCubit>();
    return Scaffold(
      appBar: Widgets.appBarWidget(context: context, title: 'Profile'),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
        child: Column(
          children: [
            _buildProfileSection(title: 'NAME',content:  cubit.profile.displayName),
            SizedBox(height: 10),
            _buildProfileSection(title:'PHONE',content:  cubit.profile.phone,
                icon: GestureDetector(onTap: () {
                  Clipboard.setData(ClipboardData(text: cubit.profile.phone));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('phone copied to the clipboard!')),
                  );

            },child: SvgPicture.asset(Assets.iconsCopy))),
            SizedBox(height: 10),
            _buildProfileSection(title:'LEVEL',content:  cubit.profile.level),
            SizedBox(height: 10),
            _buildProfileSection(title:'YEARS OF EXPERIENCE',content:  cubit.profile.experienceYears.toString()),
            SizedBox(height: 10),
            _buildProfileSection(title:'LOCATION',content:  cubit.profile.address),
          ],
        ),
      ),
    );
  }


  Widget _buildProfileSection({
    required String title,
    required String content,
    Widget? icon,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.lighterGray,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.font12DarkerGrayMediumWithOpacity,
              ),
              verticalSpace(4),
              Text(
                content,
                style: TextStyles.font18DarkGrayWithOpacityBold,
              ),
            ],
          ),
          if(icon!=null)
            icon
        ],
      ),
    );
  }

}



