import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/feature/add_task/logic/add_task_cubit.dart';
import 'package:tasky/feature/add_task/ui/add_task/add_task_screen.dart';
import 'package:tasky/feature/home/logic/home_cubit.dart';
import 'package:tasky/feature/profile/logic/profile_cubit.dart';
import 'package:tasky/feature/profile/ui/profile_screen.dart';
import 'package:tasky/feature/scanner/scanner.dart';
import 'package:tasky/feature/signup/logic/signup_cubit.dart';
import 'package:tasky/feature/signup/ui/signup_screen.dart';
import 'package:tasky/feature/task/ui/task_screen.dart';
import '../../feature/add_task/ui/edit_task/edit_task_screen.dart';
import '../../feature/home/ui/home_screen.dart';
import '../../feature/login/logic/login_cubit.dart';
import '../../feature/login/ui/login_screen.dart';
import '../../feature/onboarding/onboarding_screen.dart';
import '../../feature/task/logic/task_cubit.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen(),);

      case Routes.loginScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>  BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },

        );

      case Routes.signUpScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },

        );

      case Routes.homeScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  BlocProvider(
            create: (context) => getIt<HomeCubit>()..getTodo(),
            child: const HomeScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },

        );

      case Routes.taskScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  BlocProvider(
            create: (context) => getIt<TaskCubit>()..getTask(),
            child: const TaskScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },

        );

      case Routes.addTaskScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  BlocProvider(
            create: (context) => getIt<AddTaskCubit>(),
            child: const AddTaskScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },

        );
        case Routes.editTaskScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  BlocProvider(
            create: (context) => getIt<AddTaskCubit>()..getTask(),
            child: const EditTaskScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },

        );

        case Routes.scannerScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  const ScannerScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },

        );
        case Routes.profileScreen:
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>  BlocProvider(
              create: (context) => getIt<ProfileCubit>()..getProfile(),
              child: const ProfileScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );

      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                )
        );
    }
  }
}