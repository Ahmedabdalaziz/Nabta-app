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

  // Private validation methods
  bool _isNameValid(String name) => name.isNotEmpty;

  bool _isGenderValid(String gender) => gender.isNotEmpty;

  bool _isDateValid(String date) => date.isNotEmpty;

  bool _isCityValid(String city) => city.isNotEmpty;

  bool _isEmailValid(String email) => isValidEmail(email);

  bool _isPhoneValid(String phone) => isValidPhoneNumber(phone);

  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  bool _isConfirmPasswordValid(String password, String confirmPassword) =>
      password == confirmPassword;

  // Update methods
  void updateUserDetails(
      String username, String birthDate, String gender, String city) {
    if (_isNameValid(username) &&
        _isDateValid(birthDate) &&
        _isGenderValid(gender) &&
        _isCityValid(city)) {
      signupData.username = username;
      signupData.birthDate = birthDate;
      signupData.gender = gender;
      signupData.city = city;
      log("Updated user details: $signupData");
      emit(SignupUserDetailsUpdated());
    } else {
      emit(SignupError("Please fill all fields correctly"));
    }
  }

  void updateContactDetails(String email, String phone) {
    if (_isEmailValid(email) && _isPhoneValid(phone)) {
      signupData.email = email;
      signupData.phone = phone;
      log("Updated contact details: $signupData");
      emit(SignupContactDetailsUpdated());
    } else {
      emit(SignupError("Invalid email or phone number"));
    }
  }

  void updatePassword(String password) {
    if (_isPasswordValid(password)) {
      signupData.password = password;
      log("Updated password: $signupData");
      emit(SignupPasswordUpdated());
    } else {
      emit(SignupError(
          "Password must be at least 8 characters, contain uppercase, lowercase, and numbers"));
    }
  }

  void updateProfileImage(String profileImage) {
    signupData.profileImage = profileImage;
    log("Updated profile image: $signupData");
    emit(SignupProfileImageUpdated());
  }

  void submitSignup() async {
    if (_isEmailValid(signupData.email!) &&
        _isPhoneValid(signupData.phone!) &&
        _isPasswordValid(signupData.password!)) {
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
        } else {
          emit(SignupError("Unknown error occurred"));
        }
      } catch (e) {
        emit(SignupError("Failed to sign up: ${e.toString()}"));
      }
    } else {
      emit(SignupError("Invalid email, phone, or password format"));
    }
  }
}
