bool isValid(String value) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(value);
}

bool hasUppercase(String value) {
  return value.contains(RegExp(r'[A-Z]'));
}

bool hasLowercase(String value) {
  return value.contains(RegExp(r'[a-z]'));
}

bool hasNumber(String value) {
  return value.contains(RegExp(r'[0-9]'));
}

bool isLengthValid(String value) {
  return value.length >= 8;
}

bool hasSpecialChar(String value) {
  return value.contains(RegExp(r'[@$!%*?&]'));
}

bool isMatch(String password, String confirmPassword) {
  return password == confirmPassword;
}

