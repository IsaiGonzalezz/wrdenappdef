import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const ChatIA());
}

class ChatIA extends StatelessWidget {
  const ChatIA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 242, 242, 242),
          secondary: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Center(child: Text('Warden IA',style: TextStyle(color: Colors.white),)),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GenerativeAISample(title: 'Chat with AI'),
      ),
    );
  }
}

class GenerativeAISample extends StatefulWidget {
  const GenerativeAISample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GenerativeAISample> createState() => _GenerativeAISampleState();
}

class _GenerativeAISampleState extends State<GenerativeAISample> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool _loading = false;
  static const _apiKey = "AIzaSyBtxYFL33FAqw-1sJk3IJS4-Lfw6AFiNls";

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey,
    );
    _chat = _model.startChat();
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, idx) {
              var content = _chat.history.toList()[idx];
              var text = content.parts
                  .whereType<TextPart>()
                  .map<String>((e) => e.text)
                  .join('');
              return MessageWidget(
                text: text,
                isFromUser: content.role == 'user',
              );
            },
            itemCount: _chat.history.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Escribe',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await _sendChatMessage(_textController.text);
                },
                icon: Icon(Icons.send,color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      var response = await _chat.sendMessage(Content.text(message));
      var text = response.text;

      if (text == null) {
        _showError('No response from API.');
      } else {
        setState(() {
          _loading = false;
        });
        _scrollDown();
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageWidget({
    Key? key,
    required this.text,
    required this.isFromUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: isFromUser ?  Color.fromARGB(255, 79, 218, 84) : const Color.fromARGB(255, 223, 220, 220),
              borderRadius: BorderRadius.circular(18),
            ),
            
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            child: MarkdownBody(
              selectable: true,
              data: text,
            ),
          ),
        ),
      ],
    );
  }
}
