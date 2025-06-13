import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/chat/data/message_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<MessageModel> messages = [];

  final String _systemPrompt = """
أنت نبتة AI، مساعد ذكي للفلاحين في صعيد مصر، متخصص في الزراعة والنباتات فقط.

مهمتك هي تقديم معلومات دقيقة وعملية وسهلة الفهم للفلاحين حول:
1. أنواع النباتات وكيفية العناية بها (الري، الإضاءة، التسميد، التربة).
2. مشاكل النباتات (أمراض، آفات) وطرق علاجها.
3. نصائح لزراعة نباتات معينة في الظروف المحلية (خاصة في الصعيد).
4. معلومات عن التربة، الأسمدة، وأدوات الزراعة.
5. كيفية تحسين نمو النباتات في البيئات المختلفة (داخل المنزل وخارجه).
كل من سيسألك عن اسمك اخبره انك اسمك نبتة AI مرتبط ب gemini 
قواعد مهمة يجب عليك الالتزام بها:
- لا تتحدث عن أي موضوع خارج الزراعة والنباتات.
- لا تقدم نصائح طبية للبشر أو الحيوانات.
- لا تتطرق لأي موضوع سياسي أو ديني أو شخصي.
- لا تستخدم تنسيقات مثل **كلمة** أو أي رمز Markdown نهائيًا.
- اجعل اسمك دائمًا: "نبتة AI".
- تحدث بلهجة بسيطة ومهذبة ومباشرة تناسب الفلاحين، مع إضافة رموز 🌱🌿 عند الحاجة.
- إذا تم سؤالك في موضوع خارج الزراعة، اعتذر بلطف وذكّر المستخدم بأن تخصصك زراعي فقط.

تذكر دائمًا: دورك هو مساعدة الفلاحين في الزراعة وليس أي شيء آخر.

  """;

  Future<void> sendMessage(String message) async {
    messages.add(MessageModel(text: message, isUser: true));
    emit(ChatSuccess(messages));

    emit(ChatTyping());

    try {
      final response = await _callGeminiApi();
      messages.add(MessageModel(text: response, isUser: false));
      emit(ChatSuccess(messages));
    } catch (e) {
      messages
          .add(MessageModel(text: 'حدث خطأ: ${e.toString()}', isUser: false));
      emit(ChatFailure('فشل في جلب الرد: ${e.toString()}'));
    }
  }

  Future<String> _callGeminiApi() async {
    // Removed userMessage parameter
    const apiKey = 'AIzaSyBcBjjSDL1UI7GwbVllHA2VjU8nquduSvg';
    const url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$apiKey';

    List<Map<String, dynamic>> apiContents = [];

    if (messages.isEmpty ||
        (messages.isNotEmpty && messages[0].text != _systemPrompt)) {
      apiContents.add({
        'parts': [
          {'text': _systemPrompt}
        ],
        'role': 'user'
      });
      apiContents.add({
        'parts': [
          {
            'text':
                'تمام، فهمت. أنا جاهز للمساعدة في كل ما يخص الزراعة والنباتات!'
          }
        ],
        'role': 'model'
      });
    }

    for (var msg in messages) {
      if (msg.text == _systemPrompt) continue;

      apiContents.add({
        'parts': [
          {'text': msg.text}
        ],
        'role': msg.isUser ? 'user' : 'model',
      });
    }

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': apiContents,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['candidates'] != null &&
          data['candidates'].isNotEmpty &&
          data['candidates'][0]['content'] != null &&
          data['candidates'][0]['content']['parts'] != null &&
          data['candidates'][0]['content']['parts'].isNotEmpty) {
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return 'عذرًا، لم أتمكن من فهم الرد من نبتة AI.';
      }
    } else {
      throw Exception('فشل في الاتصال بـ نبتة AI ');
    }
  }
}
