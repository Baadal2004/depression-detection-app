import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/hospital_doctor_screen/view_list_doctor/list_nearest_doctors.dart';
import 'package:serene_space_project/patient_screen/home_screen.dart';
import 'package:serene_space_project/constant_uri.dart';

// The main chat screen widget.
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});
  final int userId; // Example user ID, replace with actual user ID if needed.

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

// The State class for the main chat screen.
class _ChatScreenState extends State<ChatScreen> {
  // A list of mock messages to display. We now use a simple data structure.
  final List<Map<String, dynamic>> _messages = [
    {
      'text': "Hello there! I'm a Medico AI. How can I assist you today?",
      'isUser': false,
    },
    //   {
    //     'text': "I'm looking for a modern UI design for a chatbot in Flutter.",
    //     'isUser': true,
    //   },
    //   {
    //     'text':
    //         "That's a great request! The code provided focuses on clean, elegant design with a user-friendly experience.",
    //     'isUser': false,
    //   },
    //   {'text': "Awesome! I'm excited to see it.", 'isUser': true},
  ];
  List<String> _questions = [];
  int _currentQuestionIndex = 0;
  bool _isAskingQuestions = false;
  final TextEditingController _textController = TextEditingController();
  int? userId;
  @override
  void initState() {
    super.initState();
    //_loadQuestions();
    userId = widget.userId;
   // print(userId);
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await _fetchQuestions();
      setState(() {
        _questions = questions;
        _currentQuestionIndex = 0;
        _isAskingQuestions = true;
      });
      if (_questions.isNotEmpty) {
        _addBotMessage(_questions[_currentQuestionIndex]);
      }
    } catch (e) {
      _addBotMessage("Sorry, couldn't load questions.");
    }
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.insert(0, {'text': text, 'isUser': false});
    });
  }

  // API endpoint URLs
  final String chatUrl =
      '${baseUrl}userapp/chat/';
  final String questionsUrl =
      '${baseUrl}userapp/questions/';

  // POST user message
  Future<void> _postUserMessage(String text) async {
    final response = await http.post(
      Uri.parse(chatUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "user_id": userId, // put the actual user id you want to send
        "message": text,
      }),
    );
   // print('POST /chat status: ${response.statusCode}');
    //print('POST /chat body: ${response.body}');
//
    // Fix the condition to properly check status code
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  // GET list of bot questions
  Future<List<String>> _fetchQuestions() async {
    final response = await http.get(Uri.parse(questionsUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> questions = data['questions'];
      return questions.cast<String>();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  // Handle input + backend communication
  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;
    _textController.clear();

    setState(() {
      _messages.insert(0, {'text': text, 'isUser': true});
    });

    String lowerText = text.trim();

    if (!_isAskingQuestions) {
      if (lowerText == 'hello' ||
          lowerText == 'hi' ||
          lowerText == 'hey' ||
          lowerText == 'hlo' ||
          lowerText == 'hii' ||
          lowerText == 'Hello' ||
          lowerText == 'Hi' ||
          lowerText == 'Hey' ||
          lowerText == 'Hlo' ||
          lowerText == 'Hii' ||
          lowerText == 'HEllO' ||
          lowerText == 'HI' ||
          lowerText == 'HEY' ||
          lowerText == 'Hllo' ||
          lowerText == 'HII' ||
          lowerText == 'HLO') {
        //  _addBotMessage("Loading questions, please wait...");
        await _loadQuestions();
      } else {
        _addBotMessage("Please say 'hello' or 'hi' to start.");
      }
      return;
    }

    try {
      await _postUserMessage(text);
    } catch (e) {
      _addBotMessage("Error sending message to server.");
      return;
    }

    _currentQuestionIndex++;
    if (_currentQuestionIndex < _questions.length) {
      _addBotMessage(_questions[_currentQuestionIndex]);
    } else {
      _addBotMessage(
        "Thank you for your answers! A medico will get in touch soon.",
      );
      _isAskingQuestions = false;
      await _showResultFlow();
    }
  }

  Future<void> _showSeverityDialog(String severity) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Severity Level'),
          content: Text('Severity: $severity'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>> _fetchPredictionResult() async {
    final url =
        '${baseUrl}userapp/get_prediction_result/$userId/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch prediction result');
    }
  }

  Future<void> _showRemedyDialog(String remedyText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remedy'),
          content: SingleChildScrollView(child: Text(remedyText)),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen(userId: userId!);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResultFlow() async {
    try {
      final prediction = await _fetchPredictionResult();
      final String severity = prediction['severity_level'] ?? '';
      final String disease = prediction['predicted_disease'] ?? '';
      final String remedy = prediction['remedy_text'] ?? '';

      await _showSeverityDialog(severity);

      if (severity.toLowerCase() == "low") {
        await showDialog<void>(
          // ignore: use_build_context_synchronously
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Predicted Disease'),
              content: SingleChildScrollView(child: Text(disease)),
              actions: <Widget>[
                TextButton(
                  child: Text('Next'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close this dialog
                    _showRemedyDialog(remedy); // Show the remedy dialog
                  },
                ),
              ],
            );
          },
        );
      } else if (severity.toLowerCase() == "medium" ||
          severity.toLowerCase() == "high") {
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => DoctorHomeScreen()),
        );
      }
    } catch (e) {
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Medico AI",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          // Expanded widget for the message list.
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // This makes the list grow from the bottom.
              itemCount: _messages.length,
              // We now build a ChatMessage widget for each message data entry.
              itemBuilder: (_, int index) => ChatMessage(
                text: _messages[index]['text'] as String,
                isUser: _messages[index]['isUser'] as bool,
              ),
            ),
          ),
          const Divider(height: 1.0),
          // Widget for the input field.
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the text input area.
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: <Widget>[
            // The text input field.
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration(
                  hintText: "Send a message...",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            // The send button.
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

// A widget to represent a single chat message.
// This is now a StatefulWidget to manage its own animation.
class ChatMessage extends StatefulWidget {
  const ChatMessage({required this.text, required this.isUser, super.key});

  final String text;
  final bool isUser;

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Each message has its own animation controller.
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    // Start the animation when the message is created.
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: widget.isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            // Display the avatar for the chatbot.
            if (!widget.isUser) ...[
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.psychology_alt_outlined, color: Colors.white),
              ),
              const SizedBox(width: 8.0),
            ],
            // The message bubble.
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: widget.isUser ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0),
                  bottomLeft: widget.isUser
                      ? const Radius.circular(20.0)
                      : Radius.zero,
                  bottomRight: widget.isUser
                      ? Radius.zero
                      : const Radius.circular(20.0),
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.isUser ? Colors.blue[900] : Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            // Display the avatar for the user.
            if (widget.isUser) ...[
              const SizedBox(width: 8.0),
              const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
