class SignupRequestBody {
  final String phone;
  final String password;
  final String displayName;
  final int experienceYears;
  final String address;
  final String level;

  SignupRequestBody({
    required this.phone,
    required this.password,
    required this.displayName,
    required this.experienceYears,
    required this.address,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'password': password,
    'displayName': displayName,
    'experienceYears': experienceYears,
    'address': address,
    'level': level,
  };
}
