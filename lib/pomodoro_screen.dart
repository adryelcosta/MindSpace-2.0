import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroScreen extends StatefulWidget {
  final String nomeTarefa;
  final String dataTarefa;

  const PomodoroScreen({
    super.key,
    required this.nomeTarefa,
    required this.dataTarefa,
  });

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const Color primaryColor = Color(0xFF3B426B);
  static const Color lightBlueIcon = Color(0xFF4267B2);

  int _segundosRestantes = 1500;
  Timer? _timer;
  bool _estaRodando = false;

  void _iniciarOuPausarTimer() {
    if (_estaRodando) {
      _timer?.cancel();
      setState(() {
        _estaRodando = false;
      });
    } else {
      setState(() {
        _estaRodando = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_segundosRestantes > 0) {
            _segundosRestantes--;
          } else {
            _timer?.cancel();
            _estaRodando = false;
          }
        });
      });
    }
  }

  Future<void> _editarTempo() async {
    if (_estaRodando) _iniciarOuPausarTimer();

    final TextEditingController tempoController = TextEditingController(
      text: (_segundosRestantes ~/ 60).toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Definir Tempo de Foco",
          style: TextStyle(color: primaryColor),
        ),
        content: TextField(
          controller: tempoController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Minutos",
            hintText: "Ex: 25, 45, 60",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final minutos = int.tryParse(tempoController.text);
              if (minutos != null && minutos > 0) {
                setState(() {
                  _segundosRestantes = minutos * 60;
                });
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            child: const Text("Definir", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  String _formatarTempo() {
    int minutos = _segundosRestantes ~/ 60;
    int segundos = _segundosRestantes % 60;
    return '${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings_suggest_outlined,
                      color: lightBlueIcon,
                      size: 35,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'MindSpace',
                      style: TextStyle(color: primaryColor, fontSize: 22),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                const Text(
                  'Modo Foco',
                  style: TextStyle(
                    fontSize: 24,
                    color: primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                Container(width: 250, height: 1.5, color: Colors.grey[400]),

                const SizedBox(height: 40),

                GestureDetector(
                  onTap: _editarTempo,
                  child: Tooltip(
                    message: "Clique para alterar o tempo",
                    child: Text(
                      _formatarTempo(),
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: _iniciarOuPausarTimer,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Icon(
                      _estaRodando ? Icons.pause : Icons.play_arrow,
                      size: 60,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Text(
                        "Nome: ${widget.nomeTarefa}",
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Data: ${widget.dataTarefa}",
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // APENAS O BOTÃO "SAIR DO FOCO" CENTRALIZADO
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 45,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Sair do Foco",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 60,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
