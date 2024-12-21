import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import 'form_edit_task.dart';

class EditTaskBodyScreen extends StatelessWidget {
  const EditTaskBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Widgets.appBarWidget(title: 'Add new task', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 22.w),
          child: FormEditTask() ,
        ),
      ),
    );
  }
}
