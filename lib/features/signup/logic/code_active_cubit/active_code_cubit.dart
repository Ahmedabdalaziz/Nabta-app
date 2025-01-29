import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/signup/data/repo/repo_active_code.dart';
import 'package:meta/meta.dart';

part 'active_code_state.dart';

class ActiveCodeCubit extends Cubit<ActiveCodeState> {
  final ActivateAccountRepository _authRepository;

  ActiveCodeCubit(this._authRepository) : super(ActiveCodeInitial());

  Future<void> activateAccount(String email, String activationCode) async {
    emit(ActiveCodeLoading());
    try {
      final response =
          await _authRepository.activateAccount(email, activationCode);
      emit(ActiveCodeSuccess(response.token));
    } catch (e) {
      emit(ActiveCodeFailure(e.toString()));
    }
  }
}
