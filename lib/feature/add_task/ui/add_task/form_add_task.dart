import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/feature/add_task/ui/widgets/image_widget.dart';
import 'package:tasky/feature/add_task/ui/widgets/priority_widget.dart';
import 'package:tasky/feature/add_task/ui/widgets/text_description_widget.dart';
import 'package:tasky/feature/add_task/ui/widgets/text_title_widget.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/assets.dart';
import '../../logic/add_task_cubit.dart';

class FormAddTask extends StatelessWidget {
  const FormAddTask({super.key});

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
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Due date'),
            verticalSpace(8),
            TextFormField(
                controller: cubit.dateController,
              validator: (value){
                if(value!.isNullOrEmpty()) {
                  return 'Please enter a date';
                }
                return null;
              },
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());

                final DateTime? selectedDate = await showDatePicker(
                  context: context,

                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                  builder: (context, child) => Theme(data: Theme.of(context).copyWith(
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: ColorsManager.mainColor
                      ),
                    ),
                  ), child: child!),
                );

                if (selectedDate != null) {
                  cubit.dateController.text =
                      DateFormat('dd MMMM, yyyy').format(selectedDate);
                }
              },
              decoration:   InputDecoration(
                  hintText: "Enter date here...",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 15),
                    child: SvgPicture.asset(Assets.iconsCalendar),
                  )
              ),

            ),
          ],
        ),
        verticalSpace(28),
        TextButton(onPressed: ()=>cubit.validate(false), child: Text('Add task',style: TextStyles.font19WhiteBold,)),
        verticalSpace(28),
      ],

    ));
  }
}
