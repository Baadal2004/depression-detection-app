import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/constant_uri.dart';
import 'package:serene_space_project/utils/app_theme.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key, required this.userId});
  final int userId;

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class ChatMessage {
  final String message;
  final bool isUser;
  ChatMessage({required this.message, required this.isUser});
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add(ChatMessage(message: message, isUser: true));
      _isLoading = true;
    });
    _scrollToBottom();

    final url = Uri.parse("${baseUrl}userapp/chat/");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "message": message,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        setState(() {
          _messages.add(
            ChatMessage(
              message: data["reply"] ?? "No reply from server",
              isUser: false,
            ),
          );
          _isLoading = false;
        });
      } else {
        setState(() {
          _messages.add(
            ChatMessage(
              message: "Error: Server returned ${response.statusCode}",
              isUser: false,
            ),
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(message: "Network Error: $e", isUser: false));
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SereneTheme.lightPink,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'AI Assistant',
          style: TextStyle(color: SereneTheme.darkPink, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: SereneTheme.darkPink,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Hi! I'm your AI Assistant 🤖\nHow can I help you today?",
              textAlign: TextAlign.center,
              style: TextStyle(color: SereneTheme.textSecondary, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _chatBubble(isUser: msg.isUser, message: msg.message);
              },
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(color: SereneTheme.primaryPink),
            ),

          _messageInputBar(),
        ],
      ),
    );
  }

  Widget _chatBubble({required bool isUser, required String message}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) _avatar(),
          Flexible(
            child: Container(
              margin: isUser
                  ? const EdgeInsets.only(left: 40)
                  : const EdgeInsets.only(right: 40),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: isUser ? SereneTheme.primaryPink : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isUser ? Colors.white : SereneTheme.textMain,
                  fontSize: 17, // Larger for elderly
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (isUser) _avatar(isUser: true),
        ],
      ),
    );
  }

  Widget _avatar({bool isUser = false}) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: isUser ? SereneTheme.primaryPink.withOpacity(0.1) : Colors.white,
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        color: SereneTheme.darkPink,
        size: 24,
      ),
    );
  }

  Widget _messageInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: SereneTheme.textMain),
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: const TextStyle(color: SereneTheme.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: SereneTheme.lightPink,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onSubmitted: (val) {
                final message = val.trim();
                if (message.isNotEmpty && !_isLoading) {
                  sendMessage(message);
                  _controller.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              final text = _controller.text.trim();
              if (text.isNotEmpty && !_isLoading) {
                sendMessage(text);
                _controller.clear();
              }
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: SereneTheme.primaryPink,
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
