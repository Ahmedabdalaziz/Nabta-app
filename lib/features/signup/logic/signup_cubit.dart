import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/core/helper/regex.dart';
import 'package:graduation_project/features/signup/data/model/custom/signup_data.dart';
import 'package:graduation_project/features/signup/data/model/custom/signup_models/sigin_model_error.dart';
import 'package:graduation_project/features/signup/data/model/custom/signup_models/sigin_model_request.dart';
import 'package:graduation_project/features/signup/data/model/custom/signup_models/sigin_model_response.dart';
import 'package:graduation_project/features/signup/data/repo/repo_signin.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository signupRepository;
  final SignupData signupData = SignupData();
  bool _isEmailChecked = false;
  bool _isCheckingEmail = false;

  SignupCubit(this.signupRepository) : super(SignupInitial());

  // دوال التحقق
  bool isNameValid(String name) => name.isNotEmpty;
  bool isGenderValid(String gender) => gender.isNotEmpty;
  bool isDateValid(String date) => date.isNotEmpty;
  bool isCityValid(String city) => city.isNotEmpty;
  bool isEmailValid(String email) => isValidEmail(email);
  bool isPhoneValid(String phone) => isValidPhoneNumber(phone);

  bool isPasswordValid(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  bool isConfirmPasswordValid(String password, String confirmPassword) =>
      password == confirmPassword;

  // تحديث بيانات المستخدم
  void updateUserDetails(String username, String birthDate, String gender, String city) {
    signupData.username = username;
    signupData.birthDate = birthDate;
    signupData.gender = gender;
    signupData.city = city;
    emit(SignupUserDetailsUpdated());
  }

  void updateContactDetails(String email, String phone) {
    signupData.email = email;
    signupData.phone = phone;
    emit(SignupContactDetailsUpdated());
  }

  void updatePassword(String password) {
    signupData.password = password;
    emit(SignupPasswordUpdated());
  }

  void updateConfirmPassword(String confirmPassword) {
    signupData.confirmPassword = confirmPassword;
    emit(SignupConfirmPasswordUpdated());
  }

  void updateProfileImage(String profileImage) {
    signupData.profileImage = profileImage;
    emit(SignupProfileImageUpdated());
  }

  Future<void> validateAndUpdateContactDetails(String email, String phone) async {
    if (!isEmailValid(email)) {
      emit(SignupError("البريد الإلكتروني غير صالح"));
      return;
    }

    if (!isPhoneValid(phone)) {
      emit(SignupError("رقم الهاتف غير صالح"));
      return;
    }

    await checkEmail(email);

    if (_isEmailChecked) {
      updateContactDetails(email, phone);
    }
  }

  Future<void> checkEmail(String email) async {
    if (_isCheckingEmail) return;
    _isCheckingEmail = true;

    if (!isEmailValid(email)) {
      emit(SignupError("البريد الإلكتروني غير صالح"));
      _isCheckingEmail = false;
      return;
    }

    emit(EmailLoadingCheck());

    try {
      await signupRepository.emailCheck(email);
      _isEmailChecked = true;
      emit(EmailNotExists());
    } on DioException catch (e) {
      _isEmailChecked = false;
      if (e.response?.statusCode == 400) {
        final responseData = e.response?.data;
        if (responseData != null && responseData['message'] == "User already exit") {
          emit(EmailAlreadyExists("هذا البريد الإلكتروني مستخدم من قبل"));
        } else {
          emit(SignupError(responseData?['message'] ?? "البريد الإلكتروني مستخدم من قبل"));
        }
      } else {
        emit(SignupError("حدث خطأ أثناء التحقق من البريد الإلكتروني"));
      }
    } catch (e) {
      _isEmailChecked = false;
      emit(SignupError("حدث خطأ غير متوقع"));
    } finally {
      _isCheckingEmail = false;
    }
  }

  Future<void> submitSignup() async {
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
      emit(SignupError("حدث خطأ أثناء التسجيل: ${e.toString()}"));
    }
  }

  void resetEmailCheck() {
    _isEmailChecked = false;
  }
}