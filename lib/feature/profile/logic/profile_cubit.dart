

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/feature/profile/data/models/profile_model.dart';
import 'package:tasky/feature/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileCubit(this._profileRepo) : super(ProfileInitial());
  late ProfileModel profile;
  void getProfile() async {
    emit(ProfileLoading());
    final response = await _profileRepo.getProfile();
    response.when(
      success: (profileModel) {
        profile=profileModel;
        emit(ProfileSuccess(profileModel));
      },
      failure: (error) {
        emit(ProfileError(error: error));
      },
    );
  }
}
