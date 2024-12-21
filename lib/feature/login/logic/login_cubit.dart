import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/helpers/shared_pref_keys.dart';
import '../../../core/networking/dio_factory.dart';
import '../data/models/login_request_body.dart';
import '../data/repos/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepo) : super(LoginInitial());
  final LoginRepo _loginRepo;

  final formKey =GlobalKey<FormState>();
  late TextEditingController passwordController=TextEditingController();
  PhoneController phoneController = PhoneController(initialValue: PhoneNumber.parse('+20'));

  @override
  Future<void> close() {
    passwordController.dispose();
    phoneController.dispose();
    return super.close();
  }

  void emitLoginStates() async{
    emit(LoginLoading());
    String phone='+${phoneController.value.countryCode}${phoneController.value.nsn}';
    final response =await _loginRepo.login(LoginRequestBody(phone: phone, password: passwordController.text));
    response.when(success: (loginResponse) async{
      
      await saveUserToken(loginResponse.accessToken?? '',loginResponse.refreshToken??'',loginResponse.id??'');
      emit(LoginSuccess(loginResponse));
    }, failure: (error) {
      emit(LoginError(error: error));
    },);
  }

  void validateThenDoLogin() {

    if (formKey.currentState!.validate()) {
      emitLoginStates();
    }
  }

  disposeControls(){
    phoneController.dispose();
    passwordController.dispose();
  }

  Future<void> saveUserToken(String accessToken,String refreshToken, String id ) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.accessToken, accessToken);
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userId, id);
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.refreshToken, refreshToken);

    DioFactory.setTokenIntoHeaderAfterLogin(token: accessToken);
  }
}
