import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/models/task_model.dart';

import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/helpers/shared_pref_keys.dart';
import '../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeInitial()){
    scrollListener();
  }
   final List<String> filters = [ 'All', 'Inprogress', 'Waiting', 'Finished' ];
    String selectedFilter = 'All';
    int pageNumber=1;
    final scrollController=ScrollController();
    bool isFetchingData=true;
  List<Task> todos=[];
  List<Task> showTodos=[];

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
  scrollListener(){
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent==scrollController.offset){
       if(isFetchingData) {
         fetchData();
       }
      }
    },);
  }
  setSelectedFilter(String filter){
    selectedFilter=filter;
    filterTodo();

  }
  void emitDeleteStates(Task todo) async{
    final response =await _homeRepo.deleteTask(todo.id);
    response.when(success: (response) async{
      todos.remove(todo);
      filterTodo();
    }, failure: (error) {
      emit(HomeError(error: error));
    },);
  }
  void fetchData()async{
    int oldLength=todos.length;
    final response = await _homeRepo.getTodos(pageNumber);
    response.when(
      success: (todosModel) {
        print('Page$pageNumber:::${todosModel.length}');
        int getDataLength =todosModel.length;
        isFetchingData= getDataLength>=20;
        todos.addAll(todosModel);
        filterTodo();
        if(isFetchingData&&oldLength==todos.length){
          isFetchingData=false;
        }else {
          pageNumber++;
        }
        emit(HomeSuccess(todos));
      },
      failure: (error) {
        emit(HomeError(error: error));
      },
    );
  }
  void getTodo() async {
    emit(HomeLoading());
    fetchData();
  }

  logout()async{
    final response = await _homeRepo.logout();
    response.when(
      success: (todosModel) async{
        await SharedPrefHelper.clearSecuredData(SharedPrefKeys.accessToken);
        await SharedPrefHelper.clearSecuredData(SharedPrefKeys.refreshToken);
        emit(HomeLogout());
      },
      failure: (error) {
        emit(HomeError(error: error));
      },
    );
  }
  Future<void> refreshTasks()async{
    pageNumber=1;
    todos=[];
    fetchData();
   return  Future.delayed(Duration(milliseconds: 500));
  }
  void selectTodo(String id){
    emit(HomeSelectTask(id));
  }
  filterTodo(){
    if(selectedFilter==filters[0]){
      showTodos=todos;
    }else{
      showTodos= todos.where((element) => element.status.toLowerCase()==selectedFilter.toLowerCase(),).toList();
    }
    emit(HomeChangeFilter());
  }
}
