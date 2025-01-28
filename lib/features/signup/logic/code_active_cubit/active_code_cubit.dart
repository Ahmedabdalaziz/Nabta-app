import 'package:bloc/bloc.dart';
import 'package:graduation_project/core/widgets/token.dart';
import 'package:graduation_project/features/signup/data/repo/repo_active_code.dart';
import 'package:meta/meta.dart';

part 'active_code_state.dart';

class ActiveCodeCubit extends Cubit<ActiveCodeState> {
  final ActivateAccountRepository repository;
  String _otp = "";

  ActiveCodeCubit(this.repository) : super(ActiveCodeInitial());

  void updateOTP(String otp) {
    _otp = otp;
  }

  String getOTP() {
    return _otp;
  }

  Future<void> activateAccount(String email, String activationCode) async {
    emit(ActiveCodeLoading());
    try {
      final result = await repository.activateAccount(email, activationCode);
      if (result.token) {
        await TokenManager().saveToken(result.token);
        emit(ActiveCodeSuccess(result.token));
      } else {
        await TokenManager().saveToken(result.token);
        emit(ActiveCodeSuccess(result.token));
      }
    } catch (e) {
      emit(ActiveCodeFailure(e.toString()));
    }
  }
}
