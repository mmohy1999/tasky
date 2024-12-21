

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/feature/add_task/data/repos/add_task_repo.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/helpers/shared_pref_keys.dart';
import '../../../core/models/task_model.dart';
import '../data/models/add_task_request_body.dart';
import '../data/models/edit_task_request_body.dart';

part 'add_task_state.dart';
String editTaskId='';
class AddTaskCubit extends Cubit<AddTaskState> {
  final AddTaskRepo _addTaskRepo;
  AddTaskCubit(this._addTaskRepo) : super(AddTaskInitial());
  TextEditingController titleController = TextEditingController(),
      descriptionController=TextEditingController(),
      dateController=TextEditingController();
  final formKey =GlobalKey<FormState>();
 List<String> listPriority= [ 'low', 'medium', 'high' ];
  String selectedPriority='low';
  List<String> listProgress= [ 'Inprogress', 'Waiting', 'Finished' ];
  String? selectedProgress;
  String imageUrl='';
  File? imageFile;
  late Task task;


  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    editTaskId='';
    return super.close();
  }

  void getTask() async {
    emit(GetTaskLoading());
    final response = await _addTaskRepo.getTodo(editTaskId);

    response.when(
      success: (taskModel) {
        task=taskModel;
        titleController.text=task.title;
        descriptionController.text=task.desc;
        dateController.text=DateFormat('dd MMMM, yyyy').format(task.createdAt);
        selectedPriority=task.priority;
        imageUrl=task.image!;
        selectedProgress=task.status;
        emit(GetTaskSuccess(task));
      },
      failure: (error) {
        emit(GetTaskError(error: error));
      },
    );
  }

  void emitEditTaskStates() async{
    emit(EditTaskLoading());
    var editTaskRequestBody= EditTaskRequestBody(
        image: imageUrl,
        title: titleController.text,
        desc: descriptionController.text,
        priority: selectedPriority,
        status: selectedProgress!,
        user: await SharedPrefHelper.getSecuredString(SharedPrefKeys.userId),

    );
    final response =await _addTaskRepo.editTask(editTaskRequestBody);
    response.when(success: (editTaskResponse) async{
      emit(EditTaskSuccess(editTaskRequestBody));
    }, failure: (error) {
      emit(EditTaskError(error: error));
    },);
  }
  void changePriority(String? value){
    selectedPriority=value!;
  }
  void changeProgress(String? value){
    selectedProgress=value!;
  }

  pickFromGallery() async {
    final pickedImage = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    imageFile = File(pickedImage!.files.first.path!);
    emit(ChangeImageTask());
  }

  emitAddImageTaskStates() async{
    final response =await _addTaskRepo.addImage(imageFile!);
    response.when(success: (image) async{
      imageUrl =image;
    }, failure: (error) {
      emit(AddTaskError(error: error));
    },);
  }

  void emitAddTaskStates() async{
   var addTaskRequestBody= AddTaskRequestBody(image: imageUrl,
        title: titleController.text,
        desc: descriptionController.text,
        priority: selectedPriority,
        dueDate: dateController.text);
    final response =await _addTaskRepo.addTask(addTaskRequestBody);
    response.when(success: (addTaskResponse) async{
      emit(AddTaskSuccess(addTaskResponse));
    }, failure: (error) {
      emit(AddTaskError(error: error));
    },);
  }

  void validate(bool isEdit) async{
    if (formKey.currentState!.validate()) {
     if(imageFile!=null){
       emit(AddTaskLoading());
       await emitAddImageTaskStates();
     }else if(imageUrl.isNullOrEmpty()){
       emit(AddTaskLoading());
     }else{
       emit(SetImageTaskError(error: 'Add Image'));
     }


     if(isEdit){
       emitEditTaskStates();
     }else{
       emitAddTaskStates();
     }
    }
  }
}
