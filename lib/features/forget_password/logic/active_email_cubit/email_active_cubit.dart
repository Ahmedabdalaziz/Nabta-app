import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'email_active_state.dart';

class EmailActiveCubit extends Cubit<EmailActiveState> {
  EmailActiveCubit() : super(EmailActiveInitial());
}
