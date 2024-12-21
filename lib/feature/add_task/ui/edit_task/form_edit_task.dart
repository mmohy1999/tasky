import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/feature/add_task/ui/edit_task/progress_widget.dart';
import 'package:tasky/feature/add_task/ui/widgets/date_widget.dart';
import 'package:tasky/feature/add_task/ui/widgets/image_widget.dart';
import 'package:tasky/feature/add_task/ui/widgets/priority_widget.dart';
import 'package:tasky/feature/add_task/ui/widgets/text_description_widget.dart';
import 'package:tasky/feature/add_task/ui/widgets/text_title_widget.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/assets.dart';
import '../../logic/add_task_cubit.dart';

class FormEditTask extends StatelessWidget {
  const FormEditTask({super.key});

  @override
  Widget build(BuildContext context) {
    AddTaskCubit cubit=context.read<AddTaskCubit>();
    return Form(
      key: cubit.formKey
    ,child: Column(
      children: [
        verticalSpace(24),
        ImageWidget(cubit: cubit,),
        verticalSpace(16),
        TextTitleWidget(cubit: cubit),
        verticalSpace(16),
        TextDescriptionWidget(cubit: cubit),
        verticalSpace(16),
        PriorityWidget(cubit: cubit),
        verticalSpace(16),
        ProgressWidget(cubit: cubit),
        verticalSpace(28),
        TextButton(onPressed: ()=>cubit.validate(true), child: Text('Edit task',style: TextStyles.font19WhiteBold,)),
        verticalSpace(28),

      ],

    )
    );
  }
}
