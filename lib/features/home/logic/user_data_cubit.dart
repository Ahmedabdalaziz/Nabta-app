import 'package:bloc/bloc.dart';
import 'package:graduation_project/core/helper/token.dart';
import 'package:graduation_project/features/home/data/model/user_data_request.dart';
import 'package:graduation_project/features/home/data/repo/user_data_repo.dart';
import 'package:meta/meta.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final UserDataRepo userDataRepo;
  String? token;

  UserDataCubit(this.userDataRepo) : super(UserDataInitial());

  Future<void> fetchData() async {
    emit((UserDataLoading()));
    try {
      token ??= await _getToken();

      final dataResponse = await userDataRepo.getUserData(token!);
      emit(UserDataSuccess(userData: dataResponse));
    } on Exception catch (e) {
      emit(UserDataError(errorMessage: e.toString()));
    }
  }

  Future<String?> _getToken() async {
    final TokenManager tokenManager = TokenManager();
    return await tokenManager.getToken();
  }
}
