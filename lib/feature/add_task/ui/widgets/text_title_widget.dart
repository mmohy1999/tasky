import 'package:flutter/material.dart';
import 'package:tasky/core/helpers/extensions.dart';

import '../../../../core/helpers/spacing.dart';
import '../../logic/add_task_cubit.dart';

class TextTitleWidget extends StatelessWidget {
  final AddTaskCubit cubit;
  const TextTitleWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task title'),
        verticalSpace(8),
        TextFormField(
          controller: cubit.titleController,
          validator: (value){
            if(value!.isNullOrEmpty()) {
              return 'Please enter a valid title';
            }
            return null;
          },

          decoration:  const InputDecoration(
            hintText: "Enter title here...",
          ),

        ),
      ],
    );
  }
}
