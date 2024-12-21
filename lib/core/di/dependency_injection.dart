
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/feature/home/data/repo/home_repo.dart';
import 'package:tasky/feature/home/logic/home_cubit.dart';
import 'package:tasky/feature/profile/data/repo/profile_repo.dart';
import 'package:tasky/feature/profile/logic/profile_cubit.dart';
import 'package:tasky/feature/signup/logic/signup_cubit.dart';

import '../../feature/add_task/data/repos/add_task_repo.dart';
import '../../feature/add_task/logic/add_task_cubit.dart';
import '../../feature/login/data/repos/login_repo.dart';
import '../../feature/login/logic/login_cubit.dart';
import '../../feature/signup/data/repos/signup_repo.dart';
import '../../feature/task/data/repo/task_repo.dart';
import '../../feature/task/logic/task_cubit.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';

final getIt=GetIt.instance;
Future<void> setupGetIt() async{
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

   // login
    getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
   getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

   // signup
    getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
   getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

   //home
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  //profile
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

  //task
  getIt.registerLazySingleton<TaskRepo>(() => TaskRepo(getIt()));
  getIt.registerFactory<TaskCubit>(() => TaskCubit(getIt()));
  //add task
  getIt.registerLazySingleton<AddTaskRepo>(() => AddTaskRepo(getIt()));
  getIt.registerFactory<AddTaskCubit>(() => AddTaskCubit(getIt()));





}