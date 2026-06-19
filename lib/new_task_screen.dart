import 'package:flutter/material.dart';
import 'task_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  static const Color primaryColor = Color(0xFF3B426B);
  static const Color lightBlueIcon = Color(0xFF4267B2);
  static const Color backgroundColor = Color(0xFFD9D9D9);

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _obsController = TextEditingController();

  String _prioridadeSelecionada = "Média"; 
  Color _corPrioridade = Colors.yellow[600]!;

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
                      Icon(Icons.settings_suggest_outlined, color: lightBlueIcon, size: 35),
                      SizedBox(width: 8),
                      Text('MindSpace', style: TextStyle(color: primaryColor, fontSize: 22)),
                    ],
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Row(
                          children: [
                            Icon(Icons.reply, color: lightBlueIcon, size: 28),
                            Text('Voltar', style: TextStyle(color: primaryColor, fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      children: [
                        const Text('Nova Tarefa', style: TextStyle(fontSize: 24, color: primaryColor, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5),
                        Container(width: 180, height: 1, color: Colors.grey[400]),
                        const SizedBox(height: 25),

                        _buildLabel("Nome:"),
                        _buildTextField(_nomeController),

                        _buildLabel("Data:"),
                        _buildTextField(_dataController),

                        _buildLabel("Observação:"),
                        _buildTextField(_obsController, maxLines: 3),

                        const SizedBox(height: 15),

                        _buildLabel("Prioridade:"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildPriorityBox("Alta", Colors.red[700]!),
                              _buildPriorityBox("Média", Colors.yellow[600]!),
                              _buildPriorityBox("Baixa", Colors.green[700]!),
                            ],
                          ),
                        ),

                        const SizedBox(height: 35),

                        ElevatedButton(
                          onPressed: () {
                            if (_nomeController.text.trim().isEmpty) return;

                            // Retorna o objeto Task preenchido para a lista
                            Navigator.pop(
                              context,
                              Task(
                                name: _nomeController.text,
                                date: _dataController.text.isNotEmpty ? _dataController.text : "Sem Data",
                                description: _obsController.text,
                                priority: _prioridadeSelecionada,
                                priorityColor: _corPrioridade,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text("Salvar", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(width: double.infinity, height: 60, color: primaryColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, top: 8),
        child: Text(text, style: const TextStyle(color: primaryColor, fontSize: 15)),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightBlueIcon)),
      ),
    );
  }

  Widget _buildPriorityBox(String label, Color color) {
    bool isSelected = _prioridadeSelecionada == label;
    return GestureDetector(
      onTap: () => setState(() {
        _prioridadeSelecionada = label;
        _corPrioridade = color;
      }),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              border: isSelected ? Border.all(color: Colors.black, width: 2) : Border.all(color: Colors.grey, width: 0.5),
            ),
          ),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 13, color: primaryColor)),
        ],
      ),
    );
  }
}