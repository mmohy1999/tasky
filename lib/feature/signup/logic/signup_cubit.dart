import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../data/models/signup_request_body.dart';
import '../data/repos/signup_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignupCubit(this._signupRepo) : super(SignupInitial());
  final formKey =GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(),
      yearExperienceController=TextEditingController(),
      addressController=TextEditingController(),
      passwordController=TextEditingController();

  PhoneController phoneController = PhoneController(initialValue: PhoneNumber.parse('+20'));


  String? selectedExperienceLevel;
  List<String> experienceLevels=['fresh' , 'junior' , 'midLevel' , 'senior'];

  @override
  Future<void> close() {
    nameController.dispose();
    yearExperienceController.dispose();
    addressController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    return super.close();
  }

  void setSelectedExperienceLevel(String value){
    selectedExperienceLevel=value;
  }

  void emitSignupStates() async{
    emit(SignupLoading());
    String phone='+${phoneController.value.countryCode}${phoneController.value.nsn}';

    final response =await _signupRepo.signup(

    SignupRequestBody(
        displayName: nameController.text,
        address: addressController.text,
        phone: phone,
        experienceYears: int.parse(yearExperienceController.text),
        password: passwordController.text,
       level: selectedExperienceLevel!,
      ),
    );
    response.when(success: (signupResponse) {
      emit(SignupSuccess(signupResponse));
    }, failure: (error) {
      emit(SignupError(error: error));
    },);
  }

  void validate() {
    if (formKey.currentState!.validate()) {
      emitSignupStates();
    }
  }


}
