import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/signup/data/repo/repo_active_code.dart';
import 'package:meta/meta.dart';

part 'active_code_state.dart';

class ActiveCodeCubit extends Cubit<ActiveCodeState> {
  final ActivateAccountRepository repository;

  ActiveCodeCubit(this.repository) : super(ActiveCodeInitial());

  Future<void> activateAccount(String email, String activationCode) async {
    emit(ActiveCodeLoading());
    try {
      final result = await repository.activateAccount(email, activationCode);
      if (result is String) {
        emit(ActiveCodeSuccess(result));
      } else {
        emit(ActiveCodeFailure("An unknown error occurred"));
      }
    } catch (e) {
      emit(ActiveCodeFailure(e.toString()));
    }
  }
}
