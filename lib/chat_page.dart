import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    final text = _chatController.text.trim();
    if (text.isNotEmpty) {
      _insertMessage({"sender": "user", "text": text});
      _chatController.clear();

      // Simulasi balasan otomatis
      Future.delayed(const Duration(seconds: 1), () {
        _insertMessage({
          "sender": "bot",
          "text":
              "Terima kasih sudah menghubungi MystiCat 🐾\nPesanmu akan segera kami sampaikan ke penjual.\nSelamat berbelanja!",
        });
      });
    }
  }

  void _insertMessage(Map<String, String> message) {
    _messages.insert(0, message);
    _listKey.currentState?.insertItem(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 135, 135),
                Color.fromARGB(255, 251, 112, 112),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Chat dengan Penjual",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              reverse: true,
              padding: const EdgeInsets.all(16),
              initialItemCount: _messages.length,
              itemBuilder: (context, index, animation) {
                final msg = _messages[index];
                final isUser = msg["sender"] == "user";

                return SizeTransition(
                  sizeFactor: animation,
                  child: Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser
                            ? const Color.fromARGB(255, 251, 112, 112)
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(
                            isUser ? 16 : 0,
                          ), // tail bubble
                          bottomRight: Radius.circular(
                            isUser ? 0 : 16,
                          ), // tail bubble
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        msg["text"]!,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black87,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// === Input Chat + Tombol Send ===
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      decoration: InputDecoration(
                        hintText: "Ketik pesan...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFFFF5F7),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 251, 112, 112),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
