import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/feature/add_task/ui/add_task/form_add_task.dart';
import '../../../../core/widgets/app_bar_widget.dart';

class AddTaskBodyScreen extends StatelessWidget {
  const AddTaskBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Widgets.appBarWidget(title: 'Add new task', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 22.w),
          child: FormAddTask() ,
        ),
      ),
    );
  }
}
