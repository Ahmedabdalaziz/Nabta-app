import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/core/helper/regex.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_error.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_request.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_response.dart';
import 'package:graduation_project/features/signup/data/model/custom/signup_data.dart';
import 'package:graduation_project/features/signup/data/repo/repo_signin.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository signupRepository;
  final SignupData signupData = SignupData();

  SignupCubit(this.signupRepository) : super(SignupInitial());

  bool isNameValid(String name) => _isNameValid(name);

  bool isGenderValid(String gender) => _isGenderValid(gender);

  bool isDateValid(String date) => _isDateValid(date);

  bool isCityValid(String city) => _isCityValid(city);

  bool isEmailValid(String email) => _isEmailValid(email);

  bool isPhoneValid(String phone) => _isPhoneValid(phone);

  bool isPasswordValid(String password) => _isPasswordValid(password);

  bool isConfirmPasswordValid(String password, String confirmPassword) =>
      _isConfirmPasswordValid(password, confirmPassword);

  bool _isNameValid(String name) => name.isNotEmpty;

  bool _isGenderValid(String gender) => gender.isNotEmpty;

  bool _isDateValid(String date) => date.isNotEmpty;

  bool _isCityValid(String city) => city.isNotEmpty;

  bool _isEmailValid(String email) {
    return isValidEmail(email);
  }

  bool _isPhoneValid(String phone) {
    return isValidPhoneNumber(phone);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  bool _isConfirmPasswordValid(String password, String confirmPassword) =>
      password == confirmPassword;

  void updateUserDetails(
      String username, String birthDate, String gender, String city) {
    signupData.username = username;
    signupData.birthDate = birthDate;
    signupData.gender = gender;
    signupData.city = city;
    log("Updated user details: $signupData");
    emit(SignupUserDetailsUpdated());
  }

  void updateContactDetails(String email, String phone) {
    signupData.email = email;
    signupData.phone = phone;
    log("Updated contact details: $signupData");
    emit(SignupContactDetailsUpdated());
  }

  void updatePassword(String password) {
    signupData.password = password;
    log("Updated password: $signupData");
    emit(SignupPasswordUpdated());
  }

  void updateConfirmPassword(String confirmPassword) {
    signupData.confirmPassword = confirmPassword;
    log("Updated confirm password: $signupData");
    emit(SignupConfirmPasswordUpdated());
  }

  void updateProfileImage(String profileImage) {
    signupData.profileImage = profileImage;
    log("Updated profile image: $signupData");
    emit(SignupProfileImageUpdated());
  }

  void validateAndUpdateContactDetails(String email, String phone) {
    if (!_isEmailValid(email)) {
      emit(SignupError("البريد الإلكتروني غير صالح"));
      return;
    }

    if (!_isPhoneValid(phone)) {
      emit(SignupError("رقم الهاتف غير صالح"));
      return;
    }

    updateContactDetails(email, phone);
  }

  void submitSignup() async {
    emit(SignupLoading());
    try {
      final requestModel = SigInModelRequest(
        username: signupData.username!,
        birthDate: signupData.birthDate!,
        city: signupData.city!,
        gender: signupData.gender!,
        ProfileImage: signupData.profileImage,
        email: signupData.email!,
        password: signupData.password!,
        phone: signupData.phone!,
      );

      final response = await signupRepository.signUp(requestModel.toJson());

      if (response is SignInResponseModel) {
        emit(SignupSuccess(response.status, response.message));
      } else if (response is SignUpErrorModel) {
        emit(SignupError(response.message));
      }
    } catch (e) {
      emit(SignupError("There is a problem signing"));
    }
  }
}
