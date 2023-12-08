// Este es un gestor de estado que usará PROVIDER, pero hay muchos otros que también vale la pena aprender

import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answers.dart';
import 'package:yes_no_app/domain/entities/message.dart';

// Puede notificar cuando hay cambios
class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: "Hola bro!", fromWho: FromWho.me),
    Message(text: "Terminaste de trabajar?", fromWho: FromWho.me)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if (text.endsWith("?")) {
      getReply();
    }

    // Notificamos del cambio a todos los listeners
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> getReply() async {
    final messageReply = await getYesNoAnswer.getAnswer();
    messageList.add(messageReply);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    // Esperamos para que no se congele
    await Future.delayed(const Duration(milliseconds: 100));

    // offset posicion, duración y animación
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
