import 'package:intl/intl.dart';

class MessageModel {
  final String text;
  final bool isUser;
  final String time;

  MessageModel({
    required this.text,
    required this.isUser,
    String? time,
  }) : time = time ?? DateFormat('HH:mm').format(DateTime.now());
}
