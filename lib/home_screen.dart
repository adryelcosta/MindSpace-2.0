import 'package:flutter/material.dart';
import 'task_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _avancarParaTarefas(String nomeDigitado) {
    final nomeFinal = nomeDigitado.trim().isEmpty
        ? "Usuário"
        : nomeDigitado.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskListScreen(userName: nomeFinal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF3B426B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF4267B2),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.settings_suggest_outlined,
                      size: 35,
                      color: Color(0xFF4267B2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Antes de iniciar a organizar sua rotina escolha um nome para o seu usuário',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 60),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Usuário:',
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _textController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Digite seu nome",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontSize: 18,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onSubmitted: _avancarParaTarefas,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(width: double.infinity, height: 60, color: primaryColor),
        ],
      ),
    );
  }
}
