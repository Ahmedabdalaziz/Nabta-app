import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_error.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_request.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_response.dart';
import 'package:graduation_project/features/signup/data/model/custom/signup_data.dart';
import 'package:graduation_project/features/signup/data/repo/repo_signin.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository signupRepository;
  final SignupData signupData = SignupData();

  SignupCubit(this.signupRepository) : super(SignupInitial());

  bool _isEmailValid(String email) {
    // تحقق من صحة البريد الإلكتروني باستخدام تعبير عادي (Regex)
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    // تحقق من أن كلمة المرور تحتوي على 8 أحرف على الأقل
    return password.length >= 8;
  }

  // دوال التحديث المختلفة في SignupCubit
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

  void updateProfileImage(String profileImage) {
    signupData.profileImage = profileImage;
    log("Updated profile image: $signupData");
    emit(SignupProfileImageUpdated());
  }

  void submitSignup() async {
    if (_isEmailValid(signupData.email!) &&
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
        log("Submitting signup with data: ${requestModel.toJson()}");
        final response = await signupRepository.signUp(requestModel.toJson());
        if (response is SignInResponseModel) {
          emit(SignupSuccess());
        } else if (response is SignUpErrorModel) {
          emit(SignupError(response.message));
        } else {
          emit(SignupError("Unknown error occurred"));
        }
      } catch (e) {
        emit(SignupError("Failed to sign up: ${e.toString()}"));
      }
    } else {
      emit(SignupError("Invalid email or password format"));
    }
  }
}
