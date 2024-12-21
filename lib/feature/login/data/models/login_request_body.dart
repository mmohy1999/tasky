class LoginRequestBody{
  final String phone;
  final String password;
  LoginRequestBody({required this.phone,required this.password});
  Map<String, dynamic> toJson() => {
    'phone': phone,
    'password': password,
  };

}