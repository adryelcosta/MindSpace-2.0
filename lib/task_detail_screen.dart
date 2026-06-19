import 'package:flutter/material.dart';
import 'task_model.dart';
import 'pomodoro_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task tarefa;

  const TaskDetailScreen({super.key, required this.tarefa});

  static const Color primaryColor = Color(0xFF3B426B);
  static const Color lightBlueIcon = Color(0xFF4267B2);
  static const Color backgroundColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Row(
                          children: [
                            Icon(Icons.reply, color: lightBlueIcon, size: 28),
                            Text(
                              'Voltar',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Detalhes da Tarefa',
                          style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 180,
                          height: 1,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 30),

                        _buildDetailItem("Nome:", tarefa.name),
                        _buildDetailItem(
                          "Data:",
                          tarefa.date.isNotEmpty ? tarefa.date : "Sem data",
                        ),
                        _buildDetailItem(
                          "Observação:",
                          tarefa.description.isNotEmpty
                              ? tarefa.description
                              : "Nenhuma observação.",
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Text(
                                "Prioridade: ",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 14,
                                height: 14,
                                color: tarefa.priorityColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                tarefa.priority,
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        _buildDetailItem("Lembrete:", "Ativo"),

                        const SizedBox(height: 40),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PomodoroScreen(
                                  nomeTarefa: tarefa.name,
                                  dataTarefa: tarefa.date,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Iniciar Foco Tarefa",
                            style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
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
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(color: primaryColor, fontSize: 16),
            children: [
              TextSpan(
                text: "$label ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: value),
            ],
          ),
        ),
      ),
    );
  }
}
