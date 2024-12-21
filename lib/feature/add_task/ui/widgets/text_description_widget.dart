import 'package:flutter/material.dart';
import 'package:tasky/core/helpers/extensions.dart';

import '../../../../core/helpers/spacing.dart';
import '../../logic/add_task_cubit.dart';

class TextDescriptionWidget extends StatelessWidget {
  final AddTaskCubit cubit;
  const TextDescriptionWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task Description',),
        verticalSpace(8),
        TextFormField(
          controller: cubit.descriptionController,
          decoration: InputDecoration(
            hintText: "Enter description here...",
          ),
          validator: (value){
            if(value!.isNullOrEmpty()) {
              return 'Please enter a valid description';
            }
            return null;
          },
          maxLines: 5,
        ),
      ],
    );
  }
}
