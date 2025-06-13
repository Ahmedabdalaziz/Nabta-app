import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_forget_password_otp_state.dart';

class SendForgetPasswordOtpCubit extends Cubit<SendForgetPasswordOtpState> {
  SendForgetPasswordOtpCubit() : super(SendForgetPasswordOtpInitial());
}
