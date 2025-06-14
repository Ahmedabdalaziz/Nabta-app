part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatSuccess(this.messages);
}

class ChatTyping extends ChatState {}

class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);
}
